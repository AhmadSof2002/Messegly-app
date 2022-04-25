import 'package:flutter/material.dart';
import 'package:messegly/modules/login/login_screen.dart';
import 'package:messegly/shared/components/components.dart';
import 'package:messegly/shared/network/local/cache_helper.dart';

String? uId;
void signOut(BuildContext context) {
  CacheHelper.removeData(key: 'token')
      .then((value) => navigateAndFinish(context, LoginScreen()));
}
