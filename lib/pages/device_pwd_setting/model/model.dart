///设备安全能力级
class GetSafetyAbilityModel {
  GetSafetyAbility? getSafetyAbility;
  String? name;
  int? ret;

  GetSafetyAbilityModel({this.getSafetyAbility, this.name, this.ret});

  GetSafetyAbilityModel.fromJson(Map<String, dynamic> json) {
    getSafetyAbility = json['GetSafetyAbility'] != null
        ? GetSafetyAbility.fromJson(json['GetSafetyAbility'])
        : null;
    name = json['Name'];
    ret = json['Ret'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getSafetyAbility != null) {
      data['GetSafetyAbility'] = getSafetyAbility!.toJson();
    }
    data['Name'] = name;
    data['Ret'] = ret;
    return data;
  }
}

class GetSafetyAbility {
  int? question;
  int? verifyQRCode;

  GetSafetyAbility({this.question, this.verifyQRCode});

  GetSafetyAbility.fromJson(Map<String, dynamic> json) {
    question = json['Question'];
    verifyQRCode = json['VerifyQRCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Question'] = question;
    data['VerifyQRCode'] = verifyQRCode;
    return data;
  }
}

///问题列表
class PwdQuestion {
  String? name;
  List<String>? questionDelivery;
  int? ret;
  String? sessionID;

  PwdQuestion({this.name, this.questionDelivery, this.ret, this.sessionID});

  PwdQuestion.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    questionDelivery = json['QuestionDelivery'].cast<String>();
    ret = json['Ret'];
    sessionID = json['SessionID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['QuestionDelivery'] = questionDelivery;
    data['Ret'] = ret;
    data['SessionID'] = sessionID;
    return data;
  }
}

///已经设置的问题
class PwdQuestionHadSet {
  GetSafetyQuestion? getSafetyQuestion;
  String? name;
  int? ret;

  PwdQuestionHadSet({this.getSafetyQuestion, this.name, this.ret});

  PwdQuestionHadSet.fromJson(Map<String, dynamic> json) {
    getSafetyQuestion = json['GetSafetyQuestion'] != null
        ? GetSafetyQuestion.fromJson(json['GetSafetyQuestion'])
        : null;
    name = json['Name'];
    ret = json['Ret'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getSafetyQuestion != null) {
      data['GetSafetyQuestion'] = getSafetyQuestion!.toJson();
    }
    data['Name'] = name;
    data['Ret'] = ret;
    return data;
  }
}

class GetSafetyQuestion {
  List<String>? question;

  GetSafetyQuestion({this.question});

  GetSafetyQuestion.fromJson(Map<String, dynamic> json) {
    question = json['Question'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Question'] = question;
    return data;
  }
}

