import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:http/retry.dart';
import 'package:test_list_groupby/model/year_model.dart';
import 'package:test_list_groupby/src/semister_year.dart';

class YearsListByGroup extends StatefulWidget {
  const YearsListByGroup({Key? key}) : super(key: key);

  @override
  _YearsListByGroupState createState() => _YearsListByGroupState();
}

class _YearsListByGroupState extends State<YearsListByGroup> {
  static const String key =
      "eyJhbGciOiJSUzUxMiIsImtpZCI6InNzcnNhMDEiLCJwaS5hdG0iOiIxIn0.eyJzY29wZSI6WyJvcGVuaWQiXSwiY2xpZW50X2lkIjoicm5yLXVhdCIsInN1YiI6ImJlOGJjYmZkLTI4ZDItNDI3My1iNzcyLWYwZWI1Y2I4NGNiMyIsInVpZCI6InNocmF2YW4ua3VtYXIudmNAc3RhcnR2LmNvbSIsIm5hbWUiOiJLdW1hciwgU2hyYXZhbiIsImdpdmVuX25hbWUiOiJTaHJhdmFuIiwiZmFtaWx5X25hbWUiOiJLdW1hciIsImVtYWlsIjoic2hyYXZhbi5rdW1hci52Y0BzdGFydHYuY29tIiwiZXhwIjoxNjM3MDQ1NzQzfQ.FePZDRH9WMUDCvwRn5XatFRSBJlLMSxq2dyADy7GYCH25nB-hurnejci0cgTKivEbsDyyTjhRBn33E3lReYiA3Fm_NeR4BWOge9hkA8yZmx8TvldHSLx8LzIrQgIVTNYZmaJ1AN5c3R8uFZaNBhtC9sgA-z_hdLv-UGJvAQXxWKpoeUHxGKM2ZttV-B7O4HP7H7dj8dlmalV-s2JSm_loZxbvg0pTCAvZOhJq9hd2BUvQtQNxuEp1kfitMQyJu8oQZSKn7onJGQtjvnM_BrC27vEmBD_c-wXz6tE-1sV6MPHzBtSDEDoh_b302Wgv4f8n3bFSuOX-bbeJ6A8_A9f1g";
  static const String API_ALL_YEARS = '$API_BASE/getAwardsList?data1=';
  static const String API_BASE = '$API_BASE_URL/api/HomeApi';
  static const String API_BASE_URL = 'https://rnrwebapi-uat.azurewebsites.net/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Years")),
      body: SingleChildScrollView(
        child: Column(
          children: [getData()],
        ),
      ),
    );
  }

  Widget getData() {
    return FutureBuilder<YearModel>(
        future: getYearDetails(),
        builder: (context, AsyncSnapshot<YearModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<Data1> data1List = snapshot.data!.data1;
            // final yearGroupedList = data1List.groupBy((m) => m['release_date']);
            final Map<int, List<Data1>> yearGroupedList =
                groupBy(data1List, (Data1 key) => key.semesterYear);
            return ListView.builder(
                shrinkWrap: true,
                itemCount: yearGroupedList.length,
                itemBuilder: (context, int index) {
                  return yearTile(
                      context, yearGroupedList.values.elementAt(index), index);
                });
          }

          return const Center(child: CircularProgressIndicator());
        });
  }

  Widget yearTile(context, List<Data1> data1, int index) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 1,
      itemBuilder: (context, int i) => ListTile(
        minLeadingWidth: 1,
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SemesterYear(detailsList: data1[i].semesterDetails))),
        leading: const Icon(Icons.chevron_right),
        title: Row(
          children: [
            Text(data1[i].semesterYear.toString()),
            const SizedBox(width: 10,),
            data1[i].semesterDetails.details.map((e) => e.status).contains("LIVE") ? Container(
              width: 50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                shape: BoxShape.rectangle,
                color: Colors.green
              ),
              child: const Center(child: const Text("Live")),
            ) : const SizedBox()
          ],
        ),
        // trailing: data1[i].semesterDetails.,
      ),
    );
  }

  Future<YearModel> getYearDetails() async {
    var url = Uri.parse(API_ALL_YEARS);
    var response = await http.get(url, headers: {"token": key});
    print("StatusCode: ${response.statusCode}");
    print(response);
    return yearsFromJson(response.body);
    // return YearModel.fromJson(response.body as Map<String, dynamic>);
  }
}
