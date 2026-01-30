
import 'package:xcloudsdk_flutter/utils/date_util.dart';

class CloudRecordResult {
  String? msg;
  String? code;
  List<CloudRecord>? records;

  CloudRecordResult(this.msg, this.code, this.records);

  CloudRecordResult.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    if (json['vidlist'] != null) {
      records = json['vidlist']
          .map<CloudRecord>((e) => CloudRecord.fromJson(e))
          .toList();
    }
  }
}

class CloudRecord {
  String? st;
  String? indx;
  String? et;
  int? picfg;
  String? bucket;
  int? vidsz;
  String? url;
  bool select = false;

  CloudRecord(
      {this.st,
      this.indx,
      this.et,
      this.picfg,
      this.bucket,
      this.vidsz,
      this.url});

  CloudRecord.fromJson(Map<String, dynamic> json) {
    st = json['st'];
    indx = json['indx'];
    et = json['et'];
    picfg = json['picfg'];
    bucket = json['bucket'];
    vidsz = json['vidsz'];
    url = json['vidUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['st'] = st;
    data['indx'] = indx;
    data['et'] = et;
    data['picfg'] = picfg;
    data['bucket'] = bucket;
    data['vidsz'] = vidsz;
    data['vidUrl'] = url;
    return data;
  }

  DateTime get beginTime => DateUtil.fromDateString(st!);

  DateTime get endTime => DateUtil.fromDateString(et!);
}

class CloudTimelineResult {
  String? msg;
  String? code;
  String? dt;
  List<TimeAxis>? timeAxis;

  CloudTimelineResult(this.msg, this.code, this.dt, this.timeAxis);

  CloudTimelineResult.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    dt = json['dt'];
    if (json['tmaix'] != null && json['tmaix'].isNotEmpty) {
      timeAxis =
          json['tmaix'].map<TimeAxis>((e) => TimeAxis.fromJson(e)).toList();
    }
  }
}

class TimeAxis {
  DateTime? startTime;
  DateTime? endTime;
  int? type;

  TimeAxis(this.startTime, this.endTime, this.type);

  TimeAxis.fromJson(Map<String, dynamic> json) {
    startTime = DateUtil.fromDateString(json['st']);
    endTime = DateUtil.fromDateString(json['et']);
    type = json['tp'];
  }
}
