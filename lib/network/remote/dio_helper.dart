import 'package:dio/dio.dart';
import 'package:paymob/network/constance/constance.dart';

class DioHelper {
  static late Dio dio;

  init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstance.baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String,dynamic>? query,
    required Map<String,dynamic> data,
  }) async {
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
