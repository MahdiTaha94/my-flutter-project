import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'model/order_model.dart';

class DetailsScreen extends StatefulWidget {
  String lat, lng, id;

  DetailsScreen({required this.lat, required this.lng, required this.id});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('value-1'),
          position:
              LatLng(double.parse(widget.lat), double.parse(widget.lng))));
    });
  }
  final List<bool>Selected =List.generate(1, (_) => false);


  @override
  Widget build(BuildContext context) {
    double price1, price2;
    double total;
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            height: 200,
            child: GoogleMap(
              zoomControlsEnabled: true,
              onMapCreated: _onMapCreated,
              markers: _markers,
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      double.parse(widget.lat), double.parse(widget.lng)),
                  zoom: 3),
            ),
          ),
          Expanded(
            child: FutureBuilder<OrdersModel>(
              future: getOrdersApi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data?.data?.length,
                      itemBuilder: (context, index) {
                        price1 = double.parse(snapshot.data!
                            .data![int.parse(widget.id) - 1].items![0].price
                            .toString() as String);
                        price2 = double.parse(
                          snapshot.data!.data![int.parse(widget.id) - 1]
                              .items![1].price
                              .toString() as String,
                        );
                        total = price2 + price1;

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width * 1,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: 1,
                                    itemBuilder: (context, position) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Column(children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: 100,
                                              ),
                                              Text(
                                                "Item 1:",
                                                style: TextStyle(
                                                    color: Colors
                                                        .blueAccent.shade100,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 100.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      snapshot
                                                          .data!
                                                          .data![int.parse(
                                                                  widget.id) -
                                                              1]
                                                          .items![0]
                                                          .name
                                                          .toString() as String,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15),
                                                    ),
                                                    Text(
                                                      snapshot
                                                          .data!
                                                          .data![int.parse(
                                                                  widget.id) -
                                                              1]
                                                          .items![0]
                                                          .price
                                                          .toString() as String,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Item 2:",
                                                style: TextStyle(
                                                    color: Colors
                                                        .blueAccent.shade100,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 100.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      snapshot
                                                          .data!
                                                          .data![int.parse(
                                                                  widget.id) -
                                                              1]
                                                          .items![1]
                                                          .name
                                                          .toString() as String,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15),
                                                    ),
                                                    Text(
                                                      snapshot
                                                          .data!
                                                          .data![int.parse(
                                                                  widget.id) -
                                                              1]
                                                          .items![1]
                                                          .price
                                                          .toString() as String,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 100,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Total",
                                                style: TextStyle(
                                                    color: Colors
                                                        .blueAccent.shade100,
                                                    fontSize: 20),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 150.0),
                                                child: Text(
                                                  ('$total'),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 70,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Add to Favourite",
                                                style: TextStyle(
                                                    color: Colors
                                                        .blueAccent.shade100,
                                                    fontSize: 20),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 60.0),
                                                child: ToggleButtons(
                                                  children: [
                                                    Selected == false?
                                                    Icon(Icons.favorite_outline_rounded,color: Colors.red,)
                                                        :Icon(Icons.favorite,color: Colors.red,),
                                                  ],
                                                  isSelected: Selected,
                                                  onPressed: (int index){
                                                    setState((){
                                                      Selected[index] = !Selected[index];
                                                      print(Selected[index]);
                                                    });
                                                  },
                                                )
                                              ),
                                            ],
                                          )
                                        ]),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        );
                      });
                } else {
                  return Text('Loading');
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Future<OrdersModel> getOrdersApi() async {
    final response = await http.get(Uri.parse(
        'https://62f4b229ac59075124c1e40b.mockapi.io/api/v1/orders/'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return OrdersModel.fromJson(data);
    } else {
      return OrdersModel.fromJson(data);
    }
  }

}
