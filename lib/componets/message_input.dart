import 'package:flutter/material.dart';

class MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final Future<void> Function() onSend;
  const MessageInput(
      {super.key, required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            Icons.add,
            color: Colors.white,
          ),
          SizedBox(
            width: 8.0,
          ),
          Expanded(
              child: Container(
            height: 48.0,
            width: 330.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            child: TextField(
              controller: controller,
              style: TextStyle(color: Colors.grey),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15.0),
                  border: InputBorder.none,
                  hintText: '메세지 보내기',
                  hintStyle: TextStyle(color: Colors.grey),
                  suffixIcon: GestureDetector(
                    onTap: () => onSend(),
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      margin: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.redAccent),
                      child: const Icon(
                        Icons.arrow_upward,
                        size: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  isCollapsed: false),
            ),
          )),
        ],
      ),
    );
  }
}
