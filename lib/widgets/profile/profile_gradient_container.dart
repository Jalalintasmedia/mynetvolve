import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mynetvolve/helpers/save_image.dart';
import 'package:mynetvolve/providers/customer_profile.dart';
import 'package:provider/provider.dart';

import 'circle_profile_picture.dart';
import 'gradient_container.dart';

class ProfileGradientContainer extends StatelessWidget {
  final String screenName;
  final bool isCrossIcon;
  final bool editable;
  final void Function(XFile pickedImage)? imagePickFn;

  const ProfileGradientContainer({
    Key? key,
    required this.screenName,
    this.isCrossIcon = false,
    this.imagePickFn,
    this.editable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GradientContainer(context: context),
        Positioned(
          left: 0,
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  isCrossIcon ? Icons.close_rounded : Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.maximumDensity,
                  vertical: VisualDensity.maximumDensity,
                ),
                // constraints: BoxConstraints(),
              ),
              Text(
                screenName,
                style: const TextStyle(
                  color: Colors.white,
                  // fontFamily: 'Abel',
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        // FutureBuilder(
        //   future: Provider.of<CustomerProfile>(
        //     context,
        //     listen: false,
        //   ).getUserProfile(),
        //   builder: (ctx, dataSnapshot) {
        //     if (dataSnapshot.connectionState == ConnectionState.waiting) {
        //       return const CircleProfilePicture(
        //         image: AssetImage('assets/images/photo_placeholder.jpg'),
        //       );
        //     }
        //     return Consumer<CustomerProfile>(
        //       builder: (ctx, custData, _) {
        //         final customer = custData.customer!;
        //         Uint8List? image;

        //         if (customer.profileFileId != '') {
        //           image = convertBase64(customer.pictContent);
        //         }

        //         return CircleProfilePicture(
        //           imagePickFn: imagePickFn,
        //           editable: editable,
        //           image: customer.profileFileId == ''
        //               ? const AssetImage('assets/images/photo_placeholder.jpg')
        //               // : const AssetImage('assets/images/office_bg.jpg')
        //               : MemoryImage(image!) as ImageProvider,
        //         );
        //       },
        //     );
        //   },
        // ),
        Consumer<CustomerProfile>(
          builder: (ctx, custData, _) {
            final customer = custData.customer!;
            Uint8List? image;

            if (customer.profileFileId != '') {
              image = convertBase64(customer.pictContent);
            }

            return CircleProfilePicture(
              imagePickFn: imagePickFn,
              editable: editable,
              image: customer.profileFileId == ''
                  ? const AssetImage('assets/images/photo_placeholder.jpg')
                  // : const AssetImage('assets/images/office_bg.jpg')
                  : MemoryImage(image!) as ImageProvider,
            );
          },
        ),
      ],
    );
  }
}
