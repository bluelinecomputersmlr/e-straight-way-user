import 'package:cached_network_image/cached_network_image.dart';
import 'package:estraightwayapp/controller/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBar extends SearchDelegate {
  final homePageController = Get.put(HomePageController());
  SearchBar()
      : super(
          searchFieldLabel: "Search Service",
          searchFieldStyle: GoogleFonts.inter(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          ),
        );
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Get.back();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final categoryList = query.isEmpty
        ? homePageController.categories
        : homePageController.categories
            .where(
              (element) => element.name.toLowerCase().startsWith(
                    query.toLowerCase(),
                  ),
            )
            .toList();

    final subCategoryList = query.isEmpty
        ? homePageController.subCategories
        : homePageController.subCategories
            .where(
              (element) => element.subCategoryName.toLowerCase().startsWith(
                    query.toLowerCase(),
                  ),
            )
            .toList();
    return ListView(
      children: [
        const SizedBox(
          height: 10.0,
        ),
        (categoryList.isEmpty && subCategoryList.isEmpty)
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "$query is coming soon!",
                    style: GoogleFonts.inter(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Categories",
                      style: GoogleFonts.inter(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categoryList.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          '/subCategory?categoryUID=${categoryList[index].uid}',
                          arguments: categoryList[index],
                        );
                      },
                      child: SearchCard(
                          imageUrl: categoryList[index].photoUrl,
                          title: categoryList[index].name),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Sub Categories",
                      style: GoogleFonts.inter(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: subCategoryList.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        if (subCategoryList[index].subCategoryType == "date") {
                          Get.toNamed(
                              '/businessByDate?subCategoryUID=${subCategoryList[index].uid}',
                              arguments: subCategoryList[index]);
                        } else if (subCategoryList[index].subCategoryType ==
                            "service") {
                          Get.toNamed(
                              '/businessByService?subCategoryUID=${subCategoryList[index].uid}',
                              arguments: subCategoryList[index]);
                        } else if (subCategoryList[index].subCategoryType ==
                            "map") {
                          Get.toNamed(
                              '/businessByMap?subCategoryUID=${subCategoryList[index].uid}',
                              arguments: subCategoryList[index]);
                        }
                      },
                      child: SearchCard(
                        imageUrl: subCategoryList[index].subCategoryImage,
                        title: subCategoryList[index].subCategoryName,
                      ),
                    ),
                  )
                ],
              ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final categoryList = query.isEmpty
        ? homePageController.categories
        : homePageController.categories
            .where(
              (element) => element.name.toLowerCase().startsWith(
                    query.toLowerCase(),
                  ),
            )
            .toList();

    final subCategoryList = query.isEmpty
        ? homePageController.subCategories
        : homePageController.subCategories
            .where(
              (element) => element.subCategoryName.toLowerCase().startsWith(
                    query.toLowerCase(),
                  ),
            )
            .toList();
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Categories",
            style: GoogleFonts.inter(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: categoryList.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Get.toNamed(
                '/subCategory?categoryUID=${categoryList[index].uid}',
                arguments: categoryList[index],
              );
            },
            child: SearchCard(
              imageUrl: categoryList[index].photoUrl,
              title: categoryList[index].name,
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Sub Categories",
            style: GoogleFonts.inter(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: subCategoryList.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              if (subCategoryList[index].subCategoryType == "date") {
                Get.toNamed(
                    '/businessByDate?subCategoryUID=${subCategoryList[index].uid}',
                    arguments: subCategoryList[index]);
              } else if (subCategoryList[index].subCategoryType == "service") {
                Get.toNamed(
                    '/businessByService?subCategoryUID=${subCategoryList[index].uid}',
                    arguments: subCategoryList[index]);
              } else if (subCategoryList[index].subCategoryType == "map") {
                Get.toNamed(
                    '/businessByMap?subCategoryUID=${subCategoryList[index].uid}',
                    arguments: subCategoryList[index]);
              }
            },
            child: SearchCard(
              imageUrl: subCategoryList[index].subCategoryImage,
              title: subCategoryList[index].subCategoryName,
            ),
          ),
        )
      ],
    );
  }
}

class SearchCard extends StatelessWidget {
  const SearchCard({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  imageUrl,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
