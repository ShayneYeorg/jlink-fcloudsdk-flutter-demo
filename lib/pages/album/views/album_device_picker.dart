import 'package:flutter/material.dart';

class AlbumDevicePicker extends StatefulWidget {
  final List<String> dataList;
  final String selectedDevice;
  final Function(String device) onSelectDeviceCallback;
  const AlbumDevicePicker(
      {Key? key,
      required this.onSelectDeviceCallback,
      required this.dataList,
      required this.selectedDevice})
      : super(key: key);

  @override
  State<AlbumDevicePicker> createState() => _AlbumDevicePickerState();
}

class _AlbumDevicePickerState extends State<AlbumDevicePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
      ),
      child: ListView.separated(
          itemBuilder: (context, index) {
            final title = widget.dataList[index];
            final isSelected = title == widget.selectedDevice;
            return GestureDetector(
                onTap: () {
                  widget.onSelectDeviceCallback(title);
                },
                child: Container(
                  height: 50,
                  color: Colors.white,
                  child: ListTile(
                      title: Text(title),
                      trailing: Icon(isSelected
                          ? Icons.check_circle
                          : Icons.circle_outlined,color: Colors.blue)),
                ));
          },
          separatorBuilder: (context, index) {
            return Container(
              height: 1.0,
              color: Colors.white,
              child: Row(
                children: [
                  Container(width: 20,),
                  Expanded(child: Container(
                    color: Colors.grey,
                    height: 1,)),
                ],
              ),
            );
          },
          itemCount: widget.dataList.length,),
    );
  }
}
