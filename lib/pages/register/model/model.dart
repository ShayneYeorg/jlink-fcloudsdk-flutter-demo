class AreaCodeModel {
  ///标识符
  int? id;

  ///国家
  String? country;

  ///手机号正则表达式
  String? rule;

  ///区号
  String? head;

  ///国家缩写
  String? remark;

  ///是否是默认国家(默认中国)
  bool? def;

  AreaCodeModel(
      {this.id, this.country, this.rule, this.head, this.remark, this.def});

  AreaCodeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country = json['country'];
    rule = json['rule'];
    head = json['head'];
    remark = json['remark'];
    def = json['def'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['country'] = country;
    data['rule'] = rule;
    data['head'] = head;
    data['remark'] = remark;
    data['def'] = def;
    return data;
  }
}
