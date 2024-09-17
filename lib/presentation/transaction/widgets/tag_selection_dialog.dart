import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/utils/utils.dart';
import 'package:budgetapp/common/widgets/button/outlined_button.dart';
import 'package:budgetapp/common/widgets/icons/custom_icon.dart';
import 'package:budgetapp/common/widgets/size_box/sized_boxes.dart';
import 'package:budgetapp/domain/models/tags/tag_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TagSelectionDialog extends StatefulWidget {
  const TagSelectionDialog({required this.tagList, super.key});
  final List<TagModel> tagList;
  @override
  State<TagSelectionDialog> createState() => _TagSelectionDialogState();
}

class _TagSelectionDialogState extends State<TagSelectionDialog> {
  TagModel? selectedTag;
  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns
                  crossAxisSpacing: 8.0, // Horizontal spacing between items
                  mainAxisSpacing: 8.0, // Vertical spacing between items
                ),
                itemCount: widget.tagList.length,
                itemBuilder: (context, index) {
                  TagModel item = widget.tagList[index];
                  return GestureDetector(
                    onTap: () => setState(() {
                      selectedTag = item;
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(AppSize.paddingSmall)),
                        color: item != selectedTag
                            ? currentTheme.dialogBackgroundColor
                            : currentTheme.scaffoldBackgroundColor,
                      ),
                      padding: const EdgeInsets.all(AppSize.paddingSmall),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconWidget(
                            size: 42,
                            iconData: IconData(item.icon.codePaint,
                                fontFamily: item.icon.fontFamily),
                            backgroundColor: getColorFromHex(item.color),
                          ),
                          IBSizedH10(),
                          Text(
                            textAlign: TextAlign.center,
                            item.tagName,
                            style: TextStyle(fontSize: FontSize.body),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            IBSizedH10(),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                      child: IBOutlinedButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    titleBuilder: Builder(
                      builder: (context) => Text(
                        AppLocalizations.of(context)!.cancel,
                        style: TextStyle(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    backgroundColor: currentTheme.dialogBackgroundColor,
                    borderColors: currentTheme.shadowColor,
                  )),
                  IBSizedW10(),
                  Expanded(
                    child: IBOutlinedButton(
                      onTap: () {
                        Navigator.pop(context, selectedTag);
                      },
                      titleBuilder: Builder(
                        builder: (context) => Text(
                          AppLocalizations.of(context)!.okay,
                          style: TextStyle(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      backgroundColor: AppColors.darkBlueBlack,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
