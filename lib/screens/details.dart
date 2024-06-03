import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_cash/models/transaction_model.dart';
import 'package:track_cash/provider/total_provider.dart';
import 'package:track_cash/provider/transaction_provider.dart';
import 'package:track_cash/screens/new_transaction.dart';
import 'package:track_cash/widgets/nav_bar.dart';

class DetailsScreen extends ConsumerWidget {
  final User user;
  DetailsScreen({super.key, required this.user });



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<TransactionModel>> temp =
        ref.watch(getAllTransactionsProvider);
    TextTheme textThemeCurr = Theme.of(context).textTheme;
    ColorScheme colorSchemeCurr = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryFixed,
        title: Text(
          "Details",
          style: textThemeCurr.headlineMedium?.copyWith(
              color: colorSchemeCurr.onSecondaryFixedVariant, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 16,
            ),
            Text(
              "All Transactions",
              style: textThemeCurr.headlineMedium?.copyWith(
                  color: colorSchemeCurr.onSurfaceVariant, fontSize: 22),
            ),
            SizedBox(height: 8,),
            switch (temp) {
              AsyncData(:final value) => Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 8,
                    ),
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ExpansionTile(
                          collapsedBackgroundColor:
                              colorSchemeCurr.surfaceContainer,
                          collapsedTextColor: colorSchemeCurr.onSurfaceVariant,
                          backgroundColor: colorSchemeCurr.surfaceContainer,
                          textColor: colorSchemeCurr.onSurface,
                          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                          childrenPadding: EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            side: BorderSide(
                                color: colorSchemeCurr.secondaryContainer,
                                width: 2),
                          ),
                          collapsedShape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                value[index].name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: GoogleFonts.lato().fontFamily,
                                ),
                              ),
                              Text(
                                value[index].income ? "+ PKR " + value[index].amount.toString() : "- PKR " + value[index].amount.toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: GoogleFonts.lato().fontFamily,
                                  color: value[index].income ? Colors.green : Colors.red,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(value[index].date.day.toString() + "/" + value[index].date.month.toString() + "/" + value[index].date.year.toString()),
                          children: [
                            Text("Account: " + value[index].account),
                            Text("Category: " + value[index].category),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: colorSchemeCurr.secondary,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Icon(
                                  Icons.edit,
                                  color: colorSchemeCurr.secondary,
                                  size: 30,
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              AsyncError(:final error) => Text(error.toString()),
              _ => const Center(
                  child: CircularProgressIndicator(),
                )
            }
          ],
        ),
      ),
      bottomNavigationBar: NavBar(index: 1, user: user,),
    );
  }
}
