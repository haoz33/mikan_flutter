import 'dart:convert';

import 'package:dio/dio.dart';

import 'aria_config.dart';

class AriaRepository {
  AriaRepository({required this.config});
  final dio = Dio();

  AriaConfig? config;

  // ignore: use_setters_to_change_properties
  void updateConfig(AriaConfig config) {
    this.config = config;
  }

  Future<String?> addMagnet(String magnet, {String? relativePath}) async {
    if (config == null) {
      return '未找到Aria2配置';
    }

    String dir = config!.downloadPath;
    if (relativePath != null) {
      dir = '$dir/${relativePath.replaceAll('/', '')}';
    }

    final json = jsonEncode({
      'jsonrpc': '2.0',
      'id': 'MIKAN_PROJECT_ARIA2',
      'method': 'aria2.addUri',
      'params': [
        if (config!.secret != null) 'token:${config!.secret}',
        [magnet],
        {'dir': dir},
      ],
    });

    try {
      final res = await dio.post(config!.url, data: json);

      if (res.statusCode == 200) {
        return null;
      }

      return null;
    } on DioException catch (e) {
      // DioError is thrown for HTTP status errors
      if (e.response != null) {
        final resposeData = e.response?.data == null
            ? ''
            : '\nnResponse data: ${e.response!.data}';

        return 'HTTP status code: ${e.response!.statusCode}$resposeData';
      } else {
        return 'Dio error: ${e.message}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
