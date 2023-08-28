import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';

import 'loading/shimmer_widget.dart';
import '../../helpers/link_director.dart';

class ClickableImage extends StatefulWidget {
  final String image;
  final String? url;
  final double? height;

  const ClickableImage({
    Key? key,
    required this.image,
    this.url,
    required this.height,
  }) : super(key: key);

  @override
  State<ClickableImage> createState() => _ClickableImageState();
}

class _ClickableImageState extends State<ClickableImage> {
  Offset _tapPosition = Offset.zero;
  void _getTapPosition(TapDownDetails tapPosition) {
    setState(() {
      _tapPosition = tapPosition.globalPosition;
    });
  }

  void _showContextMenu(BuildContext context, String imgUrl) async {
    final RenderObject? overlay =
        Overlay.of(context).context.findRenderObject();
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 0, 0),
        Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
            overlay.paintBounds.size.height),
      ),
      items: [
        const PopupMenuItem(
          child: Text('Simpan Gambar'),
          value: 'save',
        ),
      ],
    );

    switch (result) {
      case 'save':
        try {
          GallerySaver.saveImage(imgUrl);
          Fluttertoast.showToast(
            msg: 'Gambar Tersimpan',
            backgroundColor: Colors.black87,
          );
        } catch (e) {
          return;
        }
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          if (widget.url == null || widget.url == '') {
            await showDialog(
              context: context,
              builder: (_) => imagePopup(widget.image),
            );
          } else {
            openExternalApplication(widget.url!);
          }
        },
        child: CachedNetworkImage(
          imageUrl: widget.image,
          fit: BoxFit.cover,
          placeholder: (ctx, url) => ShimmerWidget.rectangular(
            height: widget.height!,
          ),
        ));
  }

  Widget imagePopup(String imgUrl) {
    return Dialog(
      child: GestureDetector(
        onTapDown: (position) {
          _getTapPosition(position);
        },
        onLongPress: () {
          _showContextMenu(context, imgUrl);
        },
        child: Image.network(
          imgUrl,
          errorBuilder: (context, exception, stackTrace) {
            return const Text(
              'Cant load image',
              textAlign: TextAlign.center,
            );
          },
        ),
      ),
    );
  }
}
