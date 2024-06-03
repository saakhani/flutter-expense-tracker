import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_cash/models/transaction_model.dart';
import 'package:track_cash/provider/total_provider.dart';
import 'package:track_cash/provider/transaction_provider.dart';
import 'package:track_cash/screens/details.dart';
import 'package:track_cash/screens/new_transaction.dart';
import 'package:track_cash/widgets/nav_bar.dart';

final isExpandedProvider = StateProvider<bool>((ref) => false);

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<TransactionModel>> temp =
        ref.watch(getTenTransactionsProvider);
    final AsyncValue<double> total = ref.watch(getTotalProvider);
    final isExpanded = ref.watch(isExpandedProvider);
    TextTheme textThemeCurr = Theme.of(context).textTheme;
    ColorScheme colorSchemeCurr = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryFixed,
        title: Text(
          "Dashboard",
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
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 4,
                    offset: Offset(2, 3), // changes position of shadow
                  ),
                ],
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Available Balance",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    total.when(
                      data: (value) => "PKR " + value.toString(),
                      error: (error, stackTrace) => error.toString(),
                      loading: () => "Loading",
                    ),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryFixedVariant,
                        ),
                  ),
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 0),
                    child: isExpanded
                        ? Column(
                            key: ValueKey('expanded'),
                            children: [
                              SizedBox(height: 8),
                              Text(
                                "Accounts",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                    ),
                              ),
                            ],
                          )
                        : SizedBox.shrink(key: ValueKey('collapsed')),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        style: ButtonStyle(
                            padding: WidgetStateProperty.all(EdgeInsets.zero)),
                        icon: Icon(
                            color: colorSchemeCurr.onPrimaryFixed,
                            size: 40,
                            isExpanded ? Icons.expand_less : Icons.expand_more),
                        onPressed: () {
                          ref.read(isExpandedProvider.notifier).state =
                              !isExpanded;
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Transactions",
                  style: textThemeCurr.headlineMedium?.copyWith(
                      color: colorSchemeCurr.onSurfaceVariant, fontSize: 22),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return DetailsScreen(
         user: user,
        );
      }), (route) => false);
                    },
                    icon: Icon(
                      Icons.double_arrow_rounded,
                      color: colorSchemeCurr.secondary,
                      size: 35,
                    ))
              ],
            ),
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
                          expandedCrossAxisAlignment:
                              CrossAxisAlignment.stretch,
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
                                value[index].income
                                    ? "+ PKR " + value[index].amount.toString()
                                    : "- PKR " + value[index].amount.toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: GoogleFonts.lato().fontFamily,
                                  color: value[index].income
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(value[index].date.day.toString() +
                              "/" +
                              value[index].date.month.toString() +
                              "/" +
                              value[index].date.year.toString()),
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
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return AddTransaction(
                user: user,
              );
            }),
          );
        },
        child: Icon(
          Icons.add_rounded,
          size: 35,
        ),
        foregroundColor: colorSchemeCurr.onSecondaryFixedVariant,
      ),
      bottomNavigationBar: NavBar(
        user: user,
        index: 0,
      ),
    );
  }
}
