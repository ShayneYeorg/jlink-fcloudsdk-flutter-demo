class AlarmMessageResult {
  String? msg;
  String? code;
  String? sn;
  int? msgnum;
  String? cstag;
  String? tag;
  List<AlarmMessage>? msglist;

  AlarmMessageResult(
      {this.msg,
        this.code,
        this.sn,
        this.msgnum,
        this.cstag,
        this.tag,
        this.msglist});

  AlarmMessageResult.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    sn = json['sn'];
    msgnum = json['msgnum'];
    cstag = json['cstag'];
    tag = json['tag'];
    if (json['msglist'] != null) {
      msglist = <AlarmMessage>[];
      json['msglist'].forEach((v) {
        msglist!.add(AlarmMessage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    data['code'] = code;
    data['sn'] = sn;
    data['msgnum'] = msgnum;
    data['cstag'] = cstag;
    data['tag'] = tag;
    if (msglist != null) {
      data['msglist'] = msglist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AlarmMessage {
  Picinfo? picinfo;
  Vidinfo? vidinfo;
  String? event;
  String? id;
  String? tm;
  String? alarmmsg;
  String? ch;

  AlarmMessage(
      {this.picinfo,
        this.vidinfo,
        this.event,
        this.id,
        this.tm,
        this.alarmmsg,
        this.ch});

  AlarmMessage.fromJson(Map<String, dynamic> json) {
    picinfo =
    json['picinfo'] != null ? Picinfo.fromJson(json['picinfo']) : null;
    vidinfo =
    json['vidinfo'] != null ? Vidinfo.fromJson(json['vidinfo']) : null;
    event = json['event'];
    id = json['id'];
    tm = json['tm'];
    alarmmsg = json['alarmmsg'];
    ch = json['ch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (picinfo != null) {
      data['picinfo'] = picinfo!.toJson();
    }
    if (vidinfo != null) {
      data['vidinfo'] = vidinfo!.toJson();
    }
    data['event'] = event;
    data['id'] = id;
    data['tm'] = tm;
    data['alarmmsg'] = alarmmsg;
    data['ch'] = ch;
    return data;
  }
}

class Picinfo {
  int? size;
  String? bucket;
  String? name;
  String? url;
  String? extm;
  String? originalImage;
  String? thumbnail;

  Picinfo(
      {this.size,
        this.bucket,
        this.name,
        this.url,
        this.extm,
        this.originalImage,
        this.thumbnail});

  Picinfo.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    bucket = json['bucket'];
    name = json['name'];
    url = json['url'];
    extm = json['extm'];
    originalImage = json['originalImage'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['size'] = size;
    data['bucket'] = bucket;
    data['name'] = name;
    data['url'] = url;
    data['extm'] = extm;
    data['originalImage'] = originalImage;
    data['thumbnail'] = thumbnail;
    return data;
  }
}

class Vidinfo {
  int? vidlen;

  Vidinfo({this.vidlen});

  Vidinfo.fromJson(Map<String, dynamic> json) {
    vidlen = json['vidlen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vidlen'] = vidlen;
    return data;
  }
}