import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Reviews extends StatelessWidget {
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
          Reviewcard(),
          SizedBox(height: 24),
          Reviewcard(),
          SizedBox(height:24),
          Reviewcard()
        ]),
      ),
    );
  }
}


class Reviewcard extends StatelessWidget {
  const Reviewcard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      "A",
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
                  "Amanda",
                  style: GoogleFonts.spaceGrotesk(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                // star rating
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange),
                    Icon(Icons.star, color: Colors.orange),
                    Icon(Icons.star, color: Colors.orange),
                    Icon(Icons.star, color: Colors.orange),
                    Icon(Icons.star, color: Colors.grey[400]),
                  ]
                )
              ]
            ),
            // the review text
            SizedBox(height: 16),
          Text("Pretty good i don't know what to say lol lorem ipsum dolor why did i not copy paste this nevermind wahtever 4/5 stars", style: GoogleFonts.spaceGrotesk()),
          SizedBox(height: 8,),
          Row(
            children: [
              Spacer(),
              Text("17th August 2023 3:32 PM", style: GoogleFonts.spaceGrotesk(color: Colors.grey))
            ],
          )
          ],
        ),
      )
    );
  }
}