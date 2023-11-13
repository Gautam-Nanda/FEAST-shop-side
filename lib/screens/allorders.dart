import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storeapp/screens/dashboard.dart';

class AllOrders extends StatelessWidget {
  const AllOrders({super.key});
  static const routeName = '/allorders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                          "All Orders",
                          style: GoogleFonts.spaceGrotesk(
                              color: Colors.orange,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        IconButton(
                          icon: const Icon(Icons.sort, color: Colors.orange),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.filter_alt, color: Colors.orange),
                          onPressed: () {},
                        ),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16),
          OrderContainer(),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(
              height: 1,
              width: MediaQuery.of(context).size.width - 64,
              color: const Color.fromARGB(255, 206, 201, 201),
            ),
          ),
          SizedBox(height: 16),
          OrderContainer(),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(
              height: 1,
              width: MediaQuery.of(context).size.width - 64,
              color: Color.fromARGB(255, 206, 201, 201),
            ),
          ),
          SizedBox(height: 16),
          OrderContainer(),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(
              height: 1,
              width: MediaQuery.of(context).size.width - 64,
              color: Color.fromARGB(255, 206, 201, 201),
            ),
          ),
                     SizedBox(height: 16),
          OrderContainer(),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(
              height: 1,
              width: MediaQuery.of(context).size.width - 64,
              color: const Color.fromARGB(255, 206, 201, 201),
            ),
          ),
          SizedBox(height: 16),
          OrderContainer(),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(
              height: 1,
              width: MediaQuery.of(context).size.width - 64,
              color: Color.fromARGB(255, 206, 201, 201),
            ),
          ),
          SizedBox(height: 16),
          OrderContainer(),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(
              height: 1,
              width: MediaQuery.of(context).size.width - 64,
              color: Color.fromARGB(255, 206, 201, 201),
            ),
          ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}