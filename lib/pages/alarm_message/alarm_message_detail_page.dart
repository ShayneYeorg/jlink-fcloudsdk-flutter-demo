import 'dart:io';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:xcloudsdk_flutter_example/generated/l10n.dart';
import 'package:xcloudsdk_flutter_example/pages/alarm_message/model/model.dart';
import 'package:xcloudsdk_flutter_example/views/toast/toast.dart';
import '../../common/base_const.dart';

class AlarmMessageDetailPage extends StatefulWidget {
  final AlarmMessage message;
  const AlarmMessageDetailPage({Key? key, required this.message})
      : super(key: key);

  @override
  State<AlarmMessageDetailPage> createState() => _AlarmMessageListPageState();
}

class _AlarmMessageListPageState extends State<AlarmMessageDetailPage> {
  late AlarmMessage _message;
  late File _localImageFile;
  bool _isHasFile = false;

  @override
  void initState() {
    _message = widget.message;

    Future.delayed(Duration.zero, () async {
      _checkIsHasLocalData();
    });
    super.initState();
  }

  void _checkIsHasLocalData() async {
    String picImage = _message.picinfo!.name!;
    String directoryPath = await _getDirectoryPath();
    String imagePath = '$directoryPath/$picImage';
    File imageFile = File(imagePath);
    if (await imageFile.exists()) {
      ///本地对应的图片，直接加载显示
      KToast.show(status: '正在加载本地图片');
      setState(() {
        _isHasFile = true;
        _localImageFile = imageFile;
      });
    } else {
      /// 没有，先下载，存到本地再显示
      KToast.show();
      String imageURL = _message.picinfo!.originalImage!;
      http
          .get(
        Uri.parse(imageURL),
      )
          .then((value) {
        KToast.dismiss();
        final data = value.bodyBytes;
        imageFile.writeAsBytesSync(data);
        setState(() {
          _isHasFile = true;
          _localImageFile = imageFile;
        });
      }).catchError((error) {
        KToast.show(status: '图片下载错误');
      });
    }
  }

  /// 本地存报警图片的文件夹,没有的话就会创建
  Future<String> _getDirectoryPath() async {
    Directory? directory;
    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      //isAndroid
      directory = await getExternalStorageDirectory();
    }
    const folderName = "alarm_images";
    final dPathStr = '/${directory!.path}/$folderName';
    final dPath = Directory(dPathStr);
    if (await dPath.exists()) {
      return Future.value(dPathStr);
    } else {
      dPath.create();
      return Future.value(dPathStr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(TR.current.messageDetail),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isHasFile)
                Image.file(
                  _localImageFile,
                  width: kScreenWidth,
                  height: kScreenWidth * 9 / 16,
                )
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
