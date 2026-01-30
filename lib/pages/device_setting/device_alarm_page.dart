import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xcloudsdk_flutter_example/generated/l10n.dart';
import 'package:xcloudsdk_flutter_example/views/toast/toast.dart';

import 'controller/device_alarm_controller.dart';

// ignore: must_be_immutable
class DeviceAlarmPage extends StatefulWidget {
  const DeviceAlarmPage(
      {Key? key, required this.deviceId, required this.channel})
      : super(key: key);

  final String deviceId;
  final int channel;

  @override
  State<DeviceAlarmPage> createState() => _DeviceAlarmPageState();
}

class _DeviceAlarmPageState extends State<DeviceAlarmPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) =>
            DeviceAlarmController(context: context, deviceId: widget.deviceId),
        builder: (context, child) {
          return Consumer<DeviceAlarmController>(
              builder: (context, controller, child) {
            return Scaffold(
                appBar: AppBar(
                  title: Text(TR.current.alarm),
                ),
                body: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return controller.dataSource[index];
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        color: Colors.blueGrey,
                      );
                    },
                    itemCount: controller.dataSource.length));
          });
        });
  }

  @override
  void dispose() {
    KToast.dismissInDispose();
    super.dispose();
  }
}
