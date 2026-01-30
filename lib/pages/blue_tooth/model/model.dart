///蓝牙搜索 返回的 设备信息
class BlueToothDevice {
  String? strPid;
  String? name;
  String? macStr;

  BlueToothDevice({
    this.strPid = '',
    this.name = '',
    this.macStr,
  });

  BlueToothDevice.fromJson(Map<String, dynamic> json) {
    strPid = json['strPid'];
    name = json['name'];
    macStr = json['macStr'];
  }
}

///蓝牙连接成功 返回的 设备信息
class BlueToothConnectedDevice {
  String? useName;
  String? password;
  String? sn;
  String? ip;
  String? mac;
  String? token;

  BlueToothConnectedDevice({
    this.useName = '',
    this.password = '',
    this.sn = '',
    this.ip = '',
    this.mac = '',
    this.token = '',
  });

  BlueToothConnectedDevice.fromJson(Map<String, dynamic> json) {
    useName = json['useName'];
    password = json['password'];
    sn = json['sn'];
    ip = json['ip'];
    mac = json['mac'];
    token = json['token'];
  }
}