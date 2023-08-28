import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mynetvolve/widgets/gradient_app_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../helpers/save_image.dart';
import '../../../models/efaktur.dart';

class EfakturScreen extends StatefulWidget {
  const EfakturScreen({Key? key}) : super(key: key);

  @override
  State<EfakturScreen> createState() => _EfakturScreenState();
}

class _EfakturScreenState extends State<EfakturScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance!.addPostFrameCallback((_) async {
  //     final Efaktur efaktur =
  //         ModalRoute.of(context)!.settings.arguments as Efaktur;
  //     final decodedFile = convertBase64(efaktur.content);

  //     final appDir = await getTemporaryDirectory();
  //     File file = File('${appDir.path}/${efaktur.name}}.${efaktur.type}');
  //     await file.writeAsBytes(decodedFile);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final Efaktur efaktur =
        ModalRoute.of(context)!.settings.arguments as Efaktur;
    final decodedFile = convertBase64(efaktur.content);

    var parts = efaktur.ext.split('/');
    var _fileType = parts.sublist(1).join('/').trim();
    var _fileName =
        efaktur.name.replaceAll(' ', '') + DateTime.now().toIso8601String();

    // var _filePath =
    //     'JVBERi0xLjcNCiWDkvr+DQoxIDAgb2JqDQo8PA0KL1R5cGUgL0NhdGFsb2cNCi9QYWdlcyAyIDAgUg0KPj4NCmVuZG9iag0KMiAwIG9iag0KPDwNCi9UeXBlIC9QYWdlcw0KL0tpZHMgWzMgMCBSXQ0KL0NvdW50IDENCi9SZXNvdXJjZXMgPDw+Pg0KDQovTWVkaWFCb3ggWzAgMCA1OTUgODQyXQ0KPj4NCmVuZG9iag0KMyAwIG9iag0KPDwNCi9Db3VudCAxDQovVHlwZSAvUGFnZXMNCi9LaWRzIFs0IDAgUl0NCi9QYXJlbnQgMiAwIFINCj4+DQplbmRvYmoNCjQgMCBvYmoNCjw8DQovVHlwZSAvUGFnZQ0KL1BhcmVudCAzIDAgUg0KPj4NCmVuZG9iag0KeHJlZg0KMCA1DQowMDAwMDAwMDAwIDY1NTM1IGYNCjAwMDAwMDAwMTcgMDAwMDAgbg0KMDAwMDAwMDA3MiAwMDAwMCBuDQowMDAwMDAwMTgwIDAwMDAwIG4NCjAwMDAwMDAyNTkgMDAwMDAgbg0KdHJhaWxlcg0KPDwNCi9Sb290IDEgMCBSDQovU2l6ZSA1DQo+Pg0KDQpzdGFydHhyZWYNCjMxMg0KJSVFT0Y=';
    // PdfDocument document = PdfDocument.fromBase64String(_filePath);

    void _saveEfaktur() async {
      if (efaktur.ext.contains('image')) {
        try {
          saveImage(
              base64String: decodedFile,
              fileName: _fileName,
              fileType: _fileType);
          Fluttertoast.showToast(
            msg: 'Efaktur Berhasil Diunduh!',
            backgroundColor: Colors.black87,
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Gagal mengunduh Efaktur'),
              backgroundColor: Colors.red.shade700,
            ),
          );
        }
      } else {
        try {
          var status = await Permission.storage.status;
          if (status.isDenied) {
            return;
          }
          if (Platform.isAndroid) {
            Map<Permission, PermissionStatus> statuses = await [
              Permission.manageExternalStorage
            ].request(); //Permission.manageExternalStorage
            print('===== $statuses');

            // final appDir = await getTemporaryDirectory();
            final appDir = await getExternalStorageDirectory();
            // final appDir = '/storage/emulated/0/Download';
            File file = File('${appDir!.path}$_fileName.$_fileType');
            await file.writeAsBytes(decodedFile);
            // final raf = file.openSync(mode: FileMode.write);
            // raf.writeFromSync(decodedFile);
            // await raf.close();

            Fluttertoast.showToast(
              msg: 'Efaktur Berhasil Diunduh!',
              backgroundColor: Colors.black87,
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
              backgroundColor: Colors.red.shade700,
            ),
          );
        }
      }
    }

    return Scaffold(
      appBar: GradientAppBar(
        title: 'Efaktur ${efaktur.nofa}',
        actions: [
          IconButton(
            onPressed: _saveEfaktur,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: efaktur.ext.contains('image')
            ? Image.memory(
                decodedFile,
                fit: BoxFit.fitWidth,
              )
            : const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Tekan Tombol Simpan Di Atas Untuk Mengunduh File Efaktur',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
      ),
    );
  }
}
