import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../internal/extension.dart';
import '../internal/hive.dart';
import 'aria_config.dart';
import 'aria_repository.dart';

class AriaSettingModel extends ChangeNotifier {
  AriaSettingModel() {
    init();
  }

  late AriaConfig config;

  void init() {
    final currentConfig = MyHive.getAriaSetting();
    if (currentConfig == null) {
      config = AriaConfig(domain: '192.168.1.1');
      MyHive.setAriaSetting(config);
    } else {
      config = currentConfig;
    }
  }

  void save({
    required String domain,
    required String port,
    required String rpcPath,
    required String secret,
    required String downloadPath,
    required BuildContext context,
  }) {
    config = AriaConfig(
      domain: domain,
      port: port,
      rpcPath: rpcPath,
      downloadPath: downloadPath,
      secret: secret.isEmpty ? null : secret,
    );
    MyHive.setAriaSetting(config);
    context.read<AriaRepository>().updateConfig(config);
    '保存成功'.toast();
  }
}
