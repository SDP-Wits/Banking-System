import 'package:flutter/material.dart';

import '../../classes/accountDetails.dart';
import '../../config/routes/router.dart';

// coverage:ignore-start
//When the user swipes, go to the specific account with account details
void onSwipe(
    {required BuildContext context, required accountDetails accountDetail}) {
  goToSpecificAccount(context: context, acc: accountDetail);
}
// coverage:ignore-end
