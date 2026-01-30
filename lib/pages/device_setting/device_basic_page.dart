import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xcloudsdk_flutter_example/generated/l10n.dart';
import 'package:xcloudsdk_flutter_example/pages/device_setting/controller/device_basic_controller.dart';
import 'package:xcloudsdk_flutter_example/views/toast/toast.dart';

class DeviceBasicPage extends StatefulWidget {
  const DeviceBasicPage(
      {Key? key, required this.deviceId, required this.channel})
      : super(key: key);

  final String deviceId;
  final int channel;

  @override
  State<DeviceBasicPage> createState() => _DeviceBasicPageState();
}

class _DeviceBasicPageState extends State<DeviceBasicPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) =>
            DeviceBasicController(context: context, deviceId: widget.deviceId),
        builder: (context, child) {
          return Consumer<DeviceBasicController>(
            builder: (context, controller, child) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(TR.current.basicSetting),
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
                    itemCount: controller.dataSource.length),
              );
            },
          );
        });
  }

  @override
  void dispose() {
    KToast.dismissInDispose();
    super.dispose();
  }
}
