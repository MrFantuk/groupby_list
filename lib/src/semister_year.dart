import 'package:flutter/material.dart';
import 'package:test_list_groupby/model/year_model.dart';
import "package:collection/collection.dart";

class SemesterYear extends StatelessWidget {
  final SemesterDetails detailsList;

  const SemesterYear({Key? key, required this.detailsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Semester"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, int index) {
                  final List<Details> listWithStatusLive = [];
                  final List<Details> listWithStatusCompleted = [];
                  for (var item in detailsList.details) {
                    if (item.status == "COMPLETED") {
                      listWithStatusCompleted.add(item);
                    }
                    if (item.status == "LIVE") {
                      listWithStatusLive.add(item);
                    }
                  }
                  final Map<String, List<Details>> semesterGroupListByStatus =
                      groupBy(detailsList.details, (Details key) => key.status);

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Live"),
                        SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: listWithStatusLive.length,
                            itemBuilder: (context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: 150,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      shape: BoxShape.rectangle,
                                      color: Colors.green),
                                  child: Center(
                                      child: Text(listWithStatusLive[index]
                                          .semesterName
                                          .toString())),
                                ),
                              );
                            }),
                        Text("Live semester: ${listWithStatusLive.length.toString()} "),
                        SizedBox(
                          height: 80,
                        ),
                        Text("Completed"),
                        SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: listWithStatusCompleted.length,
                            itemBuilder: (context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  width: 150,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      shape: BoxShape.rectangle,
                                      color: Colors.orange),
                                  child: Center(
                                      child: Text(listWithStatusCompleted[index]
                                          .semesterName
                                          .toString())),
                                ),
                              );
                            }),
                        Text("Completed semester: ${listWithStatusCompleted.length.toString()} "),
                      ],
                    ),
                  );
                  // return ListView.builder(
                  //     shrinkWrap: true,
                  //     itemCount: semesterGroupListByStatus.length,
                  //     itemBuilder: (context, int index) {
                  //       return _tile(index);
                  //     });
                })
          ],
        ),
      ),
    );
  }

  Widget _tile(index) {
    return ListTile(
      title: Text(detailsList.details[index].semesterName),
      subtitle: Text(detailsList.details[index].status),
    );
  }
}
