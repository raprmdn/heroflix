import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  final Map movies;
  MovieDetail({@required this.movies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Detail"),
        centerTitle: true,
      ),
      body:ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 30
        ),
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                alignment: Alignment.center,
                fit: BoxFit.fill,
                image: NetworkImage(movies['thumbnail']),
              )
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  runSpacing: 10.0,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff686868)
                      ),
                      child: Text(
                        movies['release_year'],
                        style: TextStyle(
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xff686868)
                      ),
                      child: Text(
                        movies['age_restricted'],
                        style: TextStyle(
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff686868)
                      ),
                      child: Text(
                        movies['genre'],
                        style: TextStyle(
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff686868)
                      ),
                      child: Text(
                        movies['season'],
                        style: TextStyle(
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  movies['title'],
                  style: TextStyle(
                    fontSize: 25,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xffffffff),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text.rich(
                    TextSpan(
                        text: movies['description'],
                        style: TextStyle(
                            color: const Color(0xffBABFC9),
                            fontWeight: FontWeight.w100
                        )
                    )
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Actor',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xffffffff),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        movies['starring'],
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: const Color(0xffBABFC9),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Director',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xffffffff),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        movies['director'],
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: const Color(0xffBABFC9),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 56,
                  margin: EdgeInsets.only(
                    top: 24,
                    bottom: 30,
                  ),
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xff546EE5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )
                    ),
                    child: Text(
                      'Watch Movie',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}