import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class Reviews extends StatefulWidget {
  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  List reviews = [];

  void fetchReviews() async {
    const url = 'http://10.0.2.2:8000/reviews/1';
    final response = await get(Uri.parse(url));
    setState(() {
      reviews = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchReviews();
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
                "Reviews",
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
          SizedBox(height: 24),
          if (reviews.length == 0)
            Center(
              child: CircularProgressIndicator(),
            )
          else
            for (var review in reviews) Reviewcard(comment: review['comment'], reviewer: review['reviewer']['name'], rating: review['rating'], date: review['created_at'], itemName: review['reviewed_item']['name'])
        ]),
      ),
    );
  }
}


class Reviewcard extends StatelessWidget {
  final String comment;
  final String reviewer;
  final int rating;
  final String date;
  final String itemName;
  const Reviewcard({super.key, required this.comment, required this.reviewer, required this.rating, required this.date, required this.itemName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // profile pic
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          reviewer[0],
                          style: GoogleFonts.spaceGrotesk(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    // reviewer name
                    Text(
                      reviewer,
                      style: GoogleFonts.spaceGrotesk(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    // star rating
                    Row(
                      children: [
                        for (var i = 0; i < rating; i++)
                          Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 18,
                          ),
                        for (var i = 0; i < 5 - rating; i++)
                          Icon(
                            Icons.star,
                            color: Colors.grey,
                            size: 18,
                          ),
                      ]
                    )
                  ]
                ),
                // the review text
                SizedBox(height: 16),
              Text(comment, style: GoogleFonts.spaceGrotesk()),
              SizedBox(height: 8,),
              Row(
                children: [
                  Spacer(),
                  Text(itemName+", ", style: GoogleFonts.spaceGrotesk(color: Colors.grey)),
                  // date formatted
                  Text(date.substring(0, 10), style: GoogleFonts.spaceGrotesk(color: Colors.grey)),
                ],
              )
              ],
            ),
          )
        ),
        SizedBox(height: 24),
      ],
    );
  }
}