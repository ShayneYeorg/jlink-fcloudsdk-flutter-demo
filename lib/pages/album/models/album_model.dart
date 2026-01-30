class Album {
  String type; //0:图片 1:视频
  String date; //日期
  String time; //时间 精确到秒
  String name; //设备名称
  String fullName; //文件全名
  String path; //文件路径
  bool isSelected; //是否被选中
  Album(
      {required this.type,
      required this.date,
      required this.time,
      required this.name,
      required this.fullName,
      required this.path,
      required this.isSelected});
}
