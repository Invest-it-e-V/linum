import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linum/common/components/dialogs/dialog_action.dart';
import 'package:linum/common/components/dialogs/show_action_dialog.dart';
import 'package:linum/generated/translation_keys.g.dart';

void showTransactionDeleteDialog(
    BuildContext context,
    Function() callbackFunction,
    {bool isSerialTransaction = false,}) {



  showActionDialog(
    context,
    message: isSerialTransaction
        ? tr(translationKeys.alertdialog.deleteTransaction.dialogMessageSerial)
        : tr(translationKeys.alertdialog.deleteTransaction.dialogMessage),
    title: tr(translationKeys.alertdialog.deleteTransaction.dialogLabelTitle),
    userMustDismissWithButton: false,
    actions: <DialogAction>[
      DialogAction(
        actionTitle: tr(
          translationKeys.alertdialog.deleteTransaction.dialogButtonCancel,
        ),
      ),
      DialogAction(
        actionTitle: tr(
          translationKeys.alertdialog.deleteTransaction.dialogButtonDelete,
        ),
        callback: callbackFunction,
        dialogPurpose: DialogPurpose.danger,
      ),
    ],
  );
}
