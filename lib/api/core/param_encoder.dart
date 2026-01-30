import 'dart:convert';

class ParamEncoder {
  ///将 map 转换为 key=value&key1=value1 的形式
  static String encode(Map<String, dynamic> param, String? contentType) {
    if (contentType != null &&
        contentType.toLowerCase().trim() == "application/json") {
      return jsonEncode(param);
    }
    if (param.isEmpty) {
      return '';
    }
    List<String> pairs = [];
    for (var key in param.keys) {
      dynamic value = param[key];
      if (value is Map) {
        pairs.add('$key=${Uri.encodeQueryComponent(json.encode(value))}');
      } else {
        pairs.add('$key=${Uri.encodeQueryComponent(value.toString())}');
      }
    }
    return pairs.join('&');
  }
}
