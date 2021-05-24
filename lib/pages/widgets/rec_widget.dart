import 'package:flutter/material.dart';
import 'package:lofi/data/models/lofi.dart';

class RecentLofi extends StatelessWidget {
  final Lofi lofi;

  const RecentLofi({Key key, this.lofi}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, top: 10),
      child: SizedBox(
        height: 100,
        width: 500,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                height: 90,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                      image: AssetImage('assets/images/01.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lofi.title,
                        style:
                            TextStyle(color: Color(0xff555563), fontSize: 18),
                      ),
                      Text(
                        lofi.artist,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFb3b3c9),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.more_vert,
              color: Color(0xFFb3b3c9),
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
