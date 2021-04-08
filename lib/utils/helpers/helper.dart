import 'package:fluttertoast/fluttertoast.dart';

void toastyPrint(String string) {
  Fluttertoast.showToast(msg: string);
  print(string);
}
