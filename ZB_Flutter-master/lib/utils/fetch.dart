import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import '../globals.dart' as globals;
import 'package:fluttertoast/fluttertoast.dart';

/*
 * 封装 restful 请求
 * 
 * GET、POST、DELETE、PATCH
 * 主要作用为统一处理相关事务：
 *  - 统一处理请求前缀；
 *  - 统一打印请求信息；
 *  - 统一打印响应信息；
 *  - 统一打印报错信息；
 */
class HttpUtils {

  /// global dio object
  static Dio dio;

  /// default options
  static const String API_PREFIX = 'http://39.108.177.24:11401/gateway/main/restapi';
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 3000;

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  /// request method
  static Future<Map> request (
    String url, 
    { data, method }) async {

    data = data ?? {};
    method = method ?? 'GET';

    /// restful 请求处理   
    /// /gysw/search/hist/:user_id        user_id=27
    /// 最终生成 url 为     /gysw/search/hist/27
    data.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });

    /// 打印请求相关信息：请求地址、请求方式、请求参数
    print('请求地址：【' + method + '  ' + url + '】');
    print('请求参数：' + data.toString());

    Dio dio = createInstance();
    var result;

    try {
      print(url);
      Response response = await dio.request(url, data: data, options: new Options(method: method));
      result = response.data;
      /// 打印响应相关信息
      print('响应数据：' + response.toString());
      if(result['code']!='S0000000'){
        Fluttertoast.showToast(
          msg: result['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
        );
        if(result['code']=='E0000007'){
        
        }
        return null;

      }
    
      else {

        return result;
      }
    } on DioError catch (e) {
      /// 打印请求失败相关信息
      print('请求出错：' + e.toString());
      } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: '后台服务异常',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
        );
    } 
  }

  /// 创建 dio 实例对象
  static Dio createInstance () {
    if (dio == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      // Options options = new Options(
      //     baseUrl: API_PREFIX,
      //     connectTimeout: CONNECT_TIMEOUT,
      //     receiveTimeout: RECEIVE_TIMEOUT,
      // );

      // dio = new Dio(options);

      dio = new Dio(); // with default Options
      // Set default configs
      dio.options.baseUrl = API_PREFIX;
      dio.options.connectTimeout =  CONNECT_TIMEOUT; //5s
      dio.options.receiveTimeout = RECEIVE_TIMEOUT;
      if(globals.isLoggedIn)dio.options.headers["token"]=globals.token;
    }

    return dio;
  }

  /// 清空 dio 对象
  static clear () {
    dio = null;
  }

}