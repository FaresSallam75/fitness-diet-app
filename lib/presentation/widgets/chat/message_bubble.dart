import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ordering_app/core/dio_services/api_end_point.dart';
import 'package:ordering_app/data/model/chat_model.dart';
import 'package:ordering_app/main.dart';

class MessageBubble extends StatelessWidget {
  final ChatModel messageModel;
  final String coachId;

  const MessageBubble({
    super.key,
    required this.messageModel,
    required this.coachId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bool isMe =
        messageModel.sender != null &&
            messageModel.sender.toString() == myBox!.get("userId").toString() ||
        messageModel.sender.toString() == coachId;

    // Determine bubble alignment and colors based on sender
    final alignment = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bubbleColor = isMe
        ? theme.colorScheme.primaryContainer
        : theme.colorScheme.secondaryContainer;
    final textColor = isMe
        ? theme.colorScheme.onPrimaryContainer
        : theme.colorScheme.onSecondaryContainer;

    // Determine border radius based on sender
    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(18.0),
      topRight: const Radius.circular(18.0),
      bottomLeft: Radius.circular(isMe ? 18.0 : 0),
      bottomRight: Radius.circular(isMe ? 0 : 18.0),
    );

    final String? imagePath = messageModel.file;
    final bool isImageMessage = imagePath != null && imagePath.isNotEmpty;

    final bool isTextMessage =
        messageModel.message != null && messageModel.message!.isNotEmpty;

    // Decide what content to show
    Widget messageContent;
    EdgeInsets contentPadding;

    if (isImageMessage) {
      // --- Image Content ---
      contentPadding = EdgeInsets.zero;
      messageContent = ClipRRect(
        borderRadius: borderRadius,
        child: CachedNetworkImage(
          imageUrl: "${ApiEndPoints.viewMessagesImage}/$imagePath",
          fit: BoxFit.contain,
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.65,

          // مكان الـ loadingBuilder
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              Container(
                padding: const EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.65,
                child: Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    strokeWidth: 2,
                  ),
                ),
              ),

          // مكان الـ errorBuilder
          errorWidget: (context, url, error) {
            log("Error loading image: $error");
            return Container(
              padding: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.65,
              child: const Center(
                child: Icon(
                  Icons.broken_image_outlined,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
            );
          },
        ),
      );
    } else if (isTextMessage) {
      // --- Text Content ---
      contentPadding = const EdgeInsets.symmetric(
        horizontal: 14.0,
        vertical: 10.0,
      );
      messageContent = Text(
        messageModel.message!,
        style: TextStyle(color: textColor, fontSize: 15.0),
        softWrap: true,
      );
    } else {
      contentPadding = const EdgeInsets.symmetric(
        horizontal: 14.0,
        vertical: 10.0,
      );
      messageContent = Text(
        '[Empty Message]',
        style: TextStyle(
          // ignore: deprecated_member_use
          color: textColor.withOpacity(0.5),
          fontSize: 14.0,
          fontStyle: FontStyle.italic,
        ),
      );
    }

    if (!isImageMessage && !isTextMessage) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth:
                  MediaQuery.of(context).size.width *
                  (isImageMessage ? 0.7 : 0.75),
            ),
            padding: contentPadding,
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: borderRadius,
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: messageContent,
          ),
          // Timestamp
          Padding(
            padding: EdgeInsets.only(
              top: 4.0,
              left: isMe ? 0 : 12.0,
              right: isMe ? 12.0 : 0,
            ),
            child: Text(
              messageModel.dateTime != null
                  ? Jiffy.parse(messageModel.dateTime!).format(pattern: "HH:mm")
                  : '--:--',
              style: theme.textTheme.bodySmall?.copyWith(
                // ignore: deprecated_member_use
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
