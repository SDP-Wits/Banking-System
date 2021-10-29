import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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
  static  saveDocument({
    required String name,
    required Document pdf,
  }) async {
    if (kIsWeb){
      try {
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
      } on Exception catch (_){
        print('document not saved');
      }
    }
    else {
      final bytes = await pdf.save();

      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$name');

      await file.writeAsBytes(bytes);

      //return file;
    }
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }

  static Future<File> generateStatement(
      List<specificAccount> transactions) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => <Widget>[
        buildCustomHeader(),
        buildTable(transactions),
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
        padding: EdgeInsets.only(bottom: 3 * PdfPageFormat.mm),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 2, color: PdfColors.black)),
        ),
        child: Row(
          children: [
            // Image.asset('assets/images/logo1.png'),
            PdfLogo(),
            SizedBox(width: 1.5 * PdfPageFormat.cm),
            Text(
              'Statement Enquiry',
              style: TextStyle(fontSize: 20, color: PdfColors.black),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      );

  static Widget buildTable(List<specificAccount> transactions) {
    final headers = ['Date', 'Transaction', 'Debit', 'Credit', 'Balance'];

    List<StatementItem> data = [];

    for (int i = 0; i < transactions.length; ++i) {
      String prefix = "";
      String debit = "";
      String credit = "";
      if (transactions[i].accountNumber == transactions[i].accountTo) {
        prefix = "+ R ";
        credit = transactions[i].amount.toString();
      } else {
        prefix = "- R ";
        debit = "-" + transactions[i].amount.toString();
      }

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

    return Table.fromTextArray(
      headers: headers,
      data: statementData,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
      },
    );
  }
}
