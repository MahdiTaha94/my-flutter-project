import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'  as http;
import 'package:mahditestapp/model/order_model.dart';

import 'details_screen.dart';
import 'model/order_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  @override
  void initState(){
    super.initState();
  }

  Future<OrdersModel> getOrdersApi () async {
    final response = await http.get(
        Uri.parse('https://62f4b229ac59075124c1e40b.mockapi.io/api/v1/orders'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return OrdersModel.fromJson(data);
    } else {
      return OrdersModel.fromJson(data);
    }
  }

bool addToFav=false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Orders'),
        leading: Padding(
          padding: const EdgeInsets.only(left:300.0),
          child: Icon(Icons.favorite,color: Colors.red,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<OrdersModel>(
                future: getOrdersApi (),
                builder: (context , snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                        itemCount:snapshot.data?.data?.length,
                        itemBuilder: (context, index){
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                child: Stack(
                                  children:[

                                    Image.network(snapshot.data!.data![index].image.toString()),

                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left:20.0),
                                          child: Text(snapshot.data!.data![index].id.toString(),
                                            style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                   //     Text(snapshot.data!.data![index].address?.lat as String,style: TextStyle(color: Colors.white),),
                                        Padding(
                                          padding: const EdgeInsets.only(left:40.0),
                                          child: Text(snapshot.data!.data![index].created_at as String,
                                            style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                        ),
                                      ],
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(top:30.0),
                                      child: ListTile(
                                      title: Padding(
                                        padding: const EdgeInsets.only(left:30.0),
                                        child: Row(
                                          children: [
                                            Text(snapshot.data!.data![index].total.toString(),
                                              style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                            SizedBox(width: 5,),
                                            Text(snapshot.data!.data![index].currency.toString(),
                                              style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),

                                          ],
                                        ),
                                      ),
                                        leading:  Padding(
                                          padding: const EdgeInsets.only(top:150.0),
                                          child:
                                            addToFav==true?
                                            IconButton(
                                                icon: new Icon(Icons.favorite,color: Colors.red,size: 40,),
                                                onPressed: () {
                                                  setState((){
                                                    addToFav=!addToFav;
                                                  });

                                                }):  IconButton(

                                                icon: new Icon(Icons.favorite_outline_rounded,color: Colors.red,size: 40,),
                                                onPressed: () {
                                                  setState((){
                                                    addToFav=!addToFav;
                                                  });

                                                }),
                                          ),
                                        ),


                                  ),

                                   ]
                                ),

                                onTap:(){
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (_) => DetailsScreen(
                                    id:snapshot.data!.data?[index].id as String,
                                lng:snapshot.data!.data![index].address?.lng as String,
                                    lat: snapshot.data!.data![index].address?.lat as String,
                                  )));}

                              ),
                              Container(
                                height: MediaQuery.of(context).size.height *.1,
                                width: MediaQuery.of(context).size.width * 1,

                              ),
                            ],
                          );
                        });
                  }else {
                    return Text('Loading');
                  }
                },
              ),
            )
          ],
        ),
      ),
    );  }

}
