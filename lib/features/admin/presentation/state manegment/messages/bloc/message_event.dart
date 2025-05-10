part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class StartListeningToMessages extends MessageEvent {}

class newMessages extends MessageEvent {
  final Either<Failure, List<MessageEntity>> messagesEither;
  newMessages(this.messagesEither);
}

class sendMessage extends MessageEvent {
  final String senderId;
  final String text;
  sendMessage(this.senderId, this.text);
}
