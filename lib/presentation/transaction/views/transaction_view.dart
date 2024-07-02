import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/widgets/button/outlined_button.dart';
import 'package:budgetapp/common/widgets/button/text_button.dart';
import 'package:budgetapp/common/widgets/button/transaction_type_button.dart';
import 'package:budgetapp/common/widgets/calculator/calculator.dart';
import 'package:budgetapp/common/widgets/size_box/sized_boxes.dart';
import 'package:budgetapp/common/widgets/text_field/ib_text__form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

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
          IBOutlinedButton(
            backgroundColor: AppColors.white,
            title: DateFormat('dd MMM yy')
                .format(DateTime(DateTime.now().year, DateTime.september)),
            icon: Icon(Icons.calendar_month),
            onTap: () async {
              await showDatePicker(
                context: context,
                initialEntryMode: DatePickerEntryMode.calendarOnly,
                initialDate: DateTime.now(),
                firstDate: DateTime(DateTime.now().year - 10),
                lastDate: DateTime(DateTime.now().year + 10),
              );
            },
          ),
          Row(
            children: [
              Expanded(
                child: IBOutlinedButton(
                  title: 'Default Category',
                  backgroundColor: AppColors.white,
                  icon: Icon(Icons.arrow_drop_down),
                  onTap: () {},
                ),
              ),
              IBSizedW10(),
              Expanded(
                  child: IBTransactionTypeWidget(
                backgroundColor: AppColors.white,
              ))
            ],
          ),
          IBSizedH05(),
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: IBTextFormField(
                    hintText: 'Notes',
                    trailingButton: IconButton(
                        onPressed: () {}, icon: Icon(Icons.attachment)),
                  ))
            ],
          ),
          IBCalculatorWidget(),
        ],
      ),
    );
  }
}
