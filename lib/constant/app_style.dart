import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'app_color.dart';

class AppTextStyle {
  static const TextStyle textOnlineUser = TextStyle(
      fontWeight: FontWeight.bold,
      color: AppColor.defaultTextColor,
      fontSize: 11);

  static const TextStyle textPageTitle = TextStyle(
    fontSize: 34,
    color: AppColor.defaultTextColor,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle textReceivedTime = TextStyle(
    color: AppColor.receivedTimeColor,
    fontSize: 13,
  );

  static const TextStyle textFriendFullName = TextStyle(
      fontWeight: FontWeight.w700,
      color: AppColor.defaultTextColor,
      fontSize: 17);

  static const TextStyle textRecentMessage =
      TextStyle(color: AppColor.defaultTextColor, fontSize: 17);

  static final DateFormat messageReceivedTime = DateFormat('KK:mm a');
}
