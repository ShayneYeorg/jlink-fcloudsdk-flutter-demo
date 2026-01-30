// To parse this JSON data, do
//
//     final fileConfig = fileConfigFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

FileConfig fileConfigFromJson(String str) =>
    FileConfig.fromJson(json.decode(str));

String fileConfigToJson(FileConfig data) => json.encode(data.toJson());

class FileConfig {
  String type;
  String fileConfigDefault;
  String ohos;
  String target;
  bool fileConfigExport;

  FileConfig({
    required this.type,
    required this.fileConfigDefault,
    required this.ohos,
    required this.target,
    required this.fileConfigExport,
  });

  factory FileConfig.fromJson(Map<String, dynamic> json) => FileConfig(
        type: json["type"],
        fileConfigDefault: json["default"],
        ohos: json["ohos"],
        target: json["target"],
        fileConfigExport: json["export"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "default": fileConfigDefault,
        "ohos": ohos,
        "target": target,
        "export": fileConfigExport,
      };
}

const String envOhos = 'ohos';
const String envDefault = 'default';

///dart run flutter_import_update.dart  ohos
///dart run flutter_import_update.dart  default
void main(List<String> arguments) async {
  String env = arguments.first;

  final configFile = File('flutter_import_update.json');
  final configJson = await configFile.readAsString();

  List<FileConfig> configList = (jsonDecode(configJson) as List)
      .map((e) => FileConfig.fromJson(Map<String, dynamic>.from(e)))
      .toList();

  for (var config in configList) {
    await doConfig(config, env);
  }
}

Future doConfig(FileConfig config, String env) async {
  if (config.type == 'replace') {
    //文件替换
    File fromFile =
        File(env == envOhos ? config.ohos : config.fileConfigDefault);
    File targetFile = File(config.target);
    final contentFrom = await fromFile.readAsString();
    await targetFile.writeAsString(contentFrom);
    print('yaml 文件已替换');
  }

  if (config.type == 'import') {
    //1.分析 import 信息
    String plugin = env == envOhos ? config.ohos : config.fileConfigDefault;
    //打开注释的文件
    File unCommentFile = File(plugin);
    //需要注释的文件
    File commentFile =
        File(env == envOhos ? config.fileConfigDefault : config.ohos);
    await _processFileContent(unCommentFile, comment: false);
    await _processFileContent(commentFile, comment: true);
    //2. 查询 目标文件中 需要修改的 import 行数
    File targetFile = File(config.target);
    List<String> lines = await targetFile.readAsLines();

    await targetFile.writeAsString(lines.join('\n'));
  }

  if (config.type == 'export') {
    String oldImport = env == envOhos ? config.fileConfigDefault : config.ohos;
    String newImport = env == envOhos ? config.ohos : config.fileConfigDefault;
    File target = File(config.target);
    try {
      String content = await target.readAsString();
      final pattern = RegExp(oldImport);

      // 检查是否包含目标导入
      if (pattern.hasMatch(content)) {
        // 执行替换
        final newContent = content.replaceAll(pattern, newImport);
        if (newContent != content) {
          await target.writeAsString(newContent);
          print('[操作成功] 更新导入: ${target.path}');
        }
      }
    } catch (e) {
      print('[操作失败] 处理文件 ${target.path} 时出错: $e');
    }
  }
}

/// 处理文件内容（注释/取消注释）
/// [file] 目标文件
/// [comment] true=添加注释 false=取消注释
Future<void> _processFileContent(File file, {bool comment = true}) async {
  try {
    // 读取文件内容
    List<String> lines = await file.readAsLines();
    final processedLines = <String>[];

    // 逐行处理
    for (String line in lines) {
      if (comment) {
        // 添加注释：非空且未被注释的行
        if (line.trim().isNotEmpty &&
            !line.trimLeft().startsWith(RegExp(r'\/\/|\/\*|\*'))) {
          processedLines.add('// $line');
        } else {
          processedLines.add(line);
        }
      } else {
        // 取消注释：移除行首的 //
        final uncommented = line.replaceFirst(RegExp(r'^\s*//\s*'), '');
        processedLines.add(uncommented);
      }
    }

    // 写回文件
    await file.writeAsString(processedLines.join('\n'));
    print('[操作成功] ${comment ? '注释' : '取消注释'}文件: ${file.path}');
  } catch (e) {
    print('[操作失败] 处理文件 ${file.path} 时出错: $e');
  }
}
