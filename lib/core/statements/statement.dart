// coverage:ignore-start
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:last_national_bank/classes/accountDetails.dart';
import 'package:last_national_bank/classes/statementItem.dart';
import 'package:last_national_bank/core/registration/widgets/Logo.dart';
import 'package:open_file/open_file.dart';
import 'package:last_national_bank/classes/specificAccount.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;
import 'package:last_national_bank/core/registration/widgets/Logo.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Statement {
  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    if (kIsWeb) {
      final bytes = await pdf.save();
      final blob = html.Blob([bytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement()
        ..href = url
        ..style.display = 'none'
        ..download = name;
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
      List<specificAccount> transactions,
      accountDetails currAccount,
      double currPassedBalance,
      String month) async {
    final pdf = pw.Document();

    final font = (kIsWeb)
        ? await rootBundle.load("fonts/Montserrat/Montserrat-Medium.ttf")
        : await rootBundle
            .load("assets/fonts/Montserrat/Montserrat-Medium.ttf");

    final tff = pw.Font.ttf(font);

    final logoData = (kIsWeb)
        ? (await rootBundle.load("images/colour_logo.png")).buffer.asUint8List()
        : (await rootBundle.load("assets/images/colour_logo.png"))
            .buffer
            .asUint8List();

    pdf.addPage(pw.MultiPage(
      build: (context) => <pw.Widget>[
        buildCustomHeader(tff, logoData),
        buildStatementInfo(month, currAccount, tff),
        buildTable(transactions, currAccount, currPassedBalance, tff),
      ],
      footer: (context) {
        final pageNo = 'Page ${context.pageNumber} of ${context.pagesCount}';

        return pw.Container(
            alignment: pw.Alignment.centerRight,
            margin: pw.EdgeInsets.only(top: 1 * PdfPageFormat.cm),
            child: pw.Text(
              pageNo,
              style: pw.TextStyle(color: PdfColors.black, font: tff),
            ));
      },
    ));

    return Statement.saveDocument(
        name: currAccount.accountNumber + "_" + month + ".pdf", pdf: pdf);
  }

  static pw.Widget buildCustomHeader(pw.Font tff, Uint8List logoData) =>
      pw.Container(
        padding: pw.EdgeInsets.only(bottom: 5 * PdfPageFormat.mm),
        decoration: pw.BoxDecoration(
          border: pw.Border(
              bottom: pw.BorderSide(width: 2, color: PdfColors.black)),
        ),
        child: pw.Row(
          children: <pw.Widget>[
            // Image.asset('assets/images/logo1.png'),
            pw.Image(pw.MemoryImage(logoData),
                width: 3.5 * PdfPageFormat.cm, height: 3.5 * PdfPageFormat.cm),
            pw.SizedBox(width: 3 * PdfPageFormat.cm),
            pw.Text(
              'Statement Enquiry',
              style:
                  pw.TextStyle(fontSize: 20, color: PdfColors.black, font: tff),
              textAlign: pw.TextAlign.center,
            ),
          ],
        ),
      );

  static pw.Widget buildStatementInfo(
          String month, accountDetails currAccount, pw.Font tff) =>
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(height: 1 * PdfPageFormat.cm),
          pw.Row(
            children: [
              pw.Text(
                "Timestamp:\t" +
                    DateFormat('yyyy-MM-dd – kk:mm')
                        .format(DateTime.now())
                        .toString(),
                style: pw.TextStyle(
                    fontSize: 15, color: PdfColors.black, font: tff),
                textAlign: pw.TextAlign.left,
              ),
            ],
          ),
          pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              buildAccInfo(month, currAccount, tff),
            ],
          ),
          pw.SizedBox(height: 1 * PdfPageFormat.cm),
        ],
      );

  static pw.Widget buildAccInfo(
      String month, accountDetails currAccount, pw.Font tff) {
    final titles = <String>[
      'Statement Month:\t',
      'Account Description:\t',
      'Account Number:\t',
    ];

    final data = <String>[
      month,
      currAccount.accountType,
      currAccount.accountNumber,
    ];

    return pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 350, tff: tff);
      }),
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    pw.TextStyle? titleStyle,
    // bool unite = false,
    required pw.Font tff,
  }) {
    final style = titleStyle ??
        pw.TextStyle(
          fontSize: 15,
          fontWeight: pw.FontWeight.bold,
          font: tff,
        );

    return pw.Container(
      width: width,
      child: pw.Row(
        children: [
          pw.Expanded(
              child:
                  pw.Text(title, style: style, textAlign: pw.TextAlign.left)),
          pw.SizedBox(height: 1 * PdfPageFormat.cm),
          pw.Text(value, style: style, textAlign: pw.TextAlign.left),

          // pw.Column(children: [
          //   pw.Text(title, style: style, textAlign: pw.TextAlign.left)
          // ]),
          // pw.Column(children: [
          //   pw.Text(value, style: style, textAlign: pw.TextAlign.left)
          // ]),
        ],
      ),
    );
  }

  static pw.Widget buildTable(List<specificAccount> transactions,
      accountDetails currAccount, double currPassedBalance, pw.Font tff) {
    final headers = [
      'Date',
      'Transaction Reference',
      'Debit',
      'Credit',
      'Balance'
    ];

    List<StatementItem> data = [];

    /*   for (int i = 0; i < transactions.length; ++i) {
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
        currentBalance: transactions[i].currentBalance,
      );

      data.add(si);
    }

    final statementData = data.map((item) {
      return [
        item.date,
        item.referenceName,
        item.debitAmount,
        item.creditAmount,
        item.currentBalance,
      ];
    }).toList();
    */

    // Testing corrected balances
    double runningBalance = currPassedBalance;
    String prevPrefix = "";
    for (int i = 0; i <= transactions.length - 1; ++i) {
      String prefix = "";
      String debit = "";
      String credit = "";
      double diff = 0;

      //Arneev Changes Begin
      if (transactions[i].accountTo == currAccount.accountNumber) {
        prefix = "+ R ";
        credit = transactions[i].amount.toString();
      } else {
        prefix = "- R ";
        // if (!(i == transactions.length - 1)) {
        //   diff = diff - transactions[i + 1].amount;
        // }
        if (transactions[i].amount < 0) {
          debit = transactions[i].amount.toString();
        } else {
          debit = "-" + transactions[i].amount.toString();
        }
      }

      if (transactions[i].accountTo == currAccount.accountNumber) {
        diff = diff + transactions[i].amount;
      } else {
        diff = diff - transactions[i].amount;
      }

      print("Date : " + transactions[i].timeStamp.split(" ")[0]);
      print("Ref name : " + transactions[i].referenceName);
      print("Prefix : " + prefix);
      print("Debit : " + debit);
      print("Credit : " + credit);
      print("Diff: " + diff.toString());
      print("Amount: " + transactions[i].amount.toString());
      // print("Current balance : " + transactions[i].currentBalance.toString());
      runningBalance = runningBalance + diff;
      print("Adjusted balance : " + (runningBalance).toString());

      StatementItem si = new StatementItem(
        date: transactions[i].timeStamp.split(" ")[0],
        referenceName: transactions[i].referenceName,
        amountPrefix: prefix,
        debitAmount: debit,
        creditAmount: credit,
        currentBalance: runningBalance.toStringAsFixed(2),
      );

      data.add(si);
    }

    final statementData = data.map((item) {
      return [
        item.date,
        item.referenceName,
        item.debitAmount,
        item.creditAmount,
        item.currentBalance,
      ];
    }).toList();

    return pw.Table.fromTextArray(
      headers: headers,
      data: statementData,
      border: null,
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: tff),
      headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellStyle: pw.TextStyle(font: tff),
      cellDecoration: (int i1, dynamic ekWeetNie, int i2) {
        return pw.BoxDecoration(
            color: (i1 % 2 == 0)
                ? PdfColor.fromInt(0xfafafa)
                : PdfColor.fromInt(0xfdfdfd));
      },
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.centerRight,
        4: pw.Alignment.centerRight,
      },
    );
  }
}
// coverage:ignore-end