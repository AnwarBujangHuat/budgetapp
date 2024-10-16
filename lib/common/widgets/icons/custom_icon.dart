import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/utils/utils.dart';
import 'package:budgetapp/common/viewmodel/tag/tag_viewmodel.dart';
import 'package:budgetapp/domain/models/tags/tag_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class IBIcon extends ConsumerWidget {
  final int tagId;
  final double size;

  const IBIcon({
    required this.tagId,
    super.key,
    this.size = 32.0,
  });

  @override
  Widget build(BuildContext context, ref) {
    ThemeData currentTheme = Theme.of(context);
    AsyncValue<List<TagModel>> asyncValue = ref.watch(tagViewmodelProvider);
    return asyncValue.map(
      data: (tagList) {
        TagModel currentTag = TagModel(
            parentTagId: 1,
            tagId: tagId,
            tagName: '-',
            icon: IconModel(codePaint: 57455, fontFamily: 'MaterialIcons'),
            color: 'FFFFF');

        for (var tag in tagList.requireValue) {
          if (tag.tagId == tagId) {
            currentTag = tag;
            break;
          }
        }

        IconModel icon = currentTag.icon;

        return IconWidget(
          iconData: IconData(icon.codePaint, fontFamily: icon.fontFamily),
          size: size,
          backgroundColor: getColorFromHex(currentTag.color),
        );
      },
      error: (error) {
        return IconWidget(
          iconData: Icons.error,
          size: size,
          backgroundColor: AppColors.lightRed,
        );
      },
      loading: (loading) {
        return Shimmer.fromColors(
            child: IconWidget(
              iconData: Icons.error,
              size: size,
              backgroundColor: AppColors.lightRed,
            ),
            baseColor: currentTheme.cardColor.withAlpha(1),
            highlightColor: currentTheme.cardColor.withAlpha(1));
      },
    );
  }
}

class IconWidget extends StatelessWidget {
  const IconWidget(
      {required this.iconData,
      this.size = 32.0,
      super.key,
      this.backgroundColor});
  final Color? backgroundColor;
  final IconData iconData;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      radius: size / 2,
      child: Icon(
        iconData,
        color: Colors.white,
        size: size * 0.6, // Adjust icon size as needed
      ),
    );
  }
}
