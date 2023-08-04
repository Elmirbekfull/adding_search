import 'dart:math';

import 'package:flutter/material.dart';
import 'package:note_practice/contants/colors.dart';
import 'package:note_practice/models/list_movie.dart';

class ScreenWidget extends StatefulWidget {
  const ScreenWidget({super.key});

  @override
  State<ScreenWidget> createState() => _ScreenWidgetState();
}

class _ScreenWidgetState extends State<ScreenWidget> {
  getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }
  // getRandomColor() {
  //   Random random = Random();
  //   return backgroundColors[random.nextInt(backgroundColors.length)];
  // }

  List<Movie> filteredMovie = [];

  void onSerachTextChanged(String searchText) {
    setState(() {
      filteredMovie = movieList
          .where((movie) =>
              movie.titile.toLowerCase().contains(searchText.toLowerCase()) ||
              movie.content.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    filteredMovie = movieList;
  }

  @override
  Widget build(BuildContext context) {
    Size mySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("flutter UI"),
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: IconButton(
              onPressed: () {
                setState(() {
                  getRandomColor();
                });
              },
              icon: const Icon(
                Icons.menu,
                size: 30,
              )),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    // getRandomColor();
                  });
                },
                icon: const Icon(
                  Icons.repeat,
                  size: 30,
                )),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            // TextField(
            //   // controller: _searchController,
            //   onChanged: (value) {
            //     onSerachTextChanged(value);
            //   },
            //   style: const TextStyle(color: Colors.black, fontSize: 20),
            //   decoration: InputDecoration(
            //       contentPadding: EdgeInsets.symmetric(vertical: 16),
            //       hintText: "Search movie",
            //       hintStyle: const TextStyle(
            //         color: Colors.white,
            //         fontSize: 18,
            //       ),
            //       fillColor: Colors.white.withAlpha(100),
            //       filled: true,
            //       prefixIcon: const Icon(
            //         Icons.search,
            //         color: Colors.black,
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(30),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(30),
            //       )),
            // ),
            // SizedBox(
            //   height: mySize.height * 0.03,
            // ),
            Expanded(
              child: Stack(
                children: [
                  ListView.builder(
                      padding: EdgeInsets.only(top: 70),
                      itemCount: filteredMovie.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: mySize.height * 0.30,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.2)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              color: getRandomColor(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    filteredMovie[index].titile,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: mySize.height * 0.02,
                                  ),
                                  Text(
                                    filteredMovie[index].content,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 7,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                  TextField(
                    onChanged: (value) {
                      onSerachTextChanged(value);
                    },
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search text",
                        hintStyle: const TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                        filled: true,
                        fillColor: Colors.white.withAlpha(250),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
