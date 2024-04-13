import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/shared/components/constants.dart';
import 'package:movies_app/shared/networks/local/fetch_api.dart';
import 'package:movies_app/shared/styles/my_theme_data.dart';
import 'package:movies_app/widgets/containers/bookmark_container.dart';

import 'details_page.dart';

class UpComingContainer extends StatefulWidget {
  const UpComingContainer({Key? key}) : super(key: key);

  @override
  State<UpComingContainer> createState() => _UpComingContainerState();
}

class _UpComingContainerState extends State<UpComingContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyThemeData.searchBox,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.235,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
            child: Text(
              'New Releases', // Title
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: FetchAPI.getUpcoming(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                          color: MyThemeData.selectedColor));
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Something Went Wrong!"));
                }
                var moviesList = snapshot.data?.results ?? [];
                return ListView.builder(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.02),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.width * 0.02,
                          left: MediaQuery.of(context).size.width * 0.02,
                          bottom: MediaQuery.of(context).size.width * 0.02),
                      child: Container(
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  DetailsPage.routeName,
                                  arguments: moviesList[index].id,
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: Constants.IMAGE_BASE_URL +
                                      (moviesList[index].posterPath ?? ""),
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(
                                      color: MyThemeData.selectedColor,
                                      value: downloadProgress.progress,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            MyBookmarkWidget(moviesList: moviesList[index]),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: moviesList.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
