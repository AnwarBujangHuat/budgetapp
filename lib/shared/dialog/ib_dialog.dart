import 'package:flutter/material.dart';

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
  //TODO create the single design for the title text and

  Widget _buildConfirmationDialog(BuildContext context) {
    return AlertDialog(
      title: Icon(Icons.check_circle,
          color: Colors.green, size: 40), // Accept logo
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
    return AlertDialog(
      title: Icon(Icons.error, color: Colors.red, size: 40), // Error logo
      content: Center(
        child:
            Text(message ?? 'An error occurred.', textAlign: TextAlign.center),
      ),
      actions: [
        if (onRetry != null)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onRetry?.call();
            },
            child: Text('Retry'),
          ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Dismiss'),
        ),
      ],
    );
  }

  Widget _buildMessageDialog(BuildContext context) {
    return AlertDialog(
      title: Icon(Icons.info, color: Colors.blue, size: 40), // Info logo
      content: Center(
        child: Text(message ?? 'No message provided.',
            textAlign: TextAlign.center),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('OK'),
        ),
      ],
    );
  }
}
