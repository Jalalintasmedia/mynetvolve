import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mynetvolve/helpers/save_image.dart';
import 'package:mynetvolve/providers/customer_profile.dart';
import 'package:provider/provider.dart';

import '../../helpers/copy_text.dart';
import 'circle_profile_picture.dart';
import 'gradient_container.dart';

class ProfileGradientContainer extends StatelessWidget {
  final bool isCrossIcon;
  final bool editable;
  final void Function(XFile pickedImage)? imagePickFn;

  const ProfileGradientContainer({
    Key? key,
    this.isCrossIcon = false,
    this.imagePickFn,
    this.editable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double height = 200;
    const borderRadius = BorderRadius.only(
      bottomLeft: Radius.circular(15),
      bottomRight: Radius.circular(15),
    );
    return Consumer<CustomerProfile>(builder: (ctx, custData, _) {
      final customer = custData.customer!;
      Uint8List? image;

      if (customer.profileFileId != '') {
        image = convertBase64(customer.pictContent);
      }
      return Stack(
        children: [
          GradientContainer(
            context: context,
            height: height,
            borderRadius: borderRadius,
            child: Positioned(
              // bottom: 15,
              top: 125,
              left: 25,
              right: 25,
              child: Row(
                children: [
                  CircleProfilePicture(
                    imagePickFn: imagePickFn,
                    editable: editable,
                    image: customer.profileFileId == ''
                        ? const AssetImage(
                            'assets/images/photo_placeholder.jpg')
                        : MemoryImage(image!) as ImageProvider,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo, ${customer.accountName}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Row(
                          children: [
                            Text(
                              customer.accountNo,
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(width: 5),
                            IconButton(
                              onPressed: () =>
                                  copyText(copiedData: customer.accountNo),
                              icon: const ImageIcon(
                                AssetImage('assets/icons/copy.png'),
                                color: Colors.white,
                                size: 14,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
