import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import '../utils/messageList.dart';

class MyOpenChannelHandler extends OpenChannelHandler {
  // Add this object through SendbirdChat.addChannelHandler('UNIQUE_HANDLER_ID', this).
  // Or remove it through SendbirdChat.removeChannelHandler('UNIQUE_HANDLER_ID') when it's no longer needed.
  BaseMessageList base = BaseMessageList();
  @override
  void onMessageReceived(BaseChannel channel, BaseMessage message) {
    // You can customize how to display different types of messages with the result object in the message parameter.
    if (message is UserMessage) {
      base.Basemessage = message;
    } else if (message is FileMessage) {
      // ...

      // ...
    }
  }
}
