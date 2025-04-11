class AppInfo {
  AppInfo({
    this.uuid = 'unknown',
    this.appVersion = 'unknown',
  });
  final String uuid;
  final String appVersion;
}

class AppInfoManager {
  var _appInfo = AppInfo();
  AppInfo get appInfo => _appInfo;

  String get uuid => appInfo.uuid;
  String get appVersion => appInfo.appVersion;

  void update(AppInfo info) => _appInfo = info;
}
