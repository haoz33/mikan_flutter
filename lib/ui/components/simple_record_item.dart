import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../internal/extension.dart';
import '../../internal/hive.dart';
import '../../model/record_item.dart';
import '../../topvars.dart';
import '../../widget/icon_button.dart';
import '../../widget/ripple_tap.dart';
import '../../widget/transition_container.dart';
import '../pages/record.dart';

@immutable
class SimpleRecordItem extends StatelessWidget {
  const SimpleRecordItem({
    super.key,
    required this.record,
  });

  final RecordItem record;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tagStyle = theme.textTheme.labelSmall!.copyWith(
      color: theme.colorScheme.onTertiaryContainer,
    );
    final sizeStyle = theme.textTheme.labelSmall!.copyWith(
      color: theme.colorScheme.onSecondaryContainer,
    );
    final closedColor = ElevationOverlay.applySurfaceTint(
      theme.cardColor,
      theme.colorScheme.surfaceTint,
      1.0,
    );

    return TransitionContainer(
      closedColor: closedColor,
      builder: (context, open) {
        return RippleTap(
          onTap: open,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              bottom: 4.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  record.title,
                  style: theme.textTheme.bodyMedium,
                ),
                sizedBoxH8,
                Wrap(
                  runSpacing: 6.0,
                  spacing: 6.0,
                  children: [
                    if (record.size.isNotBlank)
                      Container(
                        padding: edgeH6V4,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondaryContainer,
                          borderRadius: borderRadius8,
                        ),
                        child: Text(record.size, style: sizeStyle),
                      ),
                    if (!record.tags.isNullOrEmpty)
                      for (final tag in record.tags)
                        Container(
                          padding: edgeH6V4,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.tertiaryContainer,
                            borderRadius: borderRadius8,
                          ),
                          child: Text(tag, style: tagStyle),
                        ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        record.publishAt,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                    sizedBoxW8,
                    _DownloadedIcon(
                      record: record,
                    ),
                    TMSMenuButton(
                      torrent: record.torrent,
                      magnet: record.magnet,
                      share: record.share,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      next: RecordPage(record: record),
    );
  }
}

class _DownloadedIcon extends StatelessWidget {
  const _DownloadedIcon({required this.record});
  final RecordItem record;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: MyHive.downloadedTorrent.listenable(),
      builder: (BuildContext context, box, Widget? child) {
        final isDownloaded = MyHive.isTorrentDownloaded(record.magnet);
        if (isDownloaded) {
          return const Icon(
            Icons.check_circle,
          );
        }
        return child!;
      },
      child: const SizedBox.shrink(),
    );
  }
}
