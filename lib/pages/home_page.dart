import 'package:flutter/material.dart';
import 'package:heroflix/pages/auth_login.dart';
import 'package:heroflix/providers/auth.dart';
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
  bool isInit = true;
  bool isLoading = false;

  _logout() async {
    var resp = await Provider.of<Auth>(context, listen: false).logout();
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(resp['message'])));

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginPage(),
    ));
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      isLoading = true;
      Provider.of<Products>(context, listen: false).inisialData().then((value) {
        setState(() {
          isLoading = false;
        });
      }).catchError(
            (err) {
          print(err);
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Error Occured"),
                content: Text(err.toString()),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pop(context);
                    },
                    child: Text("Okay"),
                  ),
                ],
              );
            },
          );
        },
      );

      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout()
        ),
        title: Text("All Movies"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, AddProductPage.route),
          ),
        ],
      ),
      body: (isLoading)
          ? Center(
        child: CircularProgressIndicator(),
      )
          : (prov.allProduct.length == 0)
          ? Center(
        child: Text(
          "No Data",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      )
          : ListView.builder(
        itemCount: prov.allProduct.length,
        itemBuilder: (context, i) => ProductItem(
          prov.allProduct[i].id,
          prov.allProduct[i].title,
          prov.allProduct[i].price,
          prov.allProduct[i].updatedAt,
        ),
      ),
    );
  }
}