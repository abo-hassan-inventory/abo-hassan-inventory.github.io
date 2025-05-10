part of 'message_bloc.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {}

class MessageLoaded extends MessageState {
  final List<MessageEntity> messages;
  const MessageLoaded(this.messages);
}

class MessageError extends MessageState {
  final String message;
  const MessageError(this.message);
}

class MessageSent extends MessageState {
  final String message;
  const MessageSent(this.message);
}
