//#网络
//http: ^0.13.6
//#下载
//#  flutter_downloader: ^1.10.4
//#ffmpeg
//ffmpeg_kit_flutter: ^5.1.0-LTS

// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
//
// class M3U8Downloader {
//   static Future<void> downloadM3U8(String url, Function(double) progressCallback) async {
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       final playlistContent = response.body;
//
//       final directory = await getApplicationDocumentsDirectory();
//       final filePath = '${directory.path}/downloaded.m3u8';
//       final file = File(filePath);
//       await file.writeAsString(playlistContent);
//
//       final playlistLines = LineSplitter.split(playlistContent);
//       int totalSegments = 0;
//       int downloadedSegments = 0;
//
//       // 获取总片段数
//       for (final line in playlistLines) {
//         if (line.isNotEmpty && !line.startsWith('#')) {
//           totalSegments++;
//         }
//       }
//
//       // 下载每个片段
//
//       for (var i = 0; i < playlistLines.length; i++) {
//         final line = playlistLines.elementAt(i);
//         if (line.isNotEmpty && !line.startsWith('#')) {
//           final segmentUrl = _resolveSegmentUrl(url, line);
//           final segmentFilePath = '${directory.path}/segment_$i.ts';
//           await _downloadSegment(segmentUrl, segmentFilePath);
//
//           downloadedSegments++;
//           final progress = downloadedSegments / totalSegments;
//           progressCallback(progress);
//         }
//       }
//     } else {
//       throw Exception('Failed to download m3u8 file.');
//     }
//   }
//
//   static String _resolveSegmentUrl(String playlistUrl, String segmentUrl) {
//     // 根据m3u8文件的相对路径和基本URL解析出片段的完整URL
//     final baseUrl = playlistUrl.substring(
//         0, playlistUrl.lastIndexOf('/') + 1);
//     final resolvedUrl = Uri.parse(baseUrl).resolve(segmentUrl);
//     return resolvedUrl.toString();
//   }
//
//   static Future<void> _downloadSegment(String url, String filePath) async {
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       final file = File(filePath);
//       await file.writeAsBytes(response.bodyBytes);
//     } else {
//       throw Exception('Failed to download m3u8 segment.');
//     }
//   }
// }