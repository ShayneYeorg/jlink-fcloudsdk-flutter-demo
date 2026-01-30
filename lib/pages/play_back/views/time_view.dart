import 'package:flutter/material.dart';

class TimeViewPage extends StatefulWidget {
  const TimeViewPage({Key? key}) : super(key: key);

  @override
  State<TimeViewPage> createState() => _TimeViewPageState();
}

class _TimeViewPageState extends State<TimeViewPage> {
  List<int> times = [];

  @override
  void initState() {
    for (var i =0; i<720;i++) {
      times.add(i+1);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('time view'),),
      body: Container(
        color: Colors.white,
        child: TimeLineView(times: times,),
      ),
    );
  }
}

typedef TimeChanged = Function(DateTime dateTime);

class TimeLineView extends StatefulWidget {
  const TimeLineView(
      {Key? key,
        required this.times,
        this.currentTime,
        this.height = 80,
        this.tickShortHeight = 12,
        this.tickLongHeight = 20,
        this.tickWidth = 1,
        this.tickHeight = 2,
        this.normalColor = Colors.redAccent,
        this.alertColor = Colors.blue,
        this.lineColor = Colors.black,
        this.unit = 20,
        this.unitWidth = 10})
      : super(key: key);

  ///View 高度
  final double height;

  ///刻度线 短 高度
  final double tickShortHeight;

  ///刻度线 长 高度
  final double tickLongHeight;

  ///刻度线 宽度
  final double tickWidth;

  ///中间刻度线 高度
  final double tickHeight;

  ///普通视频颜色
  final Color normalColor;

  ///报警视频颜色
  final Color alertColor;

  ///刻度尺颜色
  final Color lineColor;

  ///间隔 20 分钟或 1分钟
  final int unit;

  ///间隔宽度
  final int unitWidth;

  ///按时间查询的 时间数据 长度 720
  final List<int> times;

  ///当前时间轴的开始时间.在播放过程中,通过视频回调不断更新
  final DateTime? currentTime;

  @override
  State<TimeLineView> createState() => _TimeLineViewState();
}

class _TimeLineViewState extends State<TimeLineView> {
  final ScrollController scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
              ),
              CustomPaint(
                size: getSize(),
                painter: TimeLineCustomPainter(widget),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Container(
            width: 2,
            height: widget.height,
            color: Colors.redAccent,
          ),
        )
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  double dx = 0;

  ///获取可绘制区域的宽高
  Size getSize() {
    //1440像素值 转化为 dp
    return Size(1440 / widget.unit * widget.unitWidth, widget.height);
  }
}

class TimeLineCustomPainter extends CustomPainter {
  final TimeLineView widget;

  ///需要画刻度的数量
  int tickCount = 0;

  List<int> timeDots = [];

  TimeLineCustomPainter(this.widget) {
    tickCount = 1440 ~/ widget.unit;
    for (var time in widget.times) {
      int a = time >> 4;
      int b = time & 15;
      timeDots.add(a);
      timeDots.add(b);
    }
  }

  double getTop(Size size, double height) {
    return size.height / 2 - height / 2;
  }

  double getBottom(Size size, double height) {
    return size.height / 2 + height / 2;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);

    canvas.drawRect(
        Rect.fromLTRB(
            0, 0, tickCount * widget.unitWidth.toDouble(), size.height),
        Paint()..color = Colors.blueGrey);
    // //画背景数据
    // for (int i = 0; i < timeDots.length; i++) {
    //   //一分钟
    //   int dot = timeDots[i];
    //   if (dot > 0) {
    //     canvas.drawLine(
    //         Offset(i.toDouble() * 0.5, 0),
    //         Offset(i.toDouble() * 0.5, size.height),
    //         Paint()
    //           ..color = widget.alertColor
    //           ..strokeWidth = 0.6);
    //   }
    // }
    //画刻度
    for (int i = 0; i <= tickCount; i++) {
      if (i == 0 || i == tickCount) {
        continue;
      }
      if (i % 3 == 0) {
        canvas.drawLine(
            Offset(i * widget.unitWidth.toDouble(),
                getTop(size, widget.tickLongHeight)),
            Offset(i * widget.unitWidth.toDouble(),
                getBottom(size, widget.tickLongHeight)),
            Paint()
              ..color = widget.lineColor
              ..strokeWidth = widget.tickWidth);
        drawText(i, canvas, size);
      } else {
        canvas.drawLine(
            Offset(i * widget.unitWidth.toDouble(),
                getTop(size, widget.tickShortHeight)),
            Offset(i * widget.unitWidth.toDouble(),
                getBottom(size, widget.tickShortHeight)),
            Paint()
              ..color = widget.lineColor
              ..strokeWidth = widget.tickWidth);
      }
      // //画水平线
      // canvas.drawLine(
      //     Offset(0, size.height / 2),
      //     Offset(tickCount * widget.unitWidth.toDouble(), size.height / 2),
      //     Paint()
      //       ..color = widget.lineColor
      //       ..strokeWidth = widget.tickWidth);
    }

    //画水平线
    canvas.drawLine(
        Offset(0, size.height / 2),
        Offset(tickCount * widget.unitWidth.toDouble(), size.height / 2),
        Paint()
          ..color = widget.lineColor
          ..strokeWidth = widget.tickWidth);
  }

  void drawText(int i, Canvas canvas, Size size) {
    var textPainter = TextPainter(
        text: TextSpan(
            text: "${i ~/ 3}",
            style: const TextStyle(fontSize: 10, color: Colors.black)),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left);
    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset(i * widget.unitWidth - 3,
            getBottom(size, widget.tickLongHeight) + 5));
  }

  @override
  bool shouldRepaint(covariant TimeLineCustomPainter oldDelegate) {
    return false;
  }
}
