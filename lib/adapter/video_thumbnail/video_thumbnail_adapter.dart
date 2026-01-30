import 'package:xcloudsdk_flutter_example/adapter/video_thumbnail/video_thumbnail_default.dart'; // ignore: unused_import
import 'package:xcloudsdk_flutter_example/adapter/video_thumbnail/video_thumbnail_ohos.dart'; // ignore: unused_import

abstract class VideoThumbnailAdapter {
  Future<String> generateThumbnail(String videoPath);

  static VideoThumbnailAdapter get instance {
    return JFVideoThumbnail();
  }
}