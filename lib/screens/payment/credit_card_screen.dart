import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mynetvolve/core/palette.dart';
import 'package:mynetvolve/providers/customer_profile.dart';
import 'package:mynetvolve/providers/qris_prov.dart';
import 'package:mynetvolve/widgets/gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditCardScreen extends StatefulWidget {
  const CreditCardScreen({
    Key? key,
    required this.invoiceNo,
    required this.amount,
  }) : super(key: key);

  final String invoiceNo;
  final int amount;

  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  late String accountNo;
  late String accountName;
  late String accountEmail;
  late String tIspId;

  late final _ccFuture = Provider.of<QrisProv>(
    context,
    listen: false,
  ).generateCreditCardPayment(
    accountNo: accountNo,
    invoiceNo: widget.invoiceNo,
    name: accountName,
    tIspId: tIspId,
    amount: widget.amount,
    email: accountEmail,
  );
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  late PullToRefreshController pullToRefreshController;
  String url = '';
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final customerData = Provider.of<CustomerProfile>(
      context,
      listen: false,
    ).customer!;
    accountNo = customerData.accountNo;
    accountName = customerData.accountName;
    accountEmail = customerData.accountEmail;
    tIspId = customerData.tIspId;

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Palette.kToDark,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
            urlRequest: URLRequest(url: await webViewController?.getUrl()),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: 'Pembayaran Kartu Kredit'),
      body: FutureBuilder(
        future: _ccFuture,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (dataSnapshot.hasError) {
            return Center(
              child: Text(
                'Tidak Dapat men-generate kode VA\n${dataSnapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }
          return Consumer<QrisProv>(builder: (ctx, ccData, _) {
            final cc = ccData.creditCardPayment!;
            return SafeArea(
              child: Stack(
                children: [
                  InAppWebView(
                    key: webViewKey,
                    initialUrlRequest: URLRequest(
                      url: Uri.parse(cc.ccPage),
                    ),
                    initialOptions: options,
                    pullToRefreshController: pullToRefreshController,
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                    },
                    onLoadStart: (controller, url) {
                      setState(() {
                        this.url = url.toString();
                        urlController.text = this.url;
                      });
                    },
                    androidOnPermissionRequest:
                        (controller, origin, resources) async {
                      return PermissionRequestResponse(
                          resources: resources,
                          action: PermissionRequestResponseAction.GRANT);
                    },
                    shouldOverrideUrlLoading:
                        (controller, navigationAction) async {
                      var uri = navigationAction.request.url!;

                      if (![
                        "http",
                        "https",
                        "file",
                        "chrome",
                        "data",
                        "javascript",
                        "about"
                      ].contains(uri.scheme)) {
                        if (await canLaunchUrl(Uri.parse(url))) {
                          // Launch the App
                          await launchUrl(Uri.parse(url));
                          // and cancel the request
                          return NavigationActionPolicy.CANCEL;
                        }
                      }

                      return NavigationActionPolicy.ALLOW;
                    },
                    onLoadStop: (controller, url) async {
                      pullToRefreshController.endRefreshing();
                      setState(() {
                        this.url = url.toString();
                        urlController.text = this.url;
                      });
                    },
                    onLoadError: (controller, url, code, message) {
                      pullToRefreshController.endRefreshing();
                    },
                    onLoadHttpError:
                        (controller, url, statusCode, description) => print(
                      '===== $statusCode: $description',
                    ),
                    onProgressChanged: (controller, progress) {
                      if (progress == 100) {
                        pullToRefreshController.endRefreshing();
                      }
                      setState(() {
                        this.progress = progress / 100;
                        urlController.text = this.url;
                      });
                    },
                    onUpdateVisitedHistory: (controller, url, androidIsReload) {
                      // setState(() {
                      //   this.url = url.toString();
                      //   urlController.text = this.url;
                      // });
                      this.url = url.toString();
                      print('===== URL: ${this.url}');
                      if (this.url == 'https://my.netvolve.id/login.php') {
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('/', (route) => false);
                      }
                    },
                    onConsoleMessage: (controller, consoleMessage) {
                      print(consoleMessage);
                    },
                  ),
                  progress < 1
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(),
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
