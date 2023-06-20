import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CircleProfilePicture extends StatefulWidget {
  final void Function(XFile pickedImage)? imagePickFn;
  final bool editable;
  final ImageProvider image;

  const CircleProfilePicture({
    Key? key,
    this.imagePickFn,
    this.editable = false,
    required this.image,
  }) : super(key: key);

  @override
  State<CircleProfilePicture> createState() => _CircleProfilePictureState();
}

class _CircleProfilePictureState extends State<CircleProfilePicture> {
  // File? _pickedImage;

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text('Ambil gambar'),
                  onTap: () => _pickImage(ImageSource.camera),
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text('Pilih dari galeri'),
                  onTap: () => _pickImage(ImageSource.gallery),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final ImagePicker _imagePicker = ImagePicker();
      XFile? image = await _imagePicker.pickImage(
        source: source,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 50,
      );
      if (image == null) {
        return;
      }
      widget.imagePickFn!(image);
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Padding(
          padding: const EdgeInsets.only(right: 30),
          child: SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    if (widget.imagePickFn == null) {
                      null;
                    } else {
                      // _pickImage(ImageSource.camera);
                      _showModalBottomSheet(context);
                    }
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    backgroundImage: widget.image,
                  ),
                ),
                if (widget.editable)
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        padding: const EdgeInsets.all(0),
                        constraints: const BoxConstraints(),
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
