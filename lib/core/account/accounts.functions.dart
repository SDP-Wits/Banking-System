import 'package:flutter/material.dart';
import 'package:last_national_bank/classes/accountDetails.dart';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';

void onSwipe(
    {required BuildContext context, required accountDetails accountDetail}) {
  goToSpecificAccount(context: context, acc: accountDetail);
}
