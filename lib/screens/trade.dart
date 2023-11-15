import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';


class TradeScreen extends StatefulWidget {
  final String itemName;
  const TradeScreen({super.key, required this.itemName});

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {

  late List<dynamic> outletsList = [];

    void fetchStores() async {
      String url = 'http://10.0.2.2:8000/raw_materials/${widget.itemName}/stores?exclude=1';
      get(Uri.parse(url)).then((Response response) {
        if (response.statusCode == 200) {
          setState(() {
            outletsList = jsonDecode(response.body);
          });
        }
        else {
          print('Request failed with status: ${response.statusCode}.');
        }
      });
    }

    // @app.get("/raw_materials/{raw_material_name}/stores")
    @override
    void initState() {
      super.initState();
      fetchStores();
    }

  @override
  Widget build(BuildContext context) {
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
                      widget.itemName,
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
                      title: Text(outletsList[index]['name']),
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
                                    Text(outletsList[index]['name']),
                                    Text(outletsList[index]['address']),
                                    Text(outletsList[index]['contact'].toString()),
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
                                                  Text("Buy from " + outletsList[index]['name']),
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
                                                          content: Text('Offer sent to ' + outletsList[index]['name']),
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