import 'package:budgetapp/common/widgets/button/text_button.dart';
import 'package:budgetapp/common/widgets/calculator/calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TransactionPage extends ConsumerWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: IBCalculatorWidget(),
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
            title: 'Submit',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
