import 'package:flutter/material.dart';
import '../componets/message_input.dart';
import '../componets/message_body.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import '../componets/current_user_Messsage.dart';
import '../utils/MessageHandelr.dart';
import '../utils/messageList.dart';

class HomePage extends StatefulWidget {
  // final String? channelUrl;
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  late OpenChannel channel;
  TextEditingController messageController = TextEditingController();
  late FocusNode _focusNode = FocusNode();
  late OpenChannelHandler openChannelHandler;
  BaseMessageList messageList = BaseMessageList();
  late bool focused;
  @override
  void initState() {
    super.initState();
    _initChannel();

    SendbirdChat.addChannelHandler("dhgeteueqkivwqT5", MyOpenChannelHandler());
  }

  void _initChannel() async {
    try {
      print("hey load yey");
      channel = await OpenChannel.getChannel(
          "sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac9211");
      // Call the instance method of the result object in the openChannel parameter of the callback method.
      print(" hey load ${channel.name} ");
      channel.enter();

      _loadMessages();

      // The current user successfully enters the open channel as a participant,
      // and can chat with other users in the channel using APIs.
    } catch (e) {
      print("initchanel $e");
    }
  }

  _loadMessages() async {
    var params = MessageListParams();

    try {
      final messages = await channel.getMessagesByTimestamp(
          DateTime.now().millisecondsSinceEpoch * 1000, params);
      setState(() {
        messageList.Basemessage = messages.cast<BaseMessage>().toList();
      });
      print("messages are  ");
    } catch (error) {
      print("the error is: $error");
    }
  }

  @override
  void dispose() {
    // Clean up resources, subscriptions, controllers, etc.
    // This method is called when the associated State object is removed from the widget tree.
    super.dispose();
    _focusNode.dispose();
    SendbirdChat.removeChannelHandler("dhgeteueqkivwqT5");
  }

  _sendMessage() async {
    try {
      final params = UserMessageCreateParams(message: messageController.text)
        ..data = 'DATA'
        ..customType = 'CUSTOM_TYPE';

      final message = channel.sendUserMessage(params, handler: (message, e) {
        // The message is successfully sent to the channel.
        // The current user can receive messages from other users
        // through the onMessageReceived() method in event handlers.
      });

      messageController.clear();
      print("send mesage ${message.sender?.nickname}");
    } catch (e) {
      // Handle error.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('강남스팟'),
        centerTitle: true,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.grey,
        ),
        backgroundColor: Colors.black,
        actions: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Icons.menu,
              color: Colors.grey,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment:messag ,
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: messageList.messageList.length,
                        itemBuilder: (context, index) {
                          var message = messageList.message[index];

                          return MessageBody(
                            name: message.sender?.nickname,
                            message:
                                message is UserMessage ? message.message : "",
                            url: message is UserMessage
                                ? message.sender?.profileUrl
                                : "https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w600/2023/10/free-images.jpg",
                            timeStamp: message.createdAt.toString(),
                          );
                        }),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  const SizedBox(
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
                            controller: messageController,
                            style: const TextStyle(color: Colors.grey),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15.0),
                                border: InputBorder.none,
                                hintText: '메세지 보내기',
                                hintStyle: const TextStyle(color: Colors.grey),
                                suffixIcon: InkWell(
                                  onTap: () => {_sendMessage()},
                                  child: Container(
                                    padding: const EdgeInsets.all(2.0),
                                    margin: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        color: _focusNode.hasFocus
                                            ? Colors.redAccent
                                            : Colors.grey),
                                    child: const Icon(
                                      Icons.arrow_upward,
                                      size: 20.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                isCollapsed: false),
                            focusNode: _focusNode,
                          )))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
