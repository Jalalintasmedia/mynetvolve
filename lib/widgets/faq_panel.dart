import 'package:flutter/material.dart';
import 'package:mynetvolve/providers/faq_prov.dart';
import 'package:provider/provider.dart';

import '../models/faq2.dart';

class FaqPanel extends StatefulWidget {
  const FaqPanel({
    Key? key,
  }) : super(key: key);

  @override
  State<FaqPanel> createState() => _FaqPanelState();
}

class _FaqPanelState extends State<FaqPanel> {
  final _faqs = Faq2.staticFaqs;
  @override
  Widget build(BuildContext context) {
    late final _faqFuture =
        Provider.of<FaqProvs>(context, listen: false).getFaq();
    return Center(
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(5, 5),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        constraints: const BoxConstraints(
          minHeight: 100,
          minWidth: double.infinity,
          // maxHeight: double.infinity,
          maxHeight: double.infinity,
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 15),
            FutureBuilder(
              future: _faqFuture,
              builder: (ctx, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (dataSnapshot.error != null) {
                    return faqLists(_faqs);
                  } else {
                    return Consumer<FaqProvs>(
                      builder: (ctx, faqData, _) {
                        return faqLists(faqData.faqs!);
                      },
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget faqLists(List<Faq2> faq) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      removeTop: true,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: faq.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(
                  color: Colors.grey.shade400,
                  width: 1.0,
                ),
              ),
              elevation: 0,
              child: Theme(
                data: ThemeData().copyWith(
                  dividerColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  expandedCrossAxisAlignment: CrossAxisAlignment.end,
                  title: Text(
                    faq[i].titleInd,
                    style: const TextStyle(fontSize: 14),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: ListTile(
                        title: Column(
                          children: [
                            if (faq[i].picture != '')
                              Image(image: NetworkImage(faq[i].picture)),
                            Text(
                              faq[i].descriptionInd,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
