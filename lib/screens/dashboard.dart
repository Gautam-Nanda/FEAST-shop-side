import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Map<dynamic, dynamic> revenueStats = {
    "daily": "Loading",
    "weekly": "Loading",
    "monthly": "Loading"
  };

  late List<dynamic> recentOrders = [];

  @override
  void initState() {
    super.initState();
    const String url = "http://10.0.2.2:8000/store/1/revenue-stats";
    get(Uri.parse(url)).then((Response response) {
      setState(() {
        revenueStats = jsonDecode(response.body);
      });
    });
    const String url2 = "http://10.0.2.2:8000/orders/store/1?type=PENDING";
    get(Uri.parse(url2)).then((Response response) {
      setState(() {
        recentOrders = jsonDecode(response.body);
      });
    });
  }

  void updateOrderStatus(int orderNumber, String status) {
    String url = "http://10.0.2.2:8000/orders/$orderNumber/status?status=$status";
    const String url2 = "http://10.0.2.2:8000/orders/store/1?type=PENDING";
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
          recentOrders = jsonDecode(response.body);
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
                              revenueStats['daily'] == "Loading"
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: CircularProgressIndicator(
                                        color: Colors.green,
                                      ),
                                    )
                                  : Text(
                                      revenueStats['daily'].toString(),
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
                            "Weekly Revenue",
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
                              revenueStats['weekly'] == "Loading"
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: CircularProgressIndicator(
                                        color: Colors.green,
                                      ),
                                    )
                                  : Text(
                                      revenueStats['weekly'].toString(),
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
                            "Monthly Revenue",
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
                              revenueStats['monthly'] == "Loading"
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: CircularProgressIndicator(
                                        color: Colors.green,
                                      ),
                                    )
                                  : Text(
                                      revenueStats['monthly'].toString(),
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
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: [
                Text(
                  "Orders",
                  style: GoogleFonts.spaceGrotesk(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/allorders');
                    },
                    child: Text(
                      "View All",
                      style: GoogleFonts.spaceGrotesk(
                          color: Colors.orange,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (recentOrders.length == 0)
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                "No orders yet",
                style: GoogleFonts.spaceGrotesk(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          for (var order in recentOrders)
            OrderGroup(
              status: order['status'],
              orderNumber: order['id'],
              time: order['created_at'],
              items: order['items'],
              removeItem: removeItem,
              acceptItem: acceptItem,
            ),
          SizedBox(
            height: 24,
          ),
          Text(
            "Raw Material Offers",
            style: GoogleFonts.spaceGrotesk(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          // tabbed view, one for recieved and one for sent raw material offers
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  labelColor: Colors.orange,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.orange,
                  tabs: [
                    Tab(
                      text: "Recieved",
                    ),
                    Tab(
                      text: "Sent",
                    ),
                  ],
                ),
                Container(
                  height: 200,
                  child: TabBarView(
                    children: [
                      // recieved
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text("Raw Material Name"),
                            subtitle: Text("Rs. 400"),
                            trailing: ElevatedButton(
                              onPressed: () {
                                // open a bottom sheet with the outlet details
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 200,
                                      child: Column(children: [
                                        Text("Raw Material Name"),
                                        Text("Quantity"),
                                        Text("Price"),
                                        Text("Outlet Name"),
                                        Text("Address"),
                                        Text("Phone Number"),
                                        Text("Email"),
                                      ]),
                                    );
                                  },
                                );
                              },
                              child: Text("View"),
                            ),
                          );
                        },
                      ),
                      // sent
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text("Raw Material Name"),
                            subtitle: Text("Rs. 400"),
                            trailing: ElevatedButton(
                              onPressed: () {
                                // open a bottom sheet with the outlet details
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 200,
                                      child: Column(children: [
                                        Text("Raw Material Name"),
                                        Text("Quantity"),
                                        Text("Price"),
                                        Text("Outlet Name"),
                                        Text("Address"),
                                        Text("Phone Number"),
                                        Text("Email"),
                                      ]),
                                    );
                                  },
                                );
                              },
                              child: Text("View"),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class OrderGroup extends StatelessWidget {
  final String status;
  final int orderNumber;
  final String time;
  final List<dynamic> items;
  final Function(int) removeItem;
  final Function(int) acceptItem;

  const OrderGroup({
    super.key,
    required this.status,
    required this.orderNumber,
    required this.time,
    required this.items,
    required this.removeItem,
    required this.acceptItem,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: UniqueKey(), 

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {
              removeItem(orderNumber);
        }),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) {
              // remove this order from the list
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.cancel,
            label: 'Cancel',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {
              acceptItem(orderNumber);
        }),
        children: [
          SlidableAction(
            onPressed: (context) {
              // accept this order
            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.check,
            label: 'Accept',
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 16),
          Padding(
              child: OrderContainer(
                status: status,
                orderNumber: orderNumber,
                time: time,
                items: items,
              ),
              padding: EdgeInsets.only(left: 32)),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(
              height: 1,
              width: MediaQuery.of(context).size.width - 64,
              color: const Color.fromARGB(255, 206, 201, 201),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderContainer extends StatelessWidget {
  final String status;
  final int orderNumber;
  final String time;
  final List<dynamic> items;
  const OrderContainer(
      {super.key,
      required this.status,
      required this.orderNumber,
      required this.time,
      required this.items});

  // fill order # with leading zeros to make it 3 digits
  String fillOrderNumber(String orderNumber) {
    if (orderNumber.length == 1) {
      return "#00" + orderNumber;
    } else if (orderNumber.length == 2) {
      return "#0" + orderNumber;
    } else {
      return orderNumber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              "ORDER",
              style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.bold),
            ),
            Text(
              fillOrderNumber(orderNumber.toString()),
              style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(width: 32),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // for (var item in items) OrderItem(item: item['item']['name'], quantity: item['quantity']),
            OrderItem(
                item: items[0]['item']['name'], quantity: items[0]['quantity']),
            items.length > 1
                ? OrderItem(
                    item: items[1]['item']['name'],
                    quantity: items[1]['quantity'])
                : SizedBox(),
            Text(
              DateFormat('dd/mm, hh:mm a').format(DateTime.parse(time)),
              style: GoogleFonts.spaceGrotesk(
                  color: Colors.green, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(width: 32),
        Text(
          status,
          style: GoogleFonts.spaceGrotesk(
              color: status == "ACCEPTED" ? Colors.green : status == "REJECTED" ? Colors.red : Colors.yellow[700],
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class OrderItem extends StatelessWidget {
  // take item, quantity in constructor
  final String item;
  final int quantity;

  const OrderItem({super.key, required this.item, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          item,
          style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.bold),
        ),
        Text(
          " x $quantity",
          style: GoogleFonts.spaceGrotesk(color: Colors.orange),
        ),
      ],
    );
  }
}
