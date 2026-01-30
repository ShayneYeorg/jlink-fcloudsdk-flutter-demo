///wifi配网返回的
class WifiDeviceModel {
  String? randomUser;
  String? hostName;
  int? type;
  String? pid;
  String? deviceSn;
  String? randomPwd;
  String? resume;

  WifiDeviceModel(
      {this.randomUser,
        this.hostName,
        this.type,
        this.pid,
        this.deviceSn,
        this.randomPwd,
        this.resume});

  WifiDeviceModel.fromJson(Map<String, dynamic> json) {
    randomUser = json['randomUser'];
    hostName = json['hostName'];
    type = json['type'];
    pid = json['pid'];
    deviceSn = json['deviceSn'];
    randomPwd = json['randomPwd'];
    resume = json['resume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['randomUser'] = randomUser;
    data['hostName'] = hostName;
    data['type'] = type;
    data['pid'] = pid;
    data['deviceSn'] = deviceSn;
    data['randomPwd'] = randomPwd;
    data['resume'] = resume;
    return data;
  }
}