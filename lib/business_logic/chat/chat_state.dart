import 'package:equatable/equatable.dart';
import 'package:ordering_app/data/model/card_chat_model.dart';
import 'package:ordering_app/data/model/chat_model.dart';

sealed class ChatState extends Equatable {
  const ChatState();
  @override
  List<Object?> get props => [];
}

final class ChatInitialState extends ChatState {
  final bool isSelected;
  const ChatInitialState({required this.isSelected});
  @override
  List<Object?> get props => [];
}

final class ChatLoadingState extends ChatState {
  const ChatLoadingState();
  @override
  List<Object?> get props => [];
}

final class ChatLoadedState extends ChatState {
  final List<ChatModel> listChat;
  final List<CardChatModel> listCardChat;
  const ChatLoadedState(this.listChat, this.listCardChat);
  @override
  List<Object?> get props => [listChat, listCardChat];
}

final class ChatFailureState extends ChatState {
  final String messageFailure;
  @override
  List<Object?> get props => [messageFailure];
  const ChatFailureState(this.messageFailure);
}
