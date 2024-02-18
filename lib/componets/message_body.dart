import 'package:flutter/material.dart';

class MessageBody extends StatefulWidget {
  final String? name, message, timeStamp, url;
  const MessageBody(
      {Key? key,
      required this.name,
      required this.message,
      required this.timeStamp,
      required this.url})
      : super(key: key);

  @override
  State<MessageBody> createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  @override
  Widget build(BuildContext context) {
    bool isCurrentUser = widget.name == "";
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment:
            isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          isCurrentUser
              ? SizedBox(
                  height: 1.0,
                )
              : CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.blue,
                  backgroundImage: NetworkImage(widget.url ??
                      "https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w600/2023/10/free-images.jpg"),
                ),
          const SizedBox(
            width: 10,
          ),
          _Messgaebody(
              userName: widget.name ?? "",
              message: widget.message ?? "",
              timeStamp: widget.timeStamp ?? "",
              isCurrentUser: isCurrentUser),
        ],
      ),
    );
  }
}

class _Messgaebody extends StatelessWidget {
  final String userName, message, timeStamp;
  final bool isCurrentUser;
  const _Messgaebody(
      {super.key,
      required this.userName,
      required this.message,
      required this.timeStamp,
      required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        isCurrentUser
            ? SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
              )
            : const SizedBox(
                width: 0.0,
              ),
        Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: isCurrentUser
                      ? Colors.redAccent
                      : Color.fromRGBO(26, 26, 26, 0.6),
                  borderRadius: BorderRadius.only(
                      topLeft:
                          isCurrentUser ? Radius.circular(20) : Radius.zero,
                      topRight:
                          isCurrentUser ? Radius.zero : Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        isCurrentUser ? "" : userName,
                        style: TextStyle(color: Colors.grey),
                      ),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                            color: isCurrentUser
                                ? Colors.transparent
                                : Colors.green,
                            borderRadius: BorderRadius.circular(10.0)),
                      )
                    ],
                  ),
                  Text(
                    message,
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            )),
        const SizedBox(
          width: 8.0,
        ),
        isCurrentUser
            ? Text("")
            : Text(timeStamp, style: TextStyle(color: Colors.grey))
      ],
    ));
  }
}
