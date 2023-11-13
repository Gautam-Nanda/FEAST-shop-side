import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const outletsList = ["Naveen Tea Stall", "Swad Enterprises", "Quench", "Anna's Cafe"];

class TradeScreen extends StatefulWidget {
  const TradeScreen({super.key});
  static const String routeName = '/trade';

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    final String itemName = arguments['itemName'];

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:40.0, left: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  // nav pop
                  onPressed: (){
                    Navigator.pop(context);
                  }
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  children: [
                    Text(
                      itemName,
                      style: GoogleFonts.spaceGrotesk(
                          color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    // sort and filter
                  ],
                ),
                Text("Buy from other outlets near you. The following outlets have this item right now", style: GoogleFonts.spaceGrotesk(
                    color: Colors.grey[600], fontSize: 16)
                ),
                SizedBox(height: 24,),
                // list with outletnames and a button to trade with them
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: outletsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(outletsList[index]),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // open a bottom sheet with the outlet details
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 200,
                                child: Column(
                                  children: [
                                    Text(outletsList[index]),
                                    Text("Address"),
                                    Text("Phone Number"),
                                    Text("Email"),
                                    Text("Website"),
                                    ElevatedButton(
                                      onPressed: () {
                                        // open a bottom sheet with the outlet details
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              height: 200,
                                              child: Column(
                                                children: [
                                                  Text("Buy from " + outletsList[index]),
                                                  // row with a rs. symbol and numberfield
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("Rs. "),
                                                      SizedBox(
                                                        width: 150,
                                                        child: TextField(
                                                          decoration: InputDecoration(
                                                            border: OutlineInputBorder(),
                                                            labelText: 'Enter amount',
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      // close the bottom sheet
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                      // show snackbar
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                          content: Text('Offer sent to ' + outletsList[index]),
                                                          duration: Duration(seconds: 3),
                                                        ),
                                                      );
                                                    },
                                                    child: Text("Confirm"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Text("Send Offer"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Text("View Details"),
                      ),
                    );
                  },
                ),
              ],
              ),
            )
          ),
        ],
      ),
    );
  }
}