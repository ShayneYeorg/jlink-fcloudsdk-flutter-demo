import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';

/// 在开放平台账号申请appkey等信息后，在项目/lib/utils/app_config.dart中修改对应平台等相关信息
/// https://aops.jftech.com/#/product

const androidUuid = '';
const androidAppKey = '';
const androidAppSecret = '';
const androidMoveCard = -1;

const iosUuid = '';
const iosAppKey = '';
const iosAppSecret = '';
const iosMoveCard = -1;

const ohosUuid = '';
const ohosAppKey = '';
const ohosAppSecret = '';
const ohosMoveCard = -1;

bool get isOhos => Platform.operatingSystem == 'ohos';

class AppConfig {
  static AppConfig instance = AppConfig();
  late PackageInfo packageInfo;

  Future baseConfig() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  static String uuid() {
    if (Platform.isIOS) {
      return iosUuid;
    } else if (Platform.isAndroid) {
      return androidUuid;
    }
    return ohosUuid;
  }

  static String appKey() {
    if (Platform.isIOS) {
      return iosAppKey;
    } else if (Platform.isAndroid) {
      return androidAppKey;
    }
    return ohosAppKey;
  }

  static String appSecret() {
    if (Platform.isIOS) {
      return iosAppSecret;
    } else if (Platform.isAndroid) {
      return androidAppSecret;
    }
    return ohosAppSecret;
  }

  static int moveCard() {
    if (Platform.isIOS) {
      return iosMoveCard;
    } else if (Platform.isAndroid) {
      return androidMoveCard;
    }
    return ohosMoveCard;
  }
}
