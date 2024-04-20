import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../internal/extension.dart';
import '../providers/bangumi_model.dart';
import 'aria_repository.dart';

void downloadwithAria(BuildContext context, String magnet) {
  String? name;

  try {
    name = context.read<BangumiModel>().bangumiDetail?.name;
    // ignore: empty_catches
  } catch (err) {}

  context
      .read<AriaRepository>()
      .addMagnet(magnet, relativePath: name)
      .then((error) {
    if (error != null) {
      error.toast();
    } else {
      '添加成功'.toast(
        duration: const Duration(seconds: 5),
      );
    }
  });
}
