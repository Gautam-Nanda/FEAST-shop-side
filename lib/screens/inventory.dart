import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:storeapp/screens/trade.dart';

class Inventory extends StatefulWidget {
  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  Map<dynamic, dynamic> items = {};
  List<dynamic> raw = [];

  // init state
  @override
  void initState() {
    super.initState();
    const String url = 'http://10.0.2.2:8000/store/1/items';
    get(Uri.parse(url)).then((Response response) {
      if (response.statusCode == 200) {
        setState(() {
          items = jsonDecode(response.body);
        });
      }
      else {
        print('Request failed with status: ${response.statusCode}.');
      }
    });

    const String rawUrl = 'http://10.0.2.2:8000/store/1/raw_materials';
    get(Uri.parse(rawUrl)).then((Response response) {
      if (response.statusCode == 200) {
        setState(() {
          raw = jsonDecode(response.body);
        });
      }
      else {
        print('Request failed with status: ${response.statusCode}.');
      }
    });
  }

  void toggleAvailability(int id, bool value) {
    String url = 'http://10.0.2.2:8000/items/$id/toggle-availability?availabe=$value';
    get(Uri.parse(url)).then((Response response) {
      if (response.statusCode == 200) {
        // show snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Availability changed'),
            duration: Duration(seconds: 1),
          ),
        );
      }
      else {
        print('Request failed with status: ${response.statusCode}.');
      }
    });
  }

  void toggleRawMaterialAvailability(int id, bool value) {
    String url = 'http://10.0.2.2:8000/raw_materials/$id/store/1/toggle-availability?available=$value';
    get(Uri.parse(url)).then((Response response) {
      if (response.statusCode == 200) {
        // show snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Availability changed'),
            duration: Duration(seconds: 1),
          ),
        );
      }
      else {
        print('Request failed with status: ${response.statusCode}.');
      }
    });
  }

  void changeAvailability(String name, bool value, bool isRawMaterial) {
    if (!isRawMaterial){
      setState(() {
        for (var item in items.entries) {
          for (var i in item.value) {
            if (i[0] == name) {
              toggleAvailability(i[2], value);
              i[1] = value;
              return;
            }
          }
        }
        for (var i in raw) {
          if (i[0] == name) {
            i[1] = value;
            return;
          }
        }
      });
    }
    else {
      setState(() {
        for (var i in raw) {
          if (i[0] == name) {
            toggleRawMaterialAvailability(i[2], value);
            i[1] = value;
            return;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, left: 32.0, right: 32),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Text(
                "Inventory",
                style: GoogleFonts.spaceGrotesk(
                    color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
              ),
              // sort and filter
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.sort, color: Colors.orange),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.filter_alt, color: Colors.orange),
              ),
            ],
          ),
          Text("Mark item availability", style: GoogleFonts.spaceGrotesk(
              color: Colors.grey[600], fontSize: 16)
          ),
          SizedBox(height: 24,),
          Text("Raw Materials", style: GoogleFonts.spaceGrotesk(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)
          ),
          SizedBox(height: 24,),
          for (var item in raw)
            InventoryItem(name: item[0].toString(), available: item[1] as bool, isRawMaterial: true, changeAvailability: changeAvailability),
          SizedBox(height: 12,),
          Text("On the menu", style: GoogleFonts.spaceGrotesk(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)
          ),
          SizedBox(height: 12,),
          for (var item in items.entries)
            InventorySection(title: item.key, items: item.value, changeAvailability: changeAvailability),
        ],
      ),
      ),
    );
  }
}

class InventorySection extends StatelessWidget {
  final String title;
  final List<dynamic> items;
  final Function changeAvailability;
  const InventorySection({super.key, required this.title, required this.items, required this.changeAvailability});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(title, style: GoogleFonts.spaceGrotesk(
          color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)
      ),
      // list with names and checkbox
      SizedBox(height: 12,),
      for (var item in items)
        InventoryItem(name: item[0].toString(), available: item[1] as bool, changeAvailability: changeAvailability),
    ],
    );
  }
}

class InventoryItem extends StatelessWidget {
  final String name;
  final bool available;
  final bool isRawMaterial;
  final Function changeAvailability;
  const InventoryItem({super.key, required this.name, required this.available, this.isRawMaterial = false, required this.changeAvailability});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(name, style: GoogleFonts.spaceGrotesk(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)
        ),
        Spacer(),
        Checkbox(
          value: available,
          onChanged: (value) {
            changeAvailability(name, value as bool, isRawMaterial);
          },
          activeColor: Colors.orange,
        ),
        if (isRawMaterial)
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TradeScreen(itemName: name),
                )
              );
            },
            icon: Icon(Icons.arrow_circle_right_outlined, color: Colors.orange),
          ),
      ],
    );
  }
}