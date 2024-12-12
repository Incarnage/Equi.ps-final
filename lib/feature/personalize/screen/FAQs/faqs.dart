import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/utilities/constants/size.dart';
import 'package:flutter/material.dart';

class FrequentlyAskedQuestions extends StatelessWidget {
  const FrequentlyAskedQuestions({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const Scaffold(
        appBar: TAppbar(showBackArrow: true, title: Text("FAQs")),
        body: ExpansionTileExample(),
        backgroundColor: Color(0xFF25291C),
      ),
    );
  }
}

class ExpansionTileExample extends StatefulWidget {
  const ExpansionTileExample({super.key});

  @override
  State<ExpansionTileExample> createState() => _ExpansionTileExampleState();
}

class _ExpansionTileExampleState extends State<ExpansionTileExample> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Text("Frequently Asked Questions (FAQs)",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: TSizes.fontMedium)),
            const SizedBox(
              height: TSizes.spaceItems,
            ),

            // Q&A Message
            ExpansionTile(
              collapsedShape: Border.all(color: Colors.white),
              collapsedBackgroundColor: Colors.white,
              backgroundColor: Colors.white,
              shape: Border.all(color: Colors.white),
              title: const Text('Message',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: TSizes.fontLarge)),
              subtitle: const Text(
                  'I am a lessor, can I initiate a conversation with potential lessees?',
                  style: TextStyle(fontStyle: FontStyle.italic)),
              children: const <Widget>[
                ListTile(
                    title: Text(
                        'No, you cannot initiate a conversation with potential lessees. But you are allowed to communicate with them once they inquired about your property/ies.')),
              ],
            ),

            const SizedBox(
              height: TSizes.spaceItems,
            ),

            // Q&A Payment
            ExpansionTile(
              collapsedShape: Border.all(color: Colors.white),
              collapsedBackgroundColor: Colors.white,
              backgroundColor: Colors.white,
              shape: Border.all(color: Colors.white),
              title: const Text('Payment',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: TSizes.fontLarge)),
              subtitle: const Text(
                'Can I still rent an item without giving a down payment?',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              children: const <Widget>[
                ListTile(
                    title: Text(
                        'No, you will not be able to rent an item without sending a payment, at least a down payment, to the lessor. This is to ensure that there will be no cancellations of the property/ies on the rental period provided.')),
              ],
            ),

            const SizedBox(
              height: TSizes.spaceItems,
            ),

            // Q&A Search
            ExpansionTile(
              collapsedShape: Border.all(color: Colors.white),
              collapsedBackgroundColor: Colors.white,
              backgroundColor: Colors.white,
              shape: Border.all(color: Colors.white),
              title: const Text('Search',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: TSizes.fontLarge)),
              subtitle: const Text(
                  'Can I filter the event properties per place?',
                  style: TextStyle(fontStyle: FontStyle.italic)),
              children: const <Widget>[
                ListTile(
                    title: Text(
                        'Yes, you can filter the properties you are looking for according to cities/municipalities. To do it, go to Store page then check filter icon in the upper right corner, then click it to filter properties.')),
              ],
            ),

            const SizedBox(
              height: TSizes.spaceItems,
            ),
            const Text("Can't find what you're looking for?",
                style: TextStyle(
                    color: Color(0xFFFFD233),
                    fontWeight: FontWeight.bold,
                    fontSize: TSizes.fontMedium)),
            const Text("Go to Support page and report a problem.",
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontStyle: FontStyle.italic,
                    fontSize: TSizes.fontSmall)),
          ],
        ),
      ),
    );
  }
}
