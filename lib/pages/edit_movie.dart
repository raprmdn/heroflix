import 'package:flutter/material.dart';
import 'package:heroflix/providers/movies.dart';
import 'package:provider/provider.dart';

class EditMovie extends StatefulWidget {
  final Map movie;
  EditMovie({@required this.movie});

  @override
  State<EditMovie> createState() => _AddMovieState();
}

class _AddMovieState extends State<EditMovie> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController ageRestrictedController = TextEditingController();
  TextEditingController releaseYearController = TextEditingController();
  TextEditingController seasonController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  TextEditingController thumbnailController = TextEditingController();
  TextEditingController actorController = TextEditingController();
  TextEditingController directorController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _updateMovie() async {
    var resp = await Provider.of<Movies>(context, listen: false).updateMovies(
      titleController.text,
      descriptionController.text,
      ageRestrictedController.text,
      int.parse(releaseYearController.text),
      seasonController.text,
      genreController.text,
      thumbnailController.text,
      actorController.text,
      directorController.text,
      widget.movie['track_id'],
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(resp['message'])));

    Navigator.pop(context);
    // await Navigator.of(context).pushReplacement(MaterialPageRoute(
    //   builder: (context) => HomePage(),
    // ));
    print(resp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Edit Movie "${widget.movie['title']}"'),
        ),
        body: SafeArea(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(15.0),
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          TextFormField(
                            autocorrect: false,
                            autofocus: false,
                            controller: titleController..text = widget.movie['title'],
                            // textInputAction: TextInputAction.next,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: "Movie Title",
                              filled: true,
                              fillColor: const Color(0xff262c32),
                              labelStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none
                              ),
                            ),
                            validator: (value) => value.isEmpty ? 'Movie title is required.' : null,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            autocorrect: false,
                            autofocus: false,
                            minLines: 10,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: descriptionController..text = widget.movie['description'],
                            // textInputAction: TextInputAction.next,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: "Movie Description",
                              filled: true,
                              fillColor: const Color(0xff262c32),
                              labelStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none
                              ),
                            ),
                            validator: (value) => value.isEmpty ? 'Movie description is required.' : null,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            autocorrect: false,
                            autofocus: false,
                            controller: ageRestrictedController..text = widget.movie['age_restricted'],
                            // textInputAction: TextInputAction.next,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: "Age Restricted",
                              filled: true,
                              fillColor: const Color(0xff262c32),
                              labelStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none
                              ),
                            ),
                            validator: (value) => value.isEmpty ? 'Age Restricted is required.' : null,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            autocorrect: false,
                            autofocus: false,
                            controller: releaseYearController..text = widget.movie['release_year'],
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: "Release Year",
                              filled: true,
                              fillColor: const Color(0xff262c32),
                              labelStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none
                              ),
                            ),
                            validator: (value) => value.isEmpty ? 'Release Year is required.' : null,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            autocorrect: false,
                            autofocus: false,
                            controller: seasonController..text = widget.movie['season'],
                            // textInputAction: TextInputAction.next,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: "Season",
                              filled: true,
                              fillColor: const Color(0xff262c32),
                              labelStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none
                              ),
                            ),
                            validator: (value) => value.isEmpty ? 'Season is required.' : null,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            autocorrect: false,
                            autofocus: false,
                            controller: genreController..text = widget.movie['genre'],
                            // textInputAction: TextInputAction.next,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: "Genre",
                              filled: true,
                              fillColor: const Color(0xff262c32),
                              labelStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none
                              ),
                            ),
                            validator: (value) => value.isEmpty ? 'Genre is required.' : null,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            autocorrect: false,
                            autofocus: false,
                            controller: thumbnailController..text = widget.movie['thumbnail'],
                            // textInputAction: TextInputAction.next,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: "Thumbnail URL",
                              filled: true,
                              fillColor: const Color(0xff262c32),
                              labelStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none
                              ),
                            ),
                            validator: (value) => value.isEmpty ? 'Thumbnail URL is required.' : null,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            autocorrect: false,
                            autofocus: false,
                            controller: actorController..text = widget.movie['starring'],
                            // textInputAction: TextInputAction.next,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: "Actor",
                              filled: true,
                              fillColor: const Color(0xff262c32),
                              labelStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none
                              ),
                            ),
                            validator: (value) => value.isEmpty ? 'Actor is required.' : null,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            autocorrect: false,
                            autofocus: false,
                            controller: directorController..text = widget.movie['director'],
                            // textInputAction: TextInputAction.next,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: "Director",
                              filled: true,
                              fillColor: const Color(0xff262c32),
                              labelStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none
                              ),
                            ),
                            validator: (value) => value.isEmpty ? 'Director is required.' : null,
                          ),
                          Container(
                            width: double.infinity,
                            height: 45,
                            margin: const EdgeInsets.only(
                              top: 24,
                            ),
                            child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _updateMovie();
                                }
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xff546EE5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  )
                              ),
                              child: const Text(
                                'Update',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                  ),
                ],
              ),
            )
        )
    );
  }
}