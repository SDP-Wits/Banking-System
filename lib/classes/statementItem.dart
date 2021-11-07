// coverage:ignore-start
class StatementItem {
  final String date;
  final String debitAmount;
  final String creditAmount;
  final String referenceName;
  final String amountPrefix;
  final String currentBalance;

  const StatementItem({
    required this.date,
    required this.referenceName,
    required this.amountPrefix,
    required this.debitAmount,
    required this.creditAmount,
    required this.currentBalance,
  });
}
// coverage:ignore-end