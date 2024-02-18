import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

class BaseMessageList {
  List<BaseMessage> messageList = [];

  set Basemessage(BaseMessageA) => messageList = BaseMessageA;
  get message => messageList;
}
