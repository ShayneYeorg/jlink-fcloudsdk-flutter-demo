import 'package:flutter/material.dart';

typedef InputCallBack = void Function(String name, String pwd);

class InputInfoWidget extends StatefulWidget {
  final InputCallBack callBack;

  const InputInfoWidget({Key? key, required this.callBack}) : super(key: key);

  @override
  State<InputInfoWidget> createState() => _InputInfoWidgetState();
}

class _InputInfoWidgetState extends State<InputInfoWidget> {
  late final TextEditingController nameController;
  late final TextEditingController pwdController;

  @override
  void initState() {
    nameController = TextEditingController();
    nameController.text = "admin";
    pwdController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(18))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: "请输入用户名",
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: pwdController,
            decoration: const InputDecoration(
              icon: Icon(Icons.password),
              hintText: "请输入密码",
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () {
                    widget.callBack(nameController.text, pwdController.text);
                  },
                  child: const Text("登录设备")),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.grey),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("取消"))
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    pwdController.dispose();
    super.dispose();
  }
}
