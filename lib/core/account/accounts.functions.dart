import 'package:flutter/material.dart';

import '../../classes/accountDetails.dart';
import '../../config/routes/router.dart';

// coverage:ignore-start
void onSwipe(
    {required BuildContext context, required accountDetails accountDetail}) {
  goToSpecificAccount(context: context, acc: accountDetail);
}
// coverage:ignore-end
