import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/failures/failures.dart';
import '../../../../domain/entiti/message_entity.dart';
import '../../../../domain/usecase/admin_usecase.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final AdminUsecase usecase;
  StreamSubscription<Either<Failure, List<MessageEntity>>>? _subscription;

  MessageBloc(this.usecase) : super(MessageInitial()) {
    on<StartListeningToMessages>((event, emit) {
      emit(MessageLoading());
      _subscription = usecase.listenToMessages().listen(
        (either) {
          add(newMessages(either));
        },
      );
    });

    on<newMessages>(
      (event, emit) {
        event.messagesEither.fold((failur) {
          emit(MessageError(failur.message));
        }, (message) {
          emit(MessageLoaded(message));
        });
      },
    );

    on<sendMessage>(
      (event, emit) async {
        final temp = (state as MessageLoaded).messages;
        emit(MessageLoaded(temp));
        final result = await usecase.sendMessage(event.senderId, event.text);
        result.fold((faluir) {
          emit(MessageError(faluir.message));
        }, (_) {
          add(StartListeningToMessages());
        });
      },
    );
  }
  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
