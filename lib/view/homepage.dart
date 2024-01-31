import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imdb_rapid_api/controller/controller.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GetDataController getDataController = Get.put(GetDataController());
  final RefreshController refreshControllerbrand =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  void fetchData() {
    Future.delayed(Duration.zero, () async {
      await getDataController.filmDataResult();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Movies",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.purple.shade50,
        body: Center(
          child: SmartRefresher(
            enablePullDown: true,
            onRefresh: () {
              fetchData();
              refreshControllerbrand.refreshCompleted();
            },
            controller: refreshControllerbrand,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: getDataController.searchItemController.value,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        filled: true,
                        fillColor: Colors.deepPurple.shade50,
                        hintText: 'Search a movie',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              getDataController.itemName.value =
                                  getDataController
                                      .searchItemController.value.text;
                              getDataController.saveData.clear();
                              fetchData();
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.deepPurple,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('Search'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(height: 24),
                    Text(
                      getDataController.searchItemController.value.text.isEmpty
                          ? 'Find your favorite movie'
                          : 'Top Movies related to ${getDataController.searchItemController.value.text}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    getDataController.isDataLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : getDataController.saveData.isEmpty
                            ? Center(
                                child: Text(
                                  getDataController.searchItemController.value
                                          .text.isEmpty
                                      ? 'Please fill the search box to get result'
                                      : "No data available about ${getDataController.searchItemController.value.text}",
                                  style: const TextStyle(color: Colors.black),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: getDataController
                                    .saveData.first.titleResults.results.length,
                                itemBuilder: (context, index) {
                                  var movie = getDataController
                                      .saveData.first.findPageMeta;
                                  var details = getDataController.saveData.first
                                      .titleResults.results[index];

                                  return InkWell(
                                    onTap: () async {},
                                    child: Card(
                                      elevation: 4,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                            ),
                                            child: Image.network(
                                              details.titlePosterImageModel.url,
                                              fit: BoxFit.cover,
                                              height: 200,
                                              width: double.infinity,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  details.titleNameText,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  'Release Year : ${details.titleReleaseText}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.deepPurple,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  'Search Term : ${movie.searchTerm}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.deepPurple,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  'Description : ${details.titlePosterImageModel.caption}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  'TopCredits : ${details.topCredits}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
