import 'package:flutter/material.dart';

class PopWidget extends StatelessWidget {
  final String image;
  final String title, artist;

  const PopWidget({Key key, this.image, this.title, this.artist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blue.withAlpha(30),
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            image: DecorationImage(
                image: AssetImage(image), fit: BoxFit.cover),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.15),
                offset: Offset(2, 12.0),
                blurRadius: 4.0,
                spreadRadius: 5.0,
              ),
            ]),
        child: SizedBox(
          height: 230,
          width: 215,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  height: 60,
                  width: 215,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                    ),
                    color: Colors.pink.withOpacity(0.8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              artist,
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFededed),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.play_circle_fill_outlined,
                        color: Colors.white,
                        size: 44,
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
