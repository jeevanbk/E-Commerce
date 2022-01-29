
import 'dart:convert';
import 'dart:io';

import 'package:ecommerce/model/shopping_items_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ecommerce/repository/repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:localstorage/localstorage.dart';

class CartDataBloc{
  final _cartDataFetcher = PublishSubject<List<Data>>();

  Stream<List<Data>> get cartDataStream => _cartDataFetcher.stream;
  LocalStorage storage = new LocalStorage('my_data.json');

 fetchMyCart() async{
  List<Data> myCart = await storage.getItem("cartItems");
  _cartDataFetcher.sink.add(myCart);
}
  dispose(){
    _cartDataFetcher.close();
  }

  Future<List<Data>> modifycartItems(int? indexId,int? cartQuantity) async{
    List<Data>? cartItems = [];
    cartItems = storage.getItem("cartItems");

    if(cartItems != null){
      await storage.ready;
      for(var i=0;i<cartItems.length;i++){
        if(indexId == cartItems[i].id){

          var len = cartItems[i].itemCount ?? 0;
          cartItems[i].itemCount = len + cartQuantity!;
          if(cartItems[i].itemCount == 0){
            cartItems.removeAt(i);
          }
          storage.setItem("cartItems", cartItems);

        }
      }
    }
    _cartDataFetcher.sink.add(storage.getItem("cartItems"));

    return storage.getItem("cartItems");
  }

}

final cartDataBloc = CartDataBloc() ;