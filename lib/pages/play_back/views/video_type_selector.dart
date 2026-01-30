import 'package:flutter/material.dart';
class VideoTypeSelector extends StatefulWidget {
  const VideoTypeSelector({Key? key}) : super(key: key);

  @override
  State<VideoTypeSelector> createState() => _VideoTypeSelectorState();
}

enum VideoType {
  all, //全部
  normal, //普通
  warring, //警告
}
// extension VideoTypeExtension on VideoType {
//   String
// }

class _VideoTypeSelectorState extends State<VideoTypeSelector> {

  VideoType _videoType = VideoType.all;


  _onChangeVideoType(VideoType type) {
    setState(() {
      _videoType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 50,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue,width: 2),
          color: Colors.blue,
          borderRadius: const BorderRadius.all(Radius.circular(5))

      ),

      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
              color: _videoType == VideoType.all ? Colors.blue : Colors.grey,
              child: GestureDetector(
                onTap: () {
                  if (_videoType != VideoType.all) {
                    _onChangeVideoType(VideoType.all);
                  }
                },
                child: const Center(
                  child: Text(
                    '全部',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

            Container(
              width: 50,
              color: _videoType == VideoType.normal ? Colors.blue : Colors.grey,
              child: GestureDetector(
                onTap: () {
                  if (_videoType != VideoType.normal) {
                    _onChangeVideoType(VideoType.normal);
                  }
                },
                child: const Center(
                  child: Text(
                    '普通',
                    style: TextStyle(color: Colors.white,fontSize: 15),
                  ),
                ),
              ),
            ),

            Container(
              width: 50,
              color: _videoType == VideoType.warring ? Colors.blue : Colors.grey,
              child: GestureDetector(
                onTap: () {
                  if (_videoType != VideoType.warring) {
                    _onChangeVideoType(VideoType.warring);
                  }
                },
                child: const Center(
                  child: Text(
                    '警告',
                    style: TextStyle(color: Colors.white,fontSize: 15),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
