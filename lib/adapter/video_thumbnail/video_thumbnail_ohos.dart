import 'package:xcloudsdk_flutter_example/adapter/video_thumbnail/video_thumbnail_adapter.dart';
import 'package:video_thumbnail_ohos/video_thumbnail_ohos.dart';

class JFVideoThumbnail implements VideoThumbnailAdapter {
@override
Future<String> generateThumbnail(String videoPath) async {
String? path = await VideoThumbnailOhos.thumbnailFile(
video: videoPath,
imageFormat: ImageFormat.PNG,
maxWidth: 128,
quality: 25);
return path ?? '';
}
}