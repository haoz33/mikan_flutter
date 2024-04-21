import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../internal/extension.dart';
import '../internal/hive.dart';
import '../model/bangumi_details.dart';
import '../providers/bangumi_model.dart';
import 'aria_repository.dart';

void downloadwithAria(BuildContext context, String magnet) {
  BangumiDetail? bangumiDetail;

  try {
    bangumiDetail = context.read<BangumiModel>().bangumiDetail;
    // ignore: empty_catches
  } catch (err) {}

  context
      .read<AriaRepository>()
      .addMagnet(magnet, relativePath: bangumiDetail?.name)
      .then(
    (error) {
      if (error != null) {
        error.toast();
      } else {
        '添加成功'.toast(
          duration: const Duration(seconds: 5),
        );

        if (bangumiDetail != null) {
          MyHive.addDownloadedTorrent(magnet);
        }
      }
    },
  );
}

String encodeTorrentName(String name) {
  return md5.convert(utf8.encode(name)).toString();
}
