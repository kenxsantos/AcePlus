import 'package:aceplus/shared/utils/constant.dart';
import 'package:aceplus/shared/utils/strings.dart';
import 'package:aceplus/shared/widgets/confirmation_dialog.dart';
import 'package:aceplus/shared/widgets/input_error_text.dart';
import 'package:aceplus/shared/widgets/solid_button.dart';
import 'package:aceplus/shared/widgets/wallet_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/utils/validators.dart';
import '../transaction_bloc/transaction_bloc.dart';
import '../transaction_bloc/transaction_event.dart';
import '../transaction_bloc/transaction_state.dart';

class CashProcessContainer extends StatefulWidget {
  final String text;
  final String id;

  const CashProcessContainer({super.key, required this.text, required this.id});

  @override
  State<CashProcessContainer> createState() => _CashProcessContainerState();
}

class _CashProcessContainerState extends State<CashProcessContainer> {
  final TextEditingController accountController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final accountError = ValueNotifier<String?>(null);
  final amountError = ValueNotifier<String?>(null);
  bool isClearing = false;

  @override
  void initState() {
    super.initState();

    accountController.addListener(() {
      if (!isClearing) {
        final accountErrorText = validateMobileNumber(
          accountController.text.trim(),
        );
        accountError.value = accountErrorText;
      }
    });

    amountController.addListener(() {
      if (!isClearing) {
        final amountErrorText = validateAmount(amountController.text.trim());
        amountError.value = amountErrorText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        if (state is TransactionLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder:
                (context) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is TransactionSuccessState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));

          FocusScope.of(context).unfocus();

          accountController.clear();
          amountController.clear();

          accountError.value = null;
          amountError.value = null;
        } else if (state is TransactionError) {
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Image.asset("${imageUrl}gcash_logo.png"),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WalletTextField(
                labelText: Str().enterAccNo,
                controller: accountController,
              ),
              ValueListenableBuilder<String?>(
                valueListenable: accountError,
                builder: (context, error, child) {
                  if (error != null) {
                    return Align(
                      alignment: Alignment.centerRight,
                      child: InputErrorText(error: error),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
          SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WalletTextField(
                labelText: Str().enterAmount,
                controller: amountController,
              ),
              ValueListenableBuilder<String?>(
                valueListenable: amountError,
                builder: (context, error, child) {
                  if (error != null) {
                    return Align(
                      alignment: Alignment.centerRight,
                      child: InputErrorText(error: error),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          SolidButton(
            labelText: widget.text,
            onPressed: () {
              final account = accountController.text.trim();
              final amount = amountController.text.trim();

              accountError.value = validateMobileNumber(account);
              amountError.value = validatePassword(account);

              if (accountError.value == null &&
                  amountError.value == null) {
                if (account.isNotEmpty && amount.isNotEmpty) {
                  showDialog(context: context,
                      builder: (context) =>
                          ConfirmationDialog(title: "Confirm ${widget.text}?",
                              content: "Are you sure you want ${widget.text}?",
                              onConfirm: () {
                                Navigator.of(context).pop();
                                context.read<TransactionBloc>().add(
                                  AddTransaction(
                                    userId: widget.id,
                                    transactionType: widget.text,
                                    amount: amountController.text,
                                    mobileNumber: accountController.text,
                                  ),
                                );
                              },
                          ),
                  );
                }
              } else {
                if (account.isEmpty) {
                  accountError.value = "Mobile number is required";
                }
                if (amount.isEmpty) {
                  amountError.value = "Amount is required";
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
