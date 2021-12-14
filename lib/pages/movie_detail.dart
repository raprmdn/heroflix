import 'package:flutter/material.dart';
import 'package:heroflix/pages/edit_movie.dart';
import 'package:heroflix/pages/home_page.dart';
import 'package:heroflix/providers/movies.dart';
import 'package:provider/provider.dart';

class MovieDetail extends StatefulWidget {
  final int trackId;
  MovieDetail({@required this.trackId});

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  var movie;

  _detailMovies() async {
    return await Provider.of<Movies>(context, listen: false).showMovies(widget.trackId);
  }

  _deleteMovies() async {
    var resp = await Provider.of<Movies>(context, listen: false).deleteMovies(widget.trackId);

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(resp['message'])));

    print(resp);
    await Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => HomePage(),
    ));
  }

  _data(Map data) {
    return movie = data;
  }

  onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EditMovie(movie: movie)),
        ).then((value) => setState(() {}));
        break;
      case 1:
        _deleteMovies();
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    print(movie);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Detail"),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text('Edit Movie'),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Delete Movie'),
              ),
            ]
          )
        ],
      ),
      body: FutureBuilder(
          future: _detailMovies(),
          builder: (context, snapshot) {
            if  (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              _data(snapshot.data);
              return ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30
                ),
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          alignment: Alignment.center,
                          fit: BoxFit.fill,
                          image: NetworkImage(snapshot.data['thumbnail']),
                        )
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          runSpacing: 10.0,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color(0xff686868)
                              ),
                              child: Text(
                                snapshot.data['release_year'],
                                style: const TextStyle(
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xff686868)
                              ),
                              child: Text(
                                snapshot.data['age_restricted'],
                                style: const TextStyle(
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color(0xff686868)
                              ),
                              child: Text(
                                snapshot.data['genre'],
                                style: const TextStyle(
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color(0xff686868)
                              ),
                              child: Text(
                                snapshot.data['season'],
                                style: const TextStyle(
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          snapshot.data['title'],
                          style: const TextStyle(
                            fontSize: 25,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffffffff),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text.rich(
                            TextSpan(
                                text: snapshot.data['description'],
                                style: const TextStyle(
                                    color: Color(0xffBABFC9),
                                    fontWeight: FontWeight.w100
                                )
                            )
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Actor',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffffffff),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                snapshot.data['starring'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xffBABFC9),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Director',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffffffff),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                snapshot.data['director'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xffBABFC9),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 56,
                          margin: const EdgeInsets.only(
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
                            child: const Text(
                              'Watch Movie',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 18,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text('Error getting data movies.'));
            }
          }
      ),
    );
  }
}