import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../AllWidgets/Divider.dart';
import '../AllWidgets/progressDialog.dart';
import '../Assistants/requestAssistant.dart';
import '../DataHandler/appData.dart';
import '../Models/address.dart';
import '../Models/placePredictions.dart';
import '../configMaps.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController dropOffTextEditingController = TextEditingController();
  List<PlacePredictions> placePredictionList = [];

  @override
  Widget build(BuildContext context) {
    String placeAddress =
        Provider.of<AppData>(context).pickUpLocation.placeName ?? "";
    pickUpTextEditingController.text = placeAddress;
    print(placeAddress);

    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Find Donor Text
          Container(
            margin: const EdgeInsets.only(bottom: 10, top: 20),
            child: const Text(
              "Find Donor",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          //Search for Blood Donors Text
          const Text(
            'Search for Blood Donors around You',
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          //Find Location Text
          const Text(
            "Find Location",
            style: TextStyle(),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          //Input Section

          Card(
            color: Colors.transparent,
            elevation: 20,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.only(left: 20),
              height: MediaQuery.of(context).size.height * 0.07,
              child: Row(
                children: [
                  Flexible(
                      child: TextField(
                    controller: pickUpTextEditingController,
                    decoration: const InputDecoration(
                      hintText: "Current Location",
                      border: InputBorder.none,
                      filled: true,
                      isDense: true,
                      contentPadding:
                          EdgeInsets.only(left: 11.0, top: 8.0, bottom: 8.0),
                    ),
                  ))
                ],
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          Card(
            color: Colors.transparent,
            elevation: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.only(left: 20),
              height: MediaQuery.of(context).size.height * 0.07,
              child: Row(
                children: [
                  Flexible(
                      child: TextField(
                    onChanged: (val) {
                      findPlace(val);
                    },
                    controller: dropOffTextEditingController,
                    decoration: const InputDecoration(
                      hintText: "Choose Your Hospital Location",
                      border: InputBorder.none,
                      isDense: true,
                      filled: true,
                      contentPadding:
                          EdgeInsets.only(left: 11.0, top: 8.0, bottom: 8.0),
                    ),
                  ))
                ],
              ),
            ),
          ),
          //tile for predictions
          const SizedBox(
            height: 10.0,
          ),
          (placePredictionList.isNotEmpty)
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: ListView.separated(
                      padding: const EdgeInsets.all(0.0),
                      itemBuilder: (context, index) {
                        return PredictionTile(
                          placePredictions: placePredictionList[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const DividerWidget(),
                      itemCount: placePredictionList.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                    ),
                  ),
                )
              : Container(),
          //Search Button
          // InkWell(
          //   onTap: () => "Null",
          //   child: Container(
          //     color: Colors.red,
          //     height: MediaQuery.of(context).size.height * 0.07,
          //     child: Center(
          //       child: Text(
          //         "Search Nearby",
          //         style: TextStyle(color: Colors.white),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    )));
  }

  void findPlace(String placeName) async {
    if (placeName.length > 1) {
      String autoCompleteUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&types=hospital&key=$mapKey&components=country:gh";

      var res = await RequestAssistant.getRequest(autoCompleteUrl);

      if (res == "failed") {
        return;
      }

      if (res["status"] == "OK") {
        var predictions = res["predictions"];

        var placesList = (predictions as List)
            .map((e) => PlacePredictions.fromJson(e))
            .toList();

        setState(() {
          placePredictionList = placesList;
        });
      }
    }
  }
}

class PredictionTile extends StatelessWidget {
  final PlacePredictions placePredictions;

  PredictionTile({Key key, this.placePredictions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: const EdgeInsets.all(0.0),
      onPressed: () {
        getPlaceAddressDetails(placePredictions.place_id, context);
      },
      child: Container(
        child: Column(
          children: [
            const SizedBox(
              width: 10.0,
            ),
            Row(
              children: [
                const Icon(Icons.add_location),
                const SizedBox(
                  width: 14.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        placePredictions.main_text,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        placePredictions.secondary_text,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  void getPlaceAddressDetails(String placeId, context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(
              message: "Sarching...",
            ));

    String placeDetailsUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapKey";

    var res = await RequestAssistant.getRequest(placeDetailsUrl);

    Navigator.pop(context);

    if (res == "failed") {
      return;
    }

    if (res["status"] == "OK") {
      Address address = Address();
      address.placeName = res["result"]["name"];
      address.placeId = placeId;
      address.latitude = res["result"]["geometry"]["location"]["lat"];
      address.longitude = res["result"]["geometry"]["location"]["lng"];

      Provider.of<AppData>(context, listen: false)
          .updateDropOffLocationAddress(address);

      Navigator.pop(context, "obtainDirection");
    }
  }
}
