import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ordering_app/business_logic/chat/chat_cubit.dart';
import 'package:ordering_app/business_logic/chat/chat_state.dart';
import 'package:ordering_app/constants/colors.dart';
import 'package:ordering_app/constants/routes.dart';
import 'package:ordering_app/core/helper/show_toast_notification.dart';
import 'package:ordering_app/presentation/widgets/auth/customtext.dart';

class CoachCardChat extends StatefulWidget {
  const CoachCardChat({super.key});

  @override
  State<CoachCardChat> createState() => _CoachCardChatState();
}

class _CoachCardChatState extends State<CoachCardChat> {
  late final ChatCubit chatCubit;
  @override
  void initState() {
    chatCubit = context.read<ChatCubit>();
    chatCubit.cardChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ChatFailureState) {
          ShowToastMessage.showErrorToastMessage(
            context,
            message: state.messageFailure,
          );
          // Center(child: Text("No Data ."));
        }
      },
      builder: (context, state) {
        if (state is ChatLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ChatFailureState) {
          ShowToastMessage.showErrorToastMessage(
            context,
            message: state.messageFailure,
          );
          return Center(child: Text("No Data ."));
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),

          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: chatCubit.listCardChats.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.chatScreen,
                arguments: {
                  "id": chatCubit.listCardChats[index].id,
                  "name": chatCubit.listCardChats[index].name,
                  // "pageName": "/chatScreen",
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    child: Icon(Icons.person),
                    // CachedNetworkImage(
                    //   imageUrl:
                    //       "${ApiEndPoints.coachImages}/${chatCubit.listCardChats[index].image!}",
                    // ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${chatCubit.listCardChats[index].name}",
                          style: theme.textTheme.headlineSmall,
                        ),
                        SizedBox(height: 5),
                        CustomText(
                          title: "${chatCubit.listCardChats[index].message}",
                          textStyle: theme.textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                  if (chatCubit.listCardChats[index].dateTime != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomText(
                          title: Jiffy.parse(
                            chatCubit.listCardChats[index].dateTime!,
                          ).jm,

                          textStyle: theme.textTheme.headlineSmall!.copyWith(
                            color: MyColors.grey,
                            fontSize: 14.0,
                          ),
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
