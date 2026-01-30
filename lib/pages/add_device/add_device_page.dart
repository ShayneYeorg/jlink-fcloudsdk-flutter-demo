import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:xcloudsdk_flutter/api/api_center.dart';
import 'package:xcloudsdk_flutter_example/common/code_prase.dart';
import 'package:xcloudsdk_flutter_example/generated/l10n.dart';
import 'package:xcloudsdk_flutter_example/pages/add_device/add_device_fill_device_name_page.dart';
import 'package:xcloudsdk_flutter_example/pages/add_device/models/add_device_center.dart';
import 'package:xcloudsdk_flutter_example/pages/add_device/reset_device_random_loginName_password_page.dart';
import 'package:xcloudsdk_flutter_example/pages/blue_tooth/ble_scan_page.dart';
import 'package:xcloudsdk_flutter_example/pages/blue_tooth/model/model.dart';
import 'package:xcloudsdk_flutter_example/pages/device_scan_qr/device_scan_qr_page.dart';
import 'package:xcloudsdk_flutter_example/pages/scan_qr/scan_qr_page.dart';
import 'package:xcloudsdk_flutter_example/pages/search_device/model/model.dart';
import 'package:xcloudsdk_flutter_example/pages/search_device/search_device_page.dart';
import 'package:xcloudsdk_flutter_example/views/toast/toast.dart';

class AddDevicePage extends StatefulWidget {
  const AddDevicePage({Key? key}) : super(key: key);

  @override
  State<AddDevicePage> createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController devSNController = TextEditingController();

  BlueToothConnectedDevice? _device;

  @override
  void initState() {
    super.initState();
  }

