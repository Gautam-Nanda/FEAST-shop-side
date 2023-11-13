import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Inventory extends StatefulWidget {
  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  Map<String, List<List<dynamic>>> items = {};
  List<List<dynamic>> raw = [];

  // init state
  @override
  void initState() {
    super.initState();
    items ={
      "Rolls":[
        ["Chicken Roll", true],
        ["Mutton Roll", true],
        ["Fish Roll", false],
        ["Egg Roll", true],
      ],
      "Burgers":[
        ["Chicken Burger", true],
        ["Mutton Burger", true],
        ["Fish Burger", false],
        ["Egg Burger", true],
      ],
      "Sandwiches":[
        ["Chicken Sandwich", true],
        ["Mutton Sandwich", true],
        ["Fish Sandwich", false],
        ["Egg Sandwich", true],
      ],
    };

    raw = [["Onions", true], ["Tomatoes", true], ["Lettuce", false], ["Buns", true], ["Chicken", true], ["Mutton", true], ["Fish", false], ["Eggs", true],];
  }

  void changeAvailability(String name, bool value, bool isRawMaterial) {
    if (!isRawMaterial){
      setState(() {
        for (var item in items.entries) {
          for (var i in item.value) {
            if (i[0] == name) {
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
  final List<List<dynamic>> items;
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
              Navigator.pushNamed(context, '/trade', arguments: {
                  'itemName': name
                }
              );
            },
            icon: Icon(Icons.arrow_circle_right_outlined, color: Colors.orange),
          ),
      ],
    );
  }
}