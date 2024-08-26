import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/widgets/button/outlined_button.dart';
import 'package:budgetapp/common/widgets/size_box/sized_boxes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/* The Default [Dialog] Design for InBalance

There are 4 kinds of [Dialog] for InBalance:
 * _confirmation_: Used to ask the user to confirm or cancel an action. It typically includes a message and two buttons: "Cancel" and "Confirm".
 * _loading_: Indicates that a process is ongoing and the user should wait. It usually shows a progress indicator and a message.
 * _error_: Notifies the user of an error that has occurred. This dialog may include a "Retry" button if the operation can be attempted again, along with a "Dismiss" button.
 * _message_: A general-purpose dialog for displaying a simple message. It includes a single "OK" button to close the dialog.
*/

// Define an enum to specify [Dialog] types (optional)
enum DialogType { confirmation, loading, error, message }

class IBDialog extends StatelessWidget {
  final String? message;
  final Function()? onRetry;
  final DialogType dialogType;

  /// This is the default dialog that is used with only contains a String message
  const IBDialog({
    super.key,
    this.message,
  })  : onRetry = null,
        dialogType = DialogType.message;

  const IBDialog.confirmation({
    super.key,
    this.message,
  })  : onRetry = null,
        dialogType = DialogType.confirmation;

  const IBDialog.loading({
    super.key,
    this.message,
  })  : onRetry = null,
        dialogType = DialogType.loading;

  const IBDialog.error({
    super.key,
    this.message,
    this.onRetry,
  }) : dialogType = DialogType.error;

  @override
  Widget build(BuildContext context) {
    switch (dialogType) {
      case DialogType.confirmation:
        return _buildConfirmationDialog(context);
      case DialogType.loading:
        return _buildLoadingDialog(context);
      case DialogType.error:
        return _buildErrorDialog(context);
      case DialogType.message:
        return _buildMessageDialog(context);
    }
  }

  Widget _buildConfirmationDialog(BuildContext context) {
    return AlertDialog(
      title: Icon(Icons.check_circle, color: Colors.green, size: 40),
      content: Center(
        child: Text(message ?? 'Are you sure?', textAlign: TextAlign.center),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            // Handle confirmation action here
          },
          child: Text('OK'),
        ),
      ],
    );
  }

  Widget _buildLoadingDialog(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: PopScope(
        canPop: false,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(message ?? 'Loading...', textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorDialog(BuildContext context) {
    return _dialogBody(
      context: context,
      icon: Icon(Icons.error,
          color: Colors.red, size: AppSize.iconSizeExtraLarge),
      message: 'This is a typical dialog.',
      title: 'An error occurred.',
      button: Row(
        children: [
          Expanded(
              child: IBOutlinedButton(
            onTap: () {
              Navigator.pop(context);
            },
            title: AppLocalizations.of(context)!.cancel,
            backgroundColor: Colors.white,
            borderColors: AppColors.darkBlue,
          )),
          IBSizedW10(),
          Expanded(
            child: IBOutlinedButton(
              onTap: () {
                Navigator.pop(context);
              },
              titleBuilder: Builder(
                builder: (context) => Text(
                  AppLocalizations.of(context)!.okay,
                  style: TextStyle(
                    color: AppColors.white,
                  ),
                ),
              ),
              backgroundColor: AppColors.darkBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageDialog(BuildContext context) {
    return _dialogBody(
        context: context,
        icon: Icon(Icons.info_sharp, size: AppSize.iconSizeExtraLarge),
        message: 'This is a typical dialog.',
        title: 'Header Title',
        button: IBOutlinedButton(
          onTap: () {
            Navigator.pop(
              context,
            );
          },
          titleBuilder: Builder(
            builder: (context) => Text(
              AppLocalizations.of(context)!.okay,
              style: TextStyle(
                color: AppColors.white,
              ),
            ),
          ),
          backgroundColor: AppColors.darkBlue,
        ));
  }

  Widget _dialogBody({
    required BuildContext context,
    required String message,
    required Widget icon,
    String title = '',
    Widget? button,
  }) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(AppSize.paddingLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(AppSize.paddingLarge),
              child: icon,
            ),
            IBSizedH20(),
            _dialogTitleText(
                context: context,
                message: 'This is a typical dialog.',
                title: title),
            if (button != null) IBSizedH20(),
            if (button != null) button,
          ],
        ),
      ),
    );
  }

  Widget _dialogTitleText(
      {required BuildContext context,
      required String message,
      String title = ''}) {
    ThemeData currentTheme = Theme.of(context);

    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: FontSize.mediumTitle),
        ),
        IBSizedH10(),
        Text(
          title,
          style: currentTheme.textTheme.labelMedium,
        ),
      ],
    );
  }
}
