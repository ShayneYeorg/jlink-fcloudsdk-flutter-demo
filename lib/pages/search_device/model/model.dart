///搜索设备 返回的 设备信息
class SearchedDevice {
  String? deviceName;
  String? hostIP;
  int? httpPort;
  String? mac;
  String? sn;
  int? deviceType;

  SearchedDevice(
      {this.deviceName = '',
      this.hostIP = '',
      this.httpPort,
      this.mac = '',
      this.sn = '',
      this.deviceType = 0});

  SearchedDevice.fromJson(Map<String, dynamic> json) {
    deviceName = json['deviceName'];
    hostIP = json['HostIP'];
    httpPort = json['HttpPort'];
    mac = json['MAC'];
    sn = json['SN'];
    deviceType = json['DeviceType'];
  }
}
