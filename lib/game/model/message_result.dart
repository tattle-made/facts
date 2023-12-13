import 'package:facts/game/model/message_popup_screen.dart';

class MessageResult {
  final MessagePopupScreen success;
  final MessagePopupScreen failure;

  MessageResult({required this.success, required this.failure});
}
