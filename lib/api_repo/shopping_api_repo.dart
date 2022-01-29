
import 'package:ecommerce/model/shopping_items_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ShoppingApiRepo {

  Future<ShoppingItemsModel> getLatestShoppingData(int pageNumber,int pageCount) async {

    Map<String, String> encodableData = {
      'page': "$pageNumber",
      "perPage-Type":"$pageCount",
    };


try {
      final response = await http.post(
          Uri.parse("http://205.134.254.135/~mobile/MtProject/api/v1/product_list"),
          headers: {"token":"eyJhdWQiOiI1IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz"},
        body:jsonEncode(encodableData),
      );
      print("${response.statusCode}");
      print("${response.body.isNotEmpty}");
      if (response.statusCode == 200 && response.body.isNotEmpty){
            print("response${response.statusCode}");

         return ShoppingItemsModel.fromJson(jsonDecode(response.body));
}
      else
        return ShoppingItemsModel();
    }  catch (e) {
      // CustomWidgets.getToast(
      //   message: 'Error : ${e.toString()}',
      //   color: Color(0xffF40909),
      // );

      print('Error :: ${e.toString()}');
    }
    return ShoppingItemsModel();
  }
}


