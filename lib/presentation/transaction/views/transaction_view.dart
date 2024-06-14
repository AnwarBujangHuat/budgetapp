import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/widgets/button/outlined_button.dart';
import 'package:budgetapp/common/widgets/button/text_button.dart';
import 'package:budgetapp/common/widgets/button/transaction_type_button.dart';
import 'package:budgetapp/common/widgets/calculator/calculator.dart';
import 'package:budgetapp/common/widgets/size_box/sized_boxes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TransactionPage extends ConsumerWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: IBOutlinedButton(
                    title: 'Category',
                    onTap: () {},
                  ),
                ),
                IBSizedW05(),
                Expanded(child: IBTransactionTypeWidget())
              ],
            ),
          ),
          Expanded(
            child: IBCalculatorWidget(),
          ),
        ],
      ),
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
    );
  }
}
