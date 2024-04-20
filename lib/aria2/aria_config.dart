import 'package:hive/hive.dart';

import '../internal/hive.dart';

part 'aria_config.g.dart';

@HiveType(typeId: MyHive.ariaConfig)
class AriaConfig extends HiveObject {
  AriaConfig({
    required this.domain,
    this.downloadPath = '/',
    this.rpcPath = 'jsonrpc',
    this.port = '6800',
    this.scheme = 'http',
    this.useBangumiPathName = true,
    this.secret,
  });

  // 番剧的id
  @HiveField(0)
  String domain;

  // 更新时间
  @HiveField(1)
  String port;

  @HiveField(2)
  String rpcPath;

  @HiveField(3)
  String scheme;

  @HiveField(4)
  String? secret;

  @HiveField(5)
  String downloadPath;

  @HiveField(6)
  bool useBangumiPathName;

  String get url => '$scheme://$domain:$port/$rpcPath';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AriaConfig &&
          runtimeType == other.runtimeType &&
          domain == other.domain &&
          port == other.port &&
          rpcPath == other.rpcPath &&
          scheme == other.scheme &&
          secret == other.secret &&
          downloadPath == other.downloadPath &&
          useBangumiPathName == other.useBangumiPathName;

  @override
  int get hashCode =>
      domain.hashCode ^
      port.hashCode ^
      rpcPath.hashCode ^
      scheme.hashCode ^
      secret.hashCode ^
      downloadPath.hashCode ^
      useBangumiPathName.hashCode;
}
