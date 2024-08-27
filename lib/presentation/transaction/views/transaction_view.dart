import 'dart:async';

import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/const/const.dart';
import 'package:budgetapp/common/utils/utils.dart';
import 'package:budgetapp/common/viewmodel/tag/tag_viewmodel.dart';
import 'package:budgetapp/common/viewmodel/transaction/transaction_viewmodel.dart';
import 'package:budgetapp/common/widgets/button/outlined_button.dart';
import 'package:budgetapp/common/widgets/button/text_button.dart';
import 'package:budgetapp/common/widgets/button/transaction_type_button.dart';
import 'package:budgetapp/common/widgets/calculator/calculator.dart';
import 'package:budgetapp/common/widgets/size_box/sized_boxes.dart';
import 'package:budgetapp/common/widgets/text_field/ib_text__form_field.dart';
import 'package:budgetapp/domain/models/tags/tag_model.dart';
import 'package:budgetapp/domain/models/transaction/transaction_model.dart';
import 'package:budgetapp/presentation/transaction/widgets/tag_selection_dialog.dart';
import 'package:budgetapp/shared/dialog/ib_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TransactionPage extends ConsumerStatefulWidget {
  const TransactionPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransactionPageState();
}

class _TransactionPageState extends ConsumerState<TransactionPage> {
  TagModel? selectedTag;
  TransactionType selectedTransactionType = TransactionType.out;
  TransactionModel? newTransaction;
  late TextEditingController noteController;

  /// Controller for calculator.
  double calculatorValue = 0;
  @override
  void initState() {
    super.initState();
    noteController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    noteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(addNewTransactionNotifierProvider, (prev, current) {
      switch (current) {
        case AsyncData(:final value):
          if (value != null && value) {
            const snackBar = SnackBar(
              content: Text('Yay! A SnackBar!'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        case AsyncError(:final error):

          /// Dismiss if there is any dialog showing
          if (isThereCurrentDialogShowing(context)) {
            Navigator.pop(context);
          }
          showDialog(
            context: context,
            builder: (context) => AlertDialog(content: Text(error.toString())),
          );
      }
    });
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
            onTap: () async {
              if (selectedTag != null) {
                /// Create a new Transaction
                newTransaction = TransactionModel(
                  type: selectedTransactionType,
                  title: selectedTag!.tagName,
                  description: noteController.text,
                  dateTime: DateTime.now(),
                  transactionAmount: calculatorValue.toString(),
                  tagId: selectedTag!.tagId,
                  parentTagId: selectedTag!.parentTagId,
                  attachmentUrl:
                      'https://img.freepik.com/free-vector/realistic-receipt-template_23-2147938550.jpg?t=st=1721825445~exp=1721829045~hmac=e600207f2739a82e4fea660e62604d21102ac53795c8758d2c24a32c80740545&w=826',
                );
              }
              if (newTransaction != null) {
                await ref
                    .read(addNewTransactionNotifierProvider.notifier)
                    .addNewTransaction(newTransaction: newTransaction!);
                Navigator.pop(context);
              }
            },
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
              Expanded(
                child: TransactionTypeSelect(
                  selectedTag: selectedTag,
                  onSelectTag: (tag) => setState(() => selectedTag = tag),
                ),
              ),
              IBSizedW10(),
              Expanded(
                  child: IBTransactionTypeWidget(
                transactionType: selectedTransactionType,
                onChange: (type) => setState(() => selectedTransactionType =
                    type == TransactionType.income
                        ? TransactionType.out
                        : TransactionType.income),
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
              controller: noteController,
              hintText: AppLocalizations.of(context)!.notes,
              trailingButton:
                  IconButton(onPressed: () {}, icon: Icon(Icons.attachment)),
            ),
          ),
          //TODO implement provider here to reduce rerending and only read the value once the user add
          IBCalculatorWidget(
            maxHeight: MediaQuery.of(context).size.height * .73,
            onChanged: (key, value, expression) => setState(() {
              calculatorValue = value ?? 0;
            }),
          ),
        ],
      ),
    );
  }
}

class TransactionTypeSelect extends ConsumerWidget {
  const TransactionTypeSelect(
      {required this.onSelectTag, required this.selectedTag, super.key});
  final Function(TagModel tag) onSelectTag;
  final TagModel? selectedTag;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IBOutlinedButton(
      title:
          selectedTag?.tagName ?? AppLocalizations.of(context)!.pleaseSelectTag,
      borderColors: Colors.transparent,
      backgroundColor: AppColors.white,
      icon: Icon(Icons.arrow_drop_down),
      onTap: () async {
        AsyncValue<List<TagModel>> tagProvider = ref.read(tagViewmodelProvider);

        /// Open a select Dialog model
        switch (tagProvider) {
          case AsyncData(:final value):
            TagModel? tag = await showDialog<TagModel?>(
              context: context,
              builder: (context) => TagSelectionDialog(
                tagList: value,
              ),
            );
            if (tag != null) {
              onSelectTag(tag);
            }
          case AsyncError():
            unawaited(showDialog(
              context: context,
              builder: (context) => _ErrorDialog(),
            ));
        }
      },
    );
  }
}

class _ErrorDialog extends ConsumerStatefulWidget {
  const _ErrorDialog();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __ErrorDialogState();
}

class __ErrorDialogState extends ConsumerState<_ErrorDialog> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<TagModel>> tagProvider = ref.watch(tagViewmodelProvider);

    return IBDialog.error(
      isLoading: tagProvider.isLoading,
      message: tagProvider.error.toString(),
      onRetry: () async {
        final _ = ref.invalidate(tagViewmodelProvider);
      },
    );
  }
}
