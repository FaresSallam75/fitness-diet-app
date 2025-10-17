import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ordering_app/business_logic/chat/chat_cubit.dart';
import 'package:ordering_app/business_logic/chat/chat_state.dart';
import 'package:ordering_app/constants/fcmc.config.dart';
import 'package:ordering_app/constants/fileupload.dart';
import 'package:ordering_app/core/helper/show_toast_notification.dart';
import 'package:ordering_app/main.dart';
import 'package:ordering_app/presentation/screens/chat/local_notification.dart';
import 'package:ordering_app/presentation/widgets/auth/customtext.dart';
import 'package:ordering_app/presentation/widgets/chat/context_menu.dart';
import 'package:ordering_app/presentation/widgets/chat/message_bubble.dart';
import 'package:ordering_app/presentation/widgets/chat/text_button.dart';

class ChatScreen extends StatefulWidget {
  final String reciever;
  final String userName;
  const ChatScreen({super.key, required this.reciever, required this.userName});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController textController;
  late ScrollController scrollController;
  FocusNode focusNode = FocusNode();
  File? file;
  late final ChatCubit chatCubit;
  // String pageName = "/chatScreen";
  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    chatCubit = context.read<ChatCubit>();
    chatCubit.getAllChats(widget.reciever);
    initialState();
    textController = TextEditingController();

    // log("widget.reciever ================== ${widget.reciever}");
    // log("widget.pageName ================== $pageName");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentPage = ModalRoute.of(context)?.settings.name;
      debugPrint("📍 Current page: $currentPage");
      fcmsConfigration(
        chatCubit,
        currentPage!, //pageName,
        widget.reciever,
        context,
      );
    });
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void initialState() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {}
    });
    scrollController = ScrollController();
    scrollController.addListener(() {});
  }

  void makeAnimation() {
    if (scrollController.positions.isEmpty) {
      return;
    }
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void chooseImageGallery() async {
    file = await takePhotoWithGallery();
    log('file from gallery ================ $file');
    chatCubit.refreshChats(widget.reciever);
  }

  void chooseImageCamera() async {
    file = await takePhotoWithCamera();
    log('file from gallery ================ $file');
    chatCubit.refreshChats(widget.reciever);
  }

  void removeFile() {
    if (file != null) {
      file = null;
      log('file from remove ================ $file');
    } else {
      log('no file to remove');
    }
    chatCubit.refreshChats(widget.reciever);
  }

  void chooseImageOption() {
    showAttachmentOptions(
      context,

      chooseImageGallery,
      chooseImageCamera,
      removeFile,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: CustomText(title: widget.userName),
        titleTextStyle: theme.appBarTheme.titleTextStyle,
        iconTheme: theme.appBarTheme.iconTheme,
      ),
      body: customLoadedData(theme),
    );
  }

  Widget customLoadedData(final ThemeData theme) {
    return Column(
      children: [
        Expanded(
          child: BlocConsumer<ChatCubit, ChatState>(
            listener: (context, state) {
              if (state is ChatFailureState) {
                ShowToastMessage.showErrorToastMessage(
                  context,
                  message: state.messageFailure,
                );
              }
            },
            builder: (context, state) {
              if (state is ChatLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (chatCubit.listChats.isEmpty) {
                return const Center(child: Text("No Messages Found ."));
              } else if (state is ChatLoadedState) {
                return ListView.builder(
                  shrinkWrap: true,
                  controller: scrollController,
                  reverse: true,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 8.0,
                  ),
                  itemCount: chatCubit.listChats.length,
                  itemBuilder: (context, index) {
                    return ContextMenuExample(
                      onPressed: () {},
                      child: MessageBubble(
                        messageModel: chatCubit.listChats[index],
                        coachId: chatCubit.coachId ?? myBox!.get("userId"),
                      ),
                    );
                  },
                );
              }
              return const Center(child: Text("No Messages Found ."));
            },
          ),
        ),
        // ignore: deprecated_member_use
        Divider(height: 1.0, color: theme.dividerColor.withOpacity(0.5)),
        BuildInputDataAres(
          theme: theme,
          textController: textController,
          onPressedSend: () {
            if (file != null) {
              log("file ===================== $file");
              chatCubit.sendMessage(
                widget.reciever,
                textController.text.trim(),
                file,
              );
            } else {
              if (textController.text.isEmpty) {
                return;
              } else {
                chatCubit.sendMessage(
                  widget.reciever,
                  textController.text.trim(),
                  null,
                );
              }
            }
            file = null;
            textController.clear();
            makeAnimation();
          },
          onPressed: () {
            chooseImageOption();
          },
        ),
      ],
    );
  }
}
