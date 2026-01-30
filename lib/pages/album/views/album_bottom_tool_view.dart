import 'package:flutter/material.dart';

class AlbumBottomToolView extends StatefulWidget {
  final Function() onDelete;
  final Function() onShare;
  final Function() onSelectAll;
  final Function() onCancel;
  final bool isSelectedAll;
  const AlbumBottomToolView({Key? key, required this.onDelete, required this.onShare, required this.onSelectAll, required this.onCancel, required this.isSelectedAll}) : super(key: key);

  @override
  State<AlbumBottomToolView> createState() => _AlbumBottomToolViewState();
}

class _AlbumBottomToolViewState extends State<AlbumBottomToolView> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 50 + MediaQuery.of(context).padding.bottom,
      child: Column(
        children: [
          Container(
            height: 1,
            color: Colors.black,
          ),
          SizedBox(
            height: 49,
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      widget.onDelete();
                    },
                    child: const Text(
                      '删除',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25),
                    )),
                TextButton(
                    onPressed: () {
                      widget.onShare();
                    },
                    child: const Text(
                      '分享',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25),
                    )),
                TextButton(
                    onPressed: () {
                      widget.onSelectAll();
                    },
                    child: Text(
                      widget.isSelectedAll ? '取消全选':'全选',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25),
                    )),
                TextButton(
                    onPressed: () {
                      widget.onCancel();
                    },
                    child: const Text(
                      '取消',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
