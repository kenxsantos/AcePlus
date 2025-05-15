import 'package:aceplus/features/card_game/presentation/wallet_page/widgets/receipt_info.dart';
import 'package:aceplus/shared/utils/constant.dart';
import 'package:aceplus/shared/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../transaction_bloc/transaction_bloc.dart';
import '../transaction_bloc/transaction_event.dart';
import '../transaction_bloc/transaction_state.dart';

class ReceiptPage extends StatefulWidget {
  final String id;
  final String transactionId;

  const ReceiptPage({super.key, required this.id, required this.transactionId});

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  late final String transactionId;

  @override
  void initState() {
    super.initState();
    transactionId = widget.transactionId;
    context.read<TransactionBloc>().add(
      LoadTransaction(transactionId: int.parse(transactionId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              Str().eWallet,
              style: TextStyle(
                color: primaryYellow,
                fontFamily: lemon,
                fontSize: 20,
              ),
            ),
          ],
        ),
        backgroundColor: primaryBlack,
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => context.go('/transaction-history/${widget.id}'),
          color: primaryWhite,
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TransactionLoaded) {
            final transaction = state.transaction;
            return Container(
              alignment: Alignment.topCenter,
              color: primaryBlack,
              padding: EdgeInsets.all(25),
              child: Container(
                padding: EdgeInsets.all(25),
                width: 500,
                height: 350,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 22, 22, 22),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('${iconUrl}receipt_icon.png'),
                    Divider(height: 5),
                    Column(
                      children: [
                        ReceiptInfo(
                          txtTitle: "Amount",
                          txtValue: TextSpan(
                            children: [
                              TextSpan(
                                text: transaction.transactionType == "Cash In" ? "+" : "-",
                                style: TextStyle(
                                  fontFamily: lemon,
                                  color: transaction.transactionType == "Cash In" ? Color(0xFF42F271) : Color(0xFFF24242),
                                ),
                              ),
                              TextSpan(
                                text: '\u20B1',
                                style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontSize: 15,
                                  color: transaction.transactionType == "Cash In" ? Color(0xFF42F271) : Color(0xFFF24242),
                                ),
                              ),
                              TextSpan(
                                text: ' ${NumberFormat('#,##0.00').format(double.parse(transaction.amount.toString()))}',
                                style: TextStyle(
                                  fontFamily: lemon,
                                  color: transaction.transactionType == "Cash In" ? Color(0xFF42F271) : Color(0xFFF24242),
                                ),
                              ),
                            ],
                          ),
                          txtColor: transaction.transactionType == "Cash In" ? Color(0xFF42F271) : Color(0xFFF24242),
                        ),
                        ReceiptInfo(
                          txtTitle: "Date",
                          txtValue: TextSpan(
                            text: DateFormat('MMMM dd, yyyy').format(transaction.transactionDate),
                            style: TextStyle(
                              fontFamily: lemon,
                              color: primaryWhite,
                            ),
                          ),
                          txtColor: primaryWhite,
                        ),
                        ReceiptInfo(
                          txtTitle: "Time",
                          txtValue: TextSpan(
                            text: DateFormat('hh:mm a').format(transaction.transactionDate),
                            style: TextStyle(
                              fontFamily: lemon,
                              color: primaryWhite,
                            ),
                          ),
                          txtColor: primaryWhite,
                        ),
                        ReceiptInfo(
                          txtTitle: "Mobile Number Used",
                          txtValue: TextSpan(
                            text: transaction.mobileNumber,
                            style: TextStyle(
                              fontFamily: lemon,
                              color: primaryWhite,
                            ),
                          ),
                          txtColor: primaryWhite,
                        ),
                        ReceiptInfo(
                          txtTitle: "Reference No.",
                          txtValue: TextSpan(
                            text: transaction.referenceNumber,
                            style: TextStyle(
                              fontFamily: lemon,
                              color: primaryWhite,
                            ),
                          ),
                          txtColor: primaryWhite,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (state is TransactionError) {
            return Center(
              child: Text(state.error, style: TextStyle(color: Colors.red)),
            );
          } else {
            return Center(
              child: Text(
                "No data available",
                style: TextStyle(color: primaryWhite),
              ),
            );
          }
        },
      ),
    );
  }
}
