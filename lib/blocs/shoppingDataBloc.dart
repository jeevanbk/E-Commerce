
import 'dart:convert';
import 'dart:io';

import 'package:ecommerce/model/shopping_items_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ecommerce/repository/repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:localstorage/localstorage.dart';

class ShoppingDataBloc{
  final _repository = Repository();
  final _shoppingDataFetcher = PublishSubject<ShoppingItemsModel>();

  Stream<ShoppingItemsModel> get shoppingDataStream =>_shoppingDataFetcher.stream;
   LocalStorage storage = new LocalStorage('my_data.json');

  fetchShoppingList(int pageNumber,int pageCount) async{
    ShoppingItemsModel shopsList = await _repository.getShoppingData(pageNumber, pageCount);
    print("shopsList:${shopsList.status}");
    print("message:${shopsList.message}");
    print("message:${shopsList.totalPage}");


    _shoppingDataFetcher.sink.add(shopsList);
  }

  dispose(){
    _shoppingDataFetcher.close();
  }



  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();

    final path = directory.path;
    return File('$path/counter.txt');
  }

  Future<List<Data>> fetchAndSave(Data itemsData) async {
    var fetchedData = <Data>[];
    bool isExist = false;
    List<Data>? cartItems = [];
    await storage.ready;

    if(storage.getItem("cartItems") == null){
      itemsData.itemCount = 1;
      cartItems.add(itemsData);
      storage.setItem("cartItems", cartItems);
      print("cartItems${cartItems}");
      print("cartItems0");
    } else {
      cartItems = storage.getItem("cartItems");
      for(var i=0;i<cartItems!.length;i++){
        if(itemsData.id == cartItems[i].id){
          isExist = true;

          var len = cartItems[i].itemCount ?? 0;
          itemsData.itemCount = len + 1;
          cartItems[i] = itemsData;
          storage.setItem("cartItems", cartItems);

          print("cartItems3${cartItems[i].itemCount}");

        }
      }
      if(!isExist){
        cartItems.add(itemsData);
        print("cartItems1${cartItems}");
      }else{
        print("cartItems2${cartItems}");

      }
    }
    return storage.getItem("cartItems");
   }

  // Future<List<Data>> modifycartItems(int? indexId,int? cartQuantity) async{
  //   List<Data>? cartItems = [];
  //   cartItems = storage.getItem("cartItems");
  //
  //   if(cartItems != null){
  //     await storage.ready;
  //     for(var i=0;i<cartItems!.length;i++){
  //       if(indexId == cartItems[i].id){
  //
  //         var len = cartItems[i].itemCount ?? 0;
  //         cartItems[i].itemCount = len + cartQuantity!;
  //         if(cartItems[i].itemCount == 0){
  //           cartItems.removeAt(i);
  //         }
  //           storage.setItem("cartItems", cartItems);
  //         print("cartItems3${cartItems[i].itemCount}");
  //
  //       }
  //     }
  //   }
  //   return storage.getItem("cartItems");
  // }

}

final shoppingDataBloc = ShoppingDataBloc() ;