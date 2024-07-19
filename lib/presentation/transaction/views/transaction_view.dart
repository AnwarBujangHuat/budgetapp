import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/viewmodel/tag/tag_viewmodel.dart';
import 'package:budgetapp/common/widgets/button/outlined_button.dart';
import 'package:budgetapp/common/widgets/button/text_button.dart';
import 'package:budgetapp/common/widgets/button/transaction_type_button.dart';
import 'package:budgetapp/common/widgets/calculator/calculator.dart';
import 'package:budgetapp/common/widgets/size_box/sized_boxes.dart';
import 'package:budgetapp/common/widgets/text_field/ib_text__form_field.dart';
import 'package:budgetapp/domain/models/tags/tag_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TransactionPage extends ConsumerWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.transaction),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          child: BackButton(),
        ),
        actions: [
          IBTextButton(
            title: AppLocalizations.of(context)!.add,
            onTap: () {},
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ],
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        children: [
          IBSizedH05(),
          Row(
            children: [
              IBSizedW10(),
              TransactionTypeSelect(),
              Expanded(
                  child: IBTransactionTypeWidget(
                backgroundColor: AppColors.white,
              ))
            ],
          ),
          IBSizedH05(),
          Card(
            elevation: 1,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: IBTextFormField(
              hintText: AppLocalizations.of(context)!.notes,
              trailingButton:
                  IconButton(onPressed: () {}, icon: Icon(Icons.attachment)),
            ),
          ),
          IBCalculatorWidget(
            maxHeight: MediaQuery.of(context).size.height * .73,
          ),
        ],
      ),
    );
  }
}

class TransactionTypeSelect extends ConsumerWidget {
  const TransactionTypeSelect({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<TagModel>> tagProvider = ref.watch(tagViewmodelProvider);

    Widget bodyWidget() {
      switch (tagProvider) {
        case AsyncData(:final value):
          return Expanded(
            child: IBOutlinedButton(
              title: value[0].tagName,
              borderColors: Colors.transparent,
              backgroundColor: AppColors.white,
              icon: Icon(Icons.arrow_drop_down),
              onTap: () {},
            ),
          );
        case AsyncError(:final error):
          return Text(error.toString());
        default:
          return Container();
      }
    }

    return bodyWidget();
  }
}
