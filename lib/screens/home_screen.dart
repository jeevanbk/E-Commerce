

import 'package:ecommerce/blocs/shoppingDataBloc.dart';
import 'package:ecommerce/model/shopping_items_model.dart';
import 'package:ecommerce/screens/my_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shoppingDataBloc.fetchShoppingList(1, 5);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(child: Text("Shopping Mall")),
        actions: [
           IconButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  MyCart()),
            );
          }, icon:Icon(Icons.shopping_cart_outlined),
    )
        ],
      ),
      body: StreamBuilder(
        stream: shoppingDataBloc.shoppingDataStream,
        builder: (BuildContext context, AsyncSnapshot<ShoppingItemsModel> snapshot) {
          if (snapshot.hasData) {
             return GridView.builder(
              itemCount: snapshot.data!.data!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // crossAxisCount: orientation == Orientation.portrait ? 2 : 3,

                  // crossAxisSpacing: 2.0,
                  // mainAxisSpacing: 2.0
              ),
              itemBuilder: (BuildContext context, int index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: new BoxDecoration(
                      border: new Border.all(color:Colors.white24),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(

                      children: [
                        Expanded(child: Image.network("${snapshot.data!.data?[index].featuredImage}",width: MediaQuery.of(context).size.width/2 - 50,height:  MediaQuery.of(context).size.width/2 - 50,),flex: 7,),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text("${snapshot.data!.data?[index].title}",
                                        maxLines: 3,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            backgroundColor: Colors.white,
                                            fontSize: 14)),
                            ),flex: 7,
                          ),
                          Expanded(child: IconButton(
                            onPressed: ()async{
                              snapshot.data!.data![index].itemCount =1;
                            List<Data> data = await shoppingDataBloc.fetchAndSave(snapshot.data!.data![index]);
                            print("data${data}");
                            }, icon:Icon(Icons.shopping_cart_rounded),
                          ),flex: 3,)
                        ],
                      ),
                      flex: 3,
                    ),
                      ],
                    ),
                  ),
                );
              },
            );
          //   ListView.builder(itemBuilder: (context, index) {
            //   print("snapshot${snapshot.data!.data?[index].title}");
            //
            //   return Card(
            //     color: Colors.white,
            //     child: ListTile(
            //       title: Text( "${snapshot.data!.data?[index].title}",
            //           style:
            //           TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            //       trailing: Text("${snapshot.data!.data?[index].description}",
            //           style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               color: Colors.red,
            //               fontSize: 18)),
            //     ),
            //   );
            // });
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
