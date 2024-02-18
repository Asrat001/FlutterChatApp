import 'package:flutter/material.dart';

class CurrentUserMessage extends StatefulWidget {
  final String message;
  const CurrentUserMessage({super.key, required this.message});

  @override
  State<CurrentUserMessage> createState() => _CurrentUserMessageState();
}

class _CurrentUserMessageState extends State<CurrentUserMessage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Text(
            widget.message,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
