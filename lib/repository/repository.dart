
import 'package:ecommerce/api_repo/shopping_api_repo.dart';
import 'package:ecommerce/model/shopping_items_model.dart';

class Repository{
ShoppingApiRepo shoppingApiRepo = ShoppingApiRepo();


 Future<ShoppingItemsModel>  getShoppingData(int pageNumber,int pageCount) => shoppingApiRepo.getLatestShoppingData(pageNumber,pageCount);


}