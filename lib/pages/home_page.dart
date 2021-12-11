import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heroflix/pages/auth_login.dart';
import 'package:heroflix/pages/movie_detail.dart';
import 'package:heroflix/providers/auth.dart';
import 'package:heroflix/providers/movies.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

import '../pages/add_product_page.dart';
import '../widgets/product_item.dart';

class HomePage extends StatefulWidget {
  static const route = "/home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // bool isInit = true;
  // bool isLoading = false;

  _logout() async {
    var resp = await Provider.of<Auth>(context, listen: false).logout();
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(resp['message'])));

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginPage(),
    ));
  }

  _getMovies() async {
    return await Provider.of<Movies>(context, listen: false).listMovies();
  }

  // @override
  // void didChangeDependencies() {
  //   if (isInit) {
  //     isLoading = true;
  //     Provider.of<Products>(context, listen: false).inisialData().then((value) {
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }).catchError(
  //           (err) {
  //         print(err);
  //         showDialog(
  //           context: context,
  //           builder: (context) {
  //             return AlertDialog(
  //               title: Text("Error Occured"),
  //               content: Text(err.toString()),
  //               actions: [
  //                 TextButton(
  //                   onPressed: () {
  //                     setState(() {
  //                       isLoading = false;
  //                     });
  //                     Navigator.pop(context);
  //                   },
  //                   child: Text("Okay"),
  //                 ),
  //               ],
  //             );
  //           },
  //         );
  //       },
  //     );
  //
  //     isInit = false;
  //   }
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout()
        ),
        title: Text("Heroflix"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, AddProductPage.route),
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
                        SizedBox(height: 25,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5,),
                          child: Row(
                            children: [
                              Text(
                                'Featured Movies',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetail()));
                              },
                              child: Card(
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
                                          borderRadius: BorderRadius.only(
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
                                          Text(
                                            snapshot.data['data'][index]['title']
                                                + (' (${snapshot.data['data'][index]['release_year']})'),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          Container(
                                            width: 240,
                                            child: Text(
                                              snapshot.data['data'][index]['description'],
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
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
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
                                        borderRadius: BorderRadius.only(
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
                                        Text(
                                          snapshot.data['data'][index]['title']
                                              + (' (${snapshot.data['data'][index]['release_year']})'),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Container(
                                          width: 240,
                                          child: Text(
                                            snapshot.data['data'][index]['description'],
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
      // body: (isLoading)
      //     ? Center(
      //   child: CircularProgressIndicator(),
      // )
      //     : (prov.allProduct.length == 0)
      //     ? Center(
      //   child: Text(
      //     "No Data",
      //     style: TextStyle(
      //       fontSize: 25,
      //     ),
      //   ),
      // )
      //     : ListView.builder(
      //   itemCount: prov.allProduct.length,
      //   itemBuilder: (context, i) => ProductItem(
      //     prov.allProduct[i].id,
      //     prov.allProduct[i].title,
      //     prov.allProduct[i].price,
      //     prov.allProduct[i].updatedAt,
      //   ),
      // ),
    );
  }
}