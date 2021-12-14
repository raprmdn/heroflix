import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heroflix/pages/add_movie.dart';
import 'package:heroflix/pages/auth_login.dart';
import 'package:heroflix/pages/movie_detail.dart';
import 'package:heroflix/providers/auth.dart';
import 'package:heroflix/providers/movies.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  _logout() async {
    var resp = await Provider.of<Auth>(context, listen: false).logout();
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(resp['message'])));

    await Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginPage(),
    ));
  }

  _getMovies() async {
    return await Provider.of<Movies>(context, listen: false).listMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout()
        ),
        title: const Text("Heroflix"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => AddMovie()
            )),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _getMovies(),
        builder: (context, snapshot) {
          if  (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data['data'].length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        const SizedBox(height: 15,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5,),
                          child: Row(
                            children: const [
                              Text(
                                'Featured Movies',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => MovieDetail(trackId: snapshot.data['data'][index]['track_id']))
                              ).then((value) => setState(() {}));
                            },
                            child: Card(
                              color: const Color(0xff262c32),
                              shadowColor: const Color(0x8a323250),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9.0),
                              ),
                              elevation: 10,
                              child: Row(
                                children: [
                                  Container(
                                    height: 150,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(9),
                                          topLeft: Radius.circular(9),
                                        ),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(snapshot.data['data'][index]['thumbnail'])
                                        )
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 150,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 248,
                                          child: Text(
                                            snapshot.data['data'][index]['title']
                                                + (' (${snapshot.data['data'][index]['release_year']})'),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        SizedBox(
                                          width: 240,
                                          child: Text(
                                            snapshot.data['data'][index]['description'],
                                            style: const TextStyle(
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => MovieDetail(trackId: snapshot.data['data'][index]['track_id']))
                              ).then((value) => setState(() {}));
                            },
                            child: Card(
                              color: const Color(0xff262c32),
                              shadowColor: const Color(0x8a323250),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9.0),
                              ),
                              elevation: 7,
                              child: Row(
                                children: [
                                  Container(
                                    height: 150,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(9),
                                          topLeft: Radius.circular(9),
                                        ),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(snapshot.data['data'][index]['thumbnail'])
                                        )
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 150,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 248,
                                          child: Text(
                                            snapshot.data['data'][index]['title']
                                                + (' (${snapshot.data['data'][index]['release_year']})'),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10,),
                                        SizedBox(
                                          width: 240,
                                          child: Text(
                                            snapshot.data['data'][index]['description'],
                                            style: const TextStyle(
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }
            );
          } else {
            return const Center(child: Text('Error getting data movies.'));
          }
        }
      ),
    );
  }
}