class specificAccount{
    final String accountNumber;
    final int accountTypeId;
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