import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ordering_app/constants/colors.dart';
import 'package:ordering_app/presentation/widgets/auth/customtext.dart';

void showAttachmentOptions(
  BuildContext context,

  photoGallery,
  photoCamera,
  remove,
) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (BuildContext buildContext) {
      return SafeArea(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: CustomText(
                title: 'Gallery (Photo)',
                textStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: MyColors.black01,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                photoGallery();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: CustomText(
                title: 'Camera (Photo)',
                textStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: MyColors.black01,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                photoCamera();
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.videocam),
            //   title: const Text('Camera (Video)'),
            //   onTap: () {
            //     Navigator.pop(context);
            //     recordVideoWithCamera(context);
            //   },
            // ),
            // if (imageFile != null) // Only show if an image exists
            ListTile(
              leading: Icon(
                Icons.delete_outline,
                color: Colors.red[700],
              ), // Use a distinct color
              title: CustomText(
                title: 'Remove Photo',
                textStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: MyColors.black01,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pop(); // Close the bottom sheet
                remove();
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.attach_file),
            //   title: const Text('Document/File'),
            //   onTap: () {
            //     Navigator.pop(context);
            //     pickFile(context);
            //   },
            // ),
          ],
        ),
      );
    },
  );
}

Future<File?> takePhotoWithCamera() async {
  XFile? file = await ImagePicker().pickImage(
    source: ImageSource.camera,
    imageQuality: 90,
  );

  File imageFile = File(file!.path);
  // ignore: unnecessary_null_comparison
  if (file == null) {
    return null;
  }
  // ignore: unnecessary_null_comparison
  if (imageFile != null) {
    return (imageFile);
  } else {
    return null;
  }
}

Future<File?>? takePhotoWithGallery() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null) {
    return File(result.files.single.path!);
  } else {
    return null;
  }
}

// void removeImage(File? fileRemove) {
//   fileRemove = null;
//   print("=================== Image removed ===============");
// }

void recordVideoWithCamera(BuildContext context) async {
  final XFile? video = await ImagePicker().pickVideo(
    source: ImageSource.camera,
  );
  if (video != null) {
    handlePickedFile(context, File(video.path));
  } else {
    print('User cancelled camera video');
  }
}

void pickFile(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom, // Optional: Specify file types
    allowedExtensions: ['jpg', 'pdf', 'doc', 'png'], // Optional
  );

  if (result != null && result.files.single.path != null) {
    handlePickedFile(context, File(result.files.single.path!));
  } else {
    // User canceled the picker
    print('User cancelled file picking');
  }
}

// --- Handle the picked file (upload/send) ---
void handlePickedFile(BuildContext context, File file) async {
  print('Picked file: ${file.path}');
  // TODO: Implement your upload logic here
  // Show a loading indicator maybe?

  try {
    // Example data to send along with the file
    // Map<String, dynamic> data = {
    //   'chat_id': widget.chatId,
    //   'recipient_id': widget.recipientId,
    //   'message_type': 'file', // Or determine based on file extension
    //   // Add any other required data fields
    // };

    // --- Call your API upload function ---
    // Replace with your actual API endpoint and function
    // final result = await postRequestWithFile(
    //   "YOUR_API_ENDPOINT_HERE",
    //   data,
    //   file,
    // );

    // result.fold(
    //   (failure) {
    //     print("Upload failed: $failure");
    //     // Show error message to user
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('Failed to upload file: $failure')),
    //     );
    //   },
    //   (successData) {
    //     print("Upload successful: $successData");
    //     // Maybe update the chat UI immediately with the sent file message
    //   },
    // );
    // --- End of API call ---

    // --- Placeholder for demonstration ---
    print("Simulating upload for: ${file.path}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sending ${file.path.split('/').last}...')),
    );
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    print("Upload successful (simulated)");
    // --- End Placeholder ---
  } catch (e) {
    print("Error handling picked file: $e");
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Error processing file: $e')));
  }
}