  void _onPopMenuItemTap(String value) async {
    switch (value) {
      case "SEARCH":
        {
          final SearchedDevice? searched = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return const SearchDevicePage();
          }));
          if (searched != null) {
            setState(() {
              nameController.text = searched.deviceName ?? '';
              devSNController.text = searched.sn ?? '';
            });
          }
        }
        break;
      case "WIFI":
        {
          context.pushNamed('wifi_config').then((value) {
            if (value == null) {
              return;
            }
            List<String> list = value as List<String>;
            final sn = list[0];
            setState(() {
              devSNController.text = sn;
              Navigator.of(context);
            });
          });
        }
        break;
      case "bluetooth":
        {
          final result = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return const BleScanPage();
          }));
          if (result != null) {
            setState(() {
              nameController.text = '';
              devSNController.text = result['sn'] ?? '';
            });
          }
        }
        break;
      case "二维码配网":
        {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return DeviceScanQrPage(
                onCompletion: (String deviceId, int deviceType) {
              setState(() {
                nameController.text = '';
                devSNController.text = deviceId;
              });
            });
          }));
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(TR.current.addDevice),
        centerTitle: true,
        actions: [
          // IconButton(
          //   onPressed: () async {
          //     final SearchedDevice? searched = await Navigator.of(context)
          //         .push(MaterialPageRoute(builder: (context) {
          //       return const SearchDevicePage();
          //     }));
          //     if (searched != null) {
          //       setState(() {
          //         nameController.text = searched.deviceName ?? '';
          //         devSNController.text = searched.sn ?? '';
          //       });
          //     }
          //   },
          //   icon: Icon(Icons.search_rounded)
          // ),
          PopupMenuButton<String>(
              onSelected: _onPopMenuItemTap,
              itemBuilder: (context) => [
                    PopupMenuItem<String>(
                      value: "SEARCH",
                      child: Text(TR.current.lanSearch),
                    ),
                    const PopupMenuDivider(),
                    PopupMenuItem<String>(
                      value: "WIFI",
                      child: Text(TR.current.wifi),
                    ),
                    const PopupMenuDivider(),
                    PopupMenuItem<String>(
                      value: "bluetooth",
                      child: Text(TR.current.bluetooth),
                    ),
                    const PopupMenuDivider(),
                    const PopupMenuItem<String>(
                      value: "二维码配网",
                      child: Text('二维码配网'),
                    ),
                  ])
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                icon: const Icon(Icons.device_hub),
                hintText: TR.current.devName,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              final width = constraints.maxWidth;
              const pWidth = 60.0;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width - pWidth,
                    child: TextField(
                      controller: devSNController,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.book),
                        hintText: TR.current.devSN,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: pWidth,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ScanQrPage(callBack: (String jsonStr) {
                            if (jsonStr.isNotEmpty &&
                                _isJFDeviceUuid(jsonStr)) {
                              setState(() {
                                nameController.text = jsonStr;
                                devSNController.text = jsonStr;
                              });
                              // KToast.show();
                              // JFApi.xcAccount
                              //     .xcDecodeInfo(encodeStr: jsonStr)
                              //     .then((value) {
                              //   KToast.dismiss();
                              //   final dataMap = jsonDecode(value);
                              //   // Map dataMap = jsonDecode(jsonStr);
                              //   ///其他信息以下自取
                              //   // map['devId'] = systemInfoMap['SerialNo'];
                              //   // map['devType'] = 0;///先给个0
                              //   // map['loginName'] = loginName;
                              //   // map['pwd'] = pwd;
                              //   // map['shareTimes'] = timestampInSeconds;
                              //   // map['permissions'] = '';
                              //   // map['userId'] = UserInfo.instance.userName;
                              //   // map['dt'] = '';//token
                              //   if (dataMap['devId'] != null) {
                              //     final String sn = dataMap['devId'];
                              //     if (sn.isNotEmpty) {
                              //       setState(() {
                              //         devSNController.text = sn;
                              //       });
                              //     }
                              //   }
                              // }).catchError((error) {
                              //   if (error == '-605017') {
                              //     KToast.show(status: '二维码已经过期');
                              //   } else {
                              //     KToast.show(status: KErrorMsg(error));
                              //   }
                              // });
                            } else {
                              KToast.show(status: '无效数据');
                            }
                          });
                        }));
                      },
                      child: const Icon(Icons.photo_camera),
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  addDeviceWithDevSN(context);
                },
                child: Text(TR.current.add)),

            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    DeviceAddModel model = DeviceAddModel();
                    return ResetDeviceRandomLoginNameAndPasswordPage(
                      model: model,
                    );
                  }));
                },
                child: const Text('随机用户名密码修改')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    DeviceAddModel model = DeviceAddModel();
                    return AddDeviceFillDeviceNamePage(
                      model: model,
                    );
                  }));
                },
                child: const Text('填写设备名称')),

            // const Spacer(),
            // SizedBox(
            //   width: 200,
            //   child: ElevatedButton(
            //       onPressed: () {
            //         context.pushNamed('wifi_config').then((value) {
            //           if (value == null) {
            //             return;
            //           }
            //           List<String> list = value as List<String>;
            //           final sn = list[0];
            //           setState(() {
            //             devSNController.text = sn;
            //             Navigator.of(context);
            //           });
            //         });
            //       },
            //       child: const Text("快速wifi配网")),
            // ),
            // SizedBox(
            //   width: 200,
            //   child: ElevatedButton(
            //       onPressed: () {
            //         Navigator.of(context)
            //             .push(MaterialPageRoute(builder: (context) {
            //           return BlueToothSearchDevicePage(
            //             callback: (BlueToothConnectedDevice device) {
            //               if (device.sn != null && device.sn!.isNotEmpty) {
            //                 _device = device;
            //                 setState(() {
            //                   nameController.text = '';
            //                   devSNController.text = _device!.sn ?? '';
            //                 });
            //               }
            //             },
            //           );
            //         }));
            //       },
            //       child: const Text("蓝牙配网")),
            // ),
            // SizedBox(
            //   child: ElevatedButton(
            //     onPressed: () async {
            //       final result = await Navigator.of(context)
            //           .push(MaterialPageRoute(builder: (context) {
            //         return const BleScanPage();
            //       }));
            //       if (result != null) {
            //         setState(() {
            //           nameController.text = '';
            //           devSNController.text = result['sn'] ?? '';
            //         });
            //       }
            //     },
            //     child: const Text('蓝牙配网2.0'),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  void addDeviceWithDevSN(BuildContext context) async {
    KToast.show();

    DevAdd dev =
        DevAdd(uuid: devSNController.text, nickname: nameController.text);
    if (dev.nickname!.isEmpty) {
      dev.nickname = devSNController.text;
    }

    if (_device != null) {
      DeviceTokenModel deviceToken =
          DeviceTokenModel(adminToken: _device!.token);
      dev.deviceToken = deviceToken;
    }

    AccountAPI.instance.xcAddDevice(devAdd: dev).then((value) {
      KToast.dismiss();
      Navigator.of(context).pop();
    }).catchError((error) {
      KToast.show(status: KErrorMsg(error));
    });
  }

  @override
  void dispose() {
    devSNController.dispose();
    nameController.dispose();
    super.dispose();
  }
}

///是否是杰峰设备uuid
bool _isJFDeviceUuid(String sn) {
/*
     16位序列号字母a-f和数字0-9组成
     20位序列号字母a-z和数字0-9组成
     */
  if (sn.length == 16) {
    RegExp regex = RegExp(r'^[a-fA-F0-9]{16}$');
    return regex.hasMatch(sn);
  } else if (sn.length == 20) {
    RegExp regex = RegExp(r'^[a-zA-Z0-9]{20}$');
    return regex.hasMatch(sn);
  } else {
    return false;
  }
}
