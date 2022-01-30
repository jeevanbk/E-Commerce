import 'dart:developer';

import 'package:ecommerce/blocs/shoppingDataBloc.dart';
import 'package:ecommerce/model/shopping_items_model.dart';
import 'package:ecommerce/screens/my_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  int pageCount = 0;
  int pageSize = 10;
  List<Data> dummyData = [];
  int currentLength = 0;
  ShoppingItemsModel shoppingItemsModel = new ShoppingItemsModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // shoppingDataBloc.fetchShoppingList(1, 5);
    _loadMore();
  }

  void _loadMore() async {
    setState(() {
      isLoading = true;
    });
    pageCount += 1;

    shoppingItemsModel =
        await shoppingDataBloc.fetchShoppingList(pageCount, pageSize);
    for (var i = currentLength;
        i <= shoppingItemsModel.data!.length ;
        i++) {
      if (shoppingItemsModel != null &&
          shoppingItemsModel.data != null &&
          shoppingItemsModel.data!.length > 0) {
        setState(() {
          log("tatalpage${shoppingItemsModel.totalPage}");
          if (pageCount <= shoppingItemsModel.totalPage!) {
            // dummyData=   List.generate(pageSize, (index) => shoppingItemsModel.data![index]);
            dummyData.addAll(shoppingItemsModel.data!);
            dummyData = dummyData.toSet().toList();
            //    log("${dummyData[i].id}");
          } else {
            log("Maximum");
          }
        });
      } else {
        pageCount -= 1;
      }
    }
    setState(() {
      isLoading = false;
      currentLength = shoppingItemsModel.data!.length;
    });
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyCart()),
              );
            },
            icon: Icon(Icons.shopping_cart_outlined),
          )
        ],
      ),
      body: StreamBuilder(
        stream: shoppingDataBloc.shoppingDataStream,
        builder:
            (BuildContext context, AsyncSnapshot<ShoppingItemsModel> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data != null
                ? LazyLoadScrollView(
                    isLoading: isLoading,
                    onEndOfPage: () => _loadMore(),
                    child: CustomScrollView(
                      semanticChildCount: 4,
                      slivers: <Widget>[
                        SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200.0,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 1.0,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Container(
                                decoration: new BoxDecoration(
                                  border: new Border.all(color: Colors.white24),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "${dummyData[index].featuredImage}",
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                50,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                50,
                                        placeholder: (context, url) => Center(
                                          child: Image.asset(
                                            'assets/images/loader.gif',
                                            fit: BoxFit.fill,
                                            height: 25,
                                            width: 25,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                      flex: 7,
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Text(
                                                  "${dummyData[index].title}",
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                      backgroundColor:
                                                          Colors.white,
                                                      fontSize: 14)),
                                            ),
                                            flex: 7,
                                          ),
                                          Expanded(
                                            child: IconButton(
                                              onPressed: () async {
                                                List<Data> data =
                                                    await shoppingDataBloc
                                                        .fetchAndSave(
                                                            dummyData[index]);
                                                print("data${data}");
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Item added to cart"),
                                                ));
                                              },
                                              icon: Icon(
                                                  Icons.shopping_cart_rounded),
                                            ),
                                            flex: 3,
                                          )
                                        ],
                                      ),
                                      flex: 3,
                                    ),
                                  ],
                                ),
                              );
                            },
                            childCount:
                                dummyData != null && dummyData.isNotEmpty
                                    ? dummyData.length
                                    : 0,
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return pageCount > shoppingItemsModel.totalPage!
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 18.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/loader.gif',
                                            fit: BoxFit.fitHeight,
                                            height: 30,
                                            width: 30,
                                          ),
                                          Text(
                                            " Loading...",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue),
                                          )
                                        ],
                                      ),
                                    );
                            },
                            childCount: 1,
                          ),
                        )
                      ],
                    ),
                  )
                : Container();
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(
            child: Image.asset(
              'assets/images/loader.gif',
              fit: BoxFit.fill,
              height: 35,
              width: 35,
            ),
          );
        },
      ),
    );
  }
}
