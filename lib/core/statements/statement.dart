// coverage:ignore-start
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:last_national_bank/classes/accountDetails.dart';
import 'package:last_national_bank/classes/statementItem.dart';
import 'package:last_national_bank/core/registration/widgets/Logo.dart';
import 'package:open_file/open_file.dart';
import 'package:last_national_bank/classes/specificAccount.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:universal_html/html.dart' as html;
import 'package:last_national_bank/core/registration/widgets/Logo.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Statement {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    if (kIsWeb) {
      final bytes = await pdf.save();
      final blob = html.Blob([bytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement()
        ..href = url
        ..style.display = 'none'
        ..download = 'my_statement.pdf';
      html.document.body?.children.add(anchor);
      anchor.click();
      html.document.body?.children.remove(anchor);
      html.Url.revokeObjectUrl(url);

      final file = File('');
      return file;
    } else {
      final bytes = await pdf.save();

      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$name');

      await file.writeAsBytes(bytes);

      return file;
    }
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }

  static Future<File> generateStatement(
      List<specificAccount> transactions, accountDetails currAccount) async {
    final pdf = Document();
    // final logoImage = (await rootBundle.loadString("assets/images/logo1.png"));

    pdf.addPage(MultiPage(
      build: (context) => <Widget>[
        buildCustomHeader(),
        // buildStatementDetails(currAccount),
        buildHeader(currAccount),
        buildTable(transactions, currAccount),
      ],
      footer: (context) {
        final pageNo = 'Page ${context.pageNumber} of ${context.pagesCount}';

        return Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(top: 1 * PdfPageFormat.cm),
            child: Text(
              pageNo,
              style: TextStyle(color: PdfColors.black),
            ));
      },
    ));

    return Statement.saveDocument(name: 'my_statement.pdf', pdf: pdf);
  }

  static Widget buildCustomHeader() => Container(
        padding: EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 2, color: PdfColors.black)),
        ),
        child: Row(
          children: [
            // Image.asset('assets/images/logo1.png'),
            PdfLogo(),
            SizedBox(width: 5 * PdfPageFormat.cm),
            Text(
              'Statement Enquiry',
              style: TextStyle(fontSize: 20, color: PdfColors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );

  static Widget buildStatementDetails(accountDetails currAccount) => Container(
        padding: EdgeInsets.only(bottom: 3 * PdfPageFormat.cm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 1.5 * PdfPageFormat.cm),
            Text(
              'Account Description: ' + currAccount.accountType,
              style: TextStyle(fontSize: 15, color: PdfColors.black),
              textAlign: TextAlign.left,
            ),
            SizedBox(width: 1.5 * PdfPageFormat.cm),
            Text(
              'Account Number: ' + currAccount.accountNumber,
              style: TextStyle(fontSize: 15, color: PdfColors.black),
              textAlign: TextAlign.left,
            ),
            SizedBox(width: 1.5 * PdfPageFormat.cm),
          ],
        ),
      );

  static Widget buildHeader(accountDetails currAccount) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            children: [
              Text(
                "Timestamp: " +
                    DateFormat('yyyy-MM-dd – kk:mm')
                        .format(DateTime.now())
                        .toString(),
                style: TextStyle(fontSize: 15, color: PdfColors.black),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              buildInvoiceInfo(currAccount),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoiceInfo(accountDetails currAccount) {
    final titles = <String>[
      'Account Description:',
      'Account Number:',
    ];

    final data = <String>[
      currAccount.accountType,
      currAccount.accountNumber,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 500);
      }),
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style =
        titleStyle ?? TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null, textAlign: TextAlign.left),
        ],
      ),
    );
  }

  static Widget buildTable(
      List<specificAccount> transactions, accountDetails currAccount) {
    final headers = [
      'Date',
      'Transaction Reference',
      'Debit',
      'Credit',
      'Balance'
    ];

    List<StatementItem> data = [];

    for (int i = 0; i < transactions.length; ++i) {
      String prefix = "";
      String debit = "";
      String credit = "";

      //Arneev Changes Begin
      if (transactions[i].accountTo == currAccount.accountNumber) {
        prefix = "+ R ";
        credit = transactions[i].amount.toString();
      } else {
        prefix = "- R ";
        debit = "-" + transactions[i].amount.toString();
      }

      //Arneev Changes End

      //Arneev Comment out below lines, 123 - 129
      // if (transactions[i].accountNumber == transactions[i].accountTo) {
      //   prefix = "+ R ";
      //   credit = transactions[i].amount.toString();
      // } else {
      //   prefix = "- R ";
      //   debit = "-" + transactions[i].amount.toString();
      // }

      StatementItem si = new StatementItem(
          date: transactions[i].timeStamp.split(" ")[0],
          referenceName: transactions[i].referenceName,
          amountPrefix: prefix,
          debitAmount: debit,
          creditAmount: credit,
          currentBalance: transactions[i].currentBalance);

      data.add(si);
    }

    final statementData = data.map((item) {
      return [
        // DateFormat.yMd(item.date),
        // new DateFormat('d.MMMM y', 'en').format(item.date),
        item.date,
        item.referenceName,
        item.debitAmount,
        item.creditAmount,
        item.currentBalance,
      ];
    }).toList();

    // Testing corrected balances
    for (int i = transactions.length; i > 0; --i) {
      String prefix = "";
      String debit = "";
      String credit = "";
      double diff = 0;

      //Arneev Changes Begin
      if (transactions[i].accountTo == currAccount.accountNumber) {
        prefix = "+ R ";
        diff = diff - transactions[i].amount;
        credit = transactions[i].amount.toString();
      } else {
        prefix = "- R ";
        diff = diff + transactions[i].amount;
        debit = "-" + transactions[i].amount.toString();
      }

      print("Date : " + transactions[i].timeStamp.split(" ")[0]);
      print("Ref name : " + transactions[i].referenceName);
      print("Prefix : " + prefix);
      print("Debit : " + debit);
      print("Credit : " + credit);
      print("Current balance : " + transactions[i].currentBalance.toString());
      print("Adjusted balance : " +
          (transactions[i].currentBalance + diff).toString());
    }

    return Table.fromTextArray(
      headers: headers,
      data: statementData,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
      },
    );
  }
}
// coverage:ignore-end