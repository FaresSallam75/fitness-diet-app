import 'package:flutter/material.dart';

class BuildInputDataAres extends StatelessWidget {
  final ThemeData theme;
  final TextEditingController textController;
  final void Function()? onPressedSend;
  final void Function()? onPressed;

  const BuildInputDataAres({
    super.key,
    required this.theme,
    required this.textController,
    required this.onPressedSend,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      color: theme.colorScheme.surface,
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                color: theme.colorScheme.primary,
              ),
              onPressed: onPressed,
              tooltip: 'إرفاق ملف',
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: theme.colorScheme.surfaceContainerHighest.withOpacity(
                    0.5,
                  ),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: 'Message',
                    border: InputBorder.none,
                    hintStyle: theme.textTheme.headlineSmall?.copyWith(
                      // ignore: deprecated_member_use
                      color: theme.colorScheme.onSurfaceVariant.withOpacity(
                        0.6,
                      ),
                    ),
                  ),

                  textCapitalization: TextCapitalization.sentences,
                  minLines: 1,
                  maxLines: 5,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
            ),
            const SizedBox(width: 8.0),

            FloatingActionButton(
              mini: true,
              onPressed: onPressedSend,
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              elevation: 1.0,
              tooltip: 'إرسال',
              child: const Icon(Icons.send, size: 18),
            ),
            // Optional: Emoji Button
            // IconButton(
            //   icon: Icon(Icons.emoji_emotions_outlined, color: theme.colorScheme.secondary),
            //   onPressed: () { /* TODO: Implement emoji picker */ },
            // ),
          ],
        ),
      ),
    );
  }
}
