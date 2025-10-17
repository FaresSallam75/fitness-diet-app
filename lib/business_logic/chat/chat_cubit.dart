import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ordering_app/business_logic/chat/chat_state.dart';
import 'package:ordering_app/core/services/get_it_services.dart';
import 'package:ordering_app/core/services/secure_storage.dart';
import 'package:ordering_app/data/model/card_chat_model.dart';
import 'package:ordering_app/data/model/chat_model.dart';
import 'package:ordering_app/data/model/coachmodel.dart';
import 'package:ordering_app/data/repositary/chat_repository.dart';
import 'package:ordering_app/main.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository chatRepository;
  ChatCubit(this.chatRepository)
    : super(const ChatInitialState(isSelected: false));

  SecureStorage storage = GetItServices.getIt<SecureStorage>();
  StreamSubscription? _chatSubscription;
  List<ChatModel> listChats = [];
  List<CardChatModel> listCardChats = [];
  String? coachId;

  Future<void> getAllChats(String? reciever) async {
    emit(ChatLoadingState());
    await getCoachData();
    await _chatSubscription?.cancel();
    _chatSubscription = chatRepository
        .getAllChats(
          coachId ?? myBox!.get("userId").toString(),
          reciever ?? myBox!.get("userId").toString(),
        ) //myBox!.get("userId")
        .listen((result) {
          result.fold(
            (failure) {
              emit(ChatFailureState(failure.message));
            },
            (menuModel) {
              listChats = menuModel
                  .map<ChatModel>((data) => ChatModel.fromJson(data))
                  .toList();
              emit(ChatLoadedState(listChats, []));
            },
          );
        });
  }

  Future<void> sendMessage(
    String reciever,
    String message, [
    File? file,
  ]) async {
    final tempMessage = ChatModel(
      sender: myBox!.get("userId") ?? coachId,
      reciever: reciever,
      message: message,
      file: file?.path.split('/').last,
      dateTime: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
    );

    listChats.insert(0, tempMessage);
    emit(ChatLoadedState(List.from(listChats), []));

    // بعدين ابعتها للسيرفر
    await _chatSubscription?.cancel();
    _chatSubscription = chatRepository
        .sendMessageData(
          myBox!.get("userId") ?? coachId,
          reciever,
          message,
          file,
        )
        .listen((result) {
          result.fold(
            (failure) {
              emit(ChatFailureState(failure.message));
            },
            (menuModel) {
              // هنا ممكن تعمل refresh كامل من السيرفر
              // getAllChats(reciever);
            },
          );
        });
  }

  Future<CoachModel?> getCoachData() async {
    final jsonString = await storage.getCoachData();
    if (jsonString != null) {
      final map = jsonDecode(jsonString);
      coachId = map['id'].toString();
      log("map ========================== $map");
      log("coacheId ========================== ${map['id']}");
      return CoachModel.fromJson(map);
    }
    return null;
  }

  Future<void> cardChats() async {
    emit(ChatLoadingState());
    await getCoachData();
    await _chatSubscription?.cancel();
    _chatSubscription = chatRepository.getCardChats(coachId!).listen((result) {
      result.fold(
        (failure) {
          emit(ChatFailureState(failure.message));
        },
        (menuModel) {
          listCardChats = menuModel
              .map<CardChatModel>((data) => CardChatModel.fromJson(data))
              .toList();
          emit(ChatLoadedState([], listCardChats));
          log("listCardChats =========================== $listCardChats");
        },
      );
    });
  }

  void refreshChats(String reciever) {
    getAllChats(reciever);
    emit(ChatLoadedState(List.from(listChats), []));
  }

  @override
  Future<void> close() {
    _chatSubscription?.cancel();
    return super.close();
  }
}
