import 'package:flutter/material.dart';

class DateObject {
  final DateTime date;
  final int type;//0:空白日期 1:真实日期 2:无效日期(不在beginDatetime和endDatetime之内的日期)
  const DateObject(this.date,this.type);
}

const calendarColorHasDataDay = Colors.cyan;
const calendarCColorIsToday = Colors.blue;
const calendarColorSelectedDay = Colors.orange;

class RFCalendarMonthView extends StatelessWidget {
  final DateTime beginDatetime;
  final DateTime endDatetime;
  final DateTime monthDate;
  final Map<DateTime,int> hasDataDateMap;//有数据的日期map
  final DateTime selectedDate;//选中的日期
  final Function(DateTime selectedDateTime) onSelected;

  const RFCalendarMonthView({Key? key, required this.monthDate, required this.hasDataDateMap, required this.selectedDate, required this.beginDatetime, required this.endDatetime, required this.onSelected}) : super(key: key);

  //计算某个月有多少天
  int getDaysInMonth(int year, int month) {
    final date = DateTime(year, month);
    final nextMonth = DateTime(month < 12 ? year : year + 1, (month % 12) + 1);
    final days = nextMonth.difference(date).inDays;
    return days;
  }

  //判断是否是同一天
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Widget _itemBuilder(BuildContext context, DateObject dateObject) {
    //空白日期 直接返回空白，不显示日期
    if (dateObject.type == 0) {
      return Container(color: Colors.transparent,);
    }
    //是否是选中日期
    bool isSelectedDate = _isSameDay(dateObject.date, selectedDate);
    //是否有数据
    bool isHasData = hasDataDateMap.containsKey(dateObject.date);
    //是否是今天
    bool isToday = _isSameDay(dateObject.date, DateTime.now());
    //是否在有效期范围内
    bool isInDate = dateObject.type == 1;
    //背景色
    Color bgColor = Colors.transparent;
    if (isToday) {
      bgColor = calendarCColorIsToday;
    }
    if (isSelectedDate) {
      bgColor = calendarColorSelectedDay;
    }

    return InkWell(
      onTap: () {
        //有效日期才响应点击
        if (isInDate)  {
          onSelected(dateObject.date);
        }
      },
      child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: bgColor, // 设置背景颜色
            shape: BoxShape.circle, // 将Container形状设置为圆形
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5,
              ),
              Text(dateObject.date.day.toString(),style: TextStyle(fontSize: 20,color: isInDate ? Colors.black : Colors.grey),),
              Container(
                height: 5,
                width: 5,
                decoration: BoxDecoration(
                  color: isHasData ? calendarColorHasDataDay : Colors.transparent, // 设置背景颜色
                  shape: BoxShape.circle, // 将Container形状设置为圆形
                ),
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final weakList = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    //计算这个月有几天这个月有几天
    int monthDays = getDaysInMonth(monthDate.year,monthDate.month);
    //判断这个月的第一天是星期几
    int weekFirst = DateTime(monthDate.year,monthDate.month,1).weekday;
    //有多少个空白日期
    int emptyDays = weekFirst - 1;

    List<DateObject> dataList = [];
    //空白日期
    while (emptyDays > 0) {
      final dateObject = DateObject(DateTime.now(), 0);
      dataList.add(dateObject);
      emptyDays--;
    }
    //真正的日期
    for (int i = 1; i <= monthDays; i++) {
      DateTime dateTime = DateTime(monthDate.year,monthDate.month,i);
      int type = 1;//默认为有效日期
      //是否在结束日期之后
      if (dateTime.isBefore(beginDatetime)) {
        type = 2;
      }
      //是否在开始日期之前
      if (dateTime.isAfter(endDatetime)) {
        type = 2;
      }
      final dateObject = DateObject(dateTime, type);
      dataList.add(dateObject);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              // mainAxisSpacing: 10.0, //垂直item之间间距
              // crossAxisSpacing: 10.0, //水平item之间间距
              childAspectRatio: 1.5, //宽高比
            ),
            itemBuilder: (context, index) {
              return Container(
                color: Colors.white,
                child: Center(
                  child: Text(weakList[index]),
                ),
              );
            },
            itemCount: weakList.length,
            padding: EdgeInsets.zero, // 禁用尾部填充器
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true),
        GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              // mainAxisSpacing: 10.0, //垂直item之间间距
              // crossAxisSpacing: 10.0, //水平item之间间距
              childAspectRatio: 1, //宽高比
            ),
            itemBuilder: (context,index) {
              return _itemBuilder(context, dataList[index]);
            },
            itemCount: dataList.length,
            padding: EdgeInsets.zero, // 禁用尾部填充器
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true),
      ],
    );
  }
}
