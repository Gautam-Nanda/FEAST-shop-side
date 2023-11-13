import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, left: 32.0),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Surya Tuck Shop",
            style: GoogleFonts.spaceGrotesk(
                color: Colors.orange,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "Dashboard",
            style: GoogleFonts.spaceGrotesk(
                color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 24),
          Container(
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: 200,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Today's Revenue",
                            style: GoogleFonts.spaceGrotesk(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                "₹",
                                style: GoogleFonts.spaceGrotesk(
                                    color: Colors.green,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "30,000",
                                style: GoogleFonts.spaceGrotesk(
                                    color: Colors.green,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  width: 200,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Today's Revenue",
                            style: GoogleFonts.spaceGrotesk(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                "₹",
                                style: GoogleFonts.spaceGrotesk(
                                    color: Colors.green,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "30,000",
                                style: GoogleFonts.spaceGrotesk(
                                    color: Colors.green,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  width: 200,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Today's Revenue",
                            style: GoogleFonts.spaceGrotesk(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                "₹",
                                style: GoogleFonts.spaceGrotesk(
                                    color: Colors.green,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "30,000",
                                style: GoogleFonts.spaceGrotesk(
                                    color: Colors.green,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          Image.asset("assets/chart.png"),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Pending Orders",
              style: GoogleFonts.spaceGrotesk(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
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
          Padding(padding: EdgeInsets.only(bottom:16))
        ]),
      ),
    );
  }
}

class OrderContainer extends StatelessWidget {
  const OrderContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left:32),
        child: Row(
      children: [
        Column(
          children: [
            Text("ORDER", style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.bold),),
            Text("#562", style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.bold),),
          ],
        ),
        SizedBox(width: 32),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderItem(item: "Chicken Burger", quantity: 2),
            OrderItem(item: "Aloo Patty", quantity: 1),
            Text("2:30 pm", style: GoogleFonts.spaceGrotesk(color: Colors.green, fontWeight: FontWeight.bold),),
          ],
        ),
      ],
    ));
  }
}


class OrderItem extends StatelessWidget {
  // take item, quantity in constructor
  final String item;
  final int quantity;

  const OrderItem({super.key, required this.item, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return             Row(
      mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(item, style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.bold),),
                Text(
                  " x $quantity",
                  style: GoogleFonts.spaceGrotesk(color: Colors.orange),
                ),
              ],
    );
  }
}