class StatementItem {
  final String date;
  final double amount;
  final String referenceName;
  final String amountPrefix;
  final double currentBalance;

  const StatementItem({
    required this.date,
    required this.amount,
    required this.referenceName,
    required this.amountPrefix,
    required this.currentBalance,
  });
}
