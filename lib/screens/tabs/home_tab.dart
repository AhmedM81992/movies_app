import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/shared/components/constants.dart';
import 'package:movies_app/shared/networks/remote/api_manager.dart';
import 'package:movies_app/shared/styles/my_theme_data.dart';

class HomeTab extends StatelessWidget {
  HomeTab({super.key});
  //String baseUrl = "https://image.tmdb.org/t/p/w500";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(children: [
        // Placeholder(
        //   fallbackHeight: 289,
        //   fallbackWidth: 412,
        //   color: Colors.white38,
        // ),
        Container(
          height: 289,
          width: 412,
          child: FutureBuilder(
            future: ApiManager.getPopular(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("Something Went Wrong!"));
              }
              var moviesList = snapshot.data?.results ?? [];
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Image.network(
                    Constants.IMAGE_BASE_URL +
                        (moviesList[index].backdropPath ?? ""),
                  );
                },
                itemCount: moviesList.length,
              );
            },
          ),
        ),
        SizedBox(height: 24),
        Container(
          color: MyThemeData.searchBox,
          width: 420,
          height: 187,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'New Releases', // Title
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 0, // Set the itemCount to 0 for an empty list
                  itemBuilder: (BuildContext context, int index) {
                    // This function won't be called since the itemCount is 0
                    return Container(); // Return an empty container
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
        Container(
          color: MyThemeData.searchBox,
          width: 420,
          height: 187,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recommended', // Title
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10, // Set the itemCount to 0 for an empty list
                  itemBuilder: (BuildContext context, int index) {
                    // This function won't be called since the itemCount is 0
                    return Container(); // Return an empty container
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
