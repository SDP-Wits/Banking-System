// coverage:ignore-start
//Stores all the data for 2 peoples account for transactions/logs.
class specificAccount {
  final String accountNumber;
  final int accountTypeId;
  final double currentBalance;
  final String accountType;
  final String accountDescription;
  final int transactionID;
  final String customerName;
  final String timeStamp;
  final double amount;
  final String accountFrom;
  final String accountTo;
  final String referenceName;
  final String referenceNumber;

  specificAccount({
    required this.accountNumber,
    required this.accountTypeId,
    required this.currentBalance,
    required this.accountType,
    required this.accountDescription,
    required this.transactionID,
    required this.customerName,
    required this.timeStamp,
    required this.amount,
    required this.accountFrom,
    required this.accountTo,
    required this.referenceName,
    required this.referenceNumber,
  });
}
// coverage:ignore-end
