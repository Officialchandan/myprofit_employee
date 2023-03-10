import 'package:flutter/cupertino.dart';

class SelectImageBottomSheet extends StatelessWidget {
  final Function openCamera;
  final Function openGallery;

  SelectImageBottomSheet({required this.openCamera, required this.openGallery});

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          child: Text("camera"),
          onPressed: () {
            Navigator.pop(context);
            openCamera();
          },
        ),
        CupertinoActionSheetAction(
          child: Text("gallery "),
          onPressed: () {
            Navigator.pop(context);
            openGallery();
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("cancel"),
      ),
    );
  }
}
