import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storeapp/screens/dashboard.dart';
import 'package:http/http.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({super.key});
  static const routeName = '/allorders';

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  late List<dynamic> allOrders = [];

  @override
  void initState() {
    super.initState();
    const String url2 = "http://10.0.2.2:8000/orders/store/1?limit=50";
    get(Uri.parse(url2)).then((Response response) {
      setState(() {
        allOrders = jsonDecode(response.body);
      });
    });
  }

  void updateOrderStatus(int orderNumber, String status) {
    String url = "http://10.0.2.2:8000/orders/$orderNumber/status?status=$status";
    const String url2 = "http://10.0.2.2:8000/orders/store/1?limit=50";
    put(Uri.parse(url)).then((Response response) {
      // snackbar to show order status updated
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Order status updated"),
          duration: Duration(seconds: 1),
        ),
      );
      get(Uri.parse(url2)).then((Response response) {
        setState(() {
          allOrders = jsonDecode(response.body);
        });
      });
    });
  }

  void removeItem(int orderNumber) {
    updateOrderStatus(orderNumber, 'REJECTED');
  }

  void acceptItem(int orderNumber) {
    updateOrderStatus(orderNumber, 'ACCEPTED');
  }

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
                  for (var order in allOrders)
                    OrderGroup(
                      status: order['status'],
                      orderNumber: order['id'],
                      time: order['created_at'],
                      items: order['items'],
                      removeItem: removeItem,
                      acceptItem: acceptItem,
                    )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}