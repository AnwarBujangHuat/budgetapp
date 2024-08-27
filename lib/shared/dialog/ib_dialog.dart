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
  final Function()? onSubmit;
  final Function()? onDismiss;
  final bool? isLoading;
  final DialogType dialogType;

  /// This is the default dialog that is used with only contains a String message
  const IBDialog({super.key, this.message})
      : onRetry = null,
        onSubmit = null,
        onDismiss = null,
        isLoading = false,
        dialogType = DialogType.message;

  const IBDialog.confirmation(
      {super.key, this.message, this.onSubmit, this.onDismiss, this.isLoading})
      : onRetry = null,
        dialogType = DialogType.confirmation;

  const IBDialog.loading({
    super.key,
    this.message,
  })  : onRetry = null,
        onSubmit = null,
        onDismiss = null,
        isLoading = false,
        dialogType = DialogType.loading;

  const IBDialog.error({
    super.key,
    this.message,
    this.onRetry,
    this.isLoading,
  })  : onSubmit = null,
        onDismiss = null,
        dialogType = DialogType.error;

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
    return _dialogBody(
      context: context,
      icon: Icon(Icons.check_circle,
          color: Colors.green, size: AppSize.iconSizeExtraLarge),
      message: message,
      title: AppLocalizations.of(context)!.confirmationDialog,
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
                builder: (context) => (isLoading != true || isLoading != null)
                    ? Text(
                        AppLocalizations.of(context)!.okay,
                        style: TextStyle(
                          color: AppColors.white,
                        ),
                      )
                    : SizedBox(
                        width: AppSize.appSizeS20,
                        height: AppSize.appSizeS20,
                        child: CircularProgressIndicator(),
                      ),
              ),
              backgroundColor: AppColors.darkBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingDialog(BuildContext context) {
    return _dialogBody(
      context: context,
      icon: CircularProgressIndicator(),
      message: message,
      title: AppLocalizations.of(context)!.loadingDialog,
    );
  }

  Widget _buildErrorDialog(BuildContext context) {
    return _dialogBody(
      context: context,
      icon: Icon(Icons.error,
          color: Colors.red, size: AppSize.iconSizeExtraLarge),
      message: message,
      title: AppLocalizations.of(context)!.errorDialog,
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
                builder: (context) => (isLoading != true || isLoading != null)
                    ? Text(
                        AppLocalizations.of(context)!.retry,
                        style: TextStyle(
                          color: AppColors.white,
                        ),
                      )
                    : SizedBox(
                        width: AppSize.appSizeS20,
                        height: AppSize.appSizeS20,
                        child: CircularProgressIndicator(),
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
        message: message,
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
    required Widget icon,
    String? message,
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
            _dialogTitleText(context: context, message: message, title: title),
            if (button != null) IBSizedH20(),
            if (button != null) button,
          ],
        ),
      ),
    );
  }

  Widget _dialogTitleText(
      {required BuildContext context,
      String? message = '',
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
          message ?? '',
          style: currentTheme.textTheme.labelLarge,
        ),
      ],
    );
  }
}
