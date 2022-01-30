import 'package:ecommerce/blocs/cartDataBloc.dart';
import 'package:ecommerce/model/shopping_items_model.dart';
import 'package:ecommerce/blocs/shoppingDataBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  List<Data>? cartItems = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartDataBloc.fetchMyCart();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("called");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(child: Text("Shopping Mall")),
      ),
      body: StreamBuilder(
        stream: cartDataBloc.cartDataStream,
        builder: (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
          return snapshot.data?.length!=null? Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 1.26,
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:snapshot.data?.length!=null? snapshot.data?.length:1,
                          itemBuilder: (context, index) {
                            // print("########${ snapshot.data!.data!.length}");
                            var dataList = snapshot.data?[index];
                            return Container(
                              margin: EdgeInsets.only(
                                left: 14,
                                right: 14,
                                top: 10,
                              ),
                              padding: EdgeInsets.only(
                                  left: 14, right: 14, top: 14, bottom: 14),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xffE6E6E6)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Image.network(
                                        "${dataList!.featuredImage}",
                                        height: 100,
                                        width: 100,
                                      ),
                                      flex: 3),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "${dataList.title}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Price",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              "${dataList.price}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Quantity",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            ),
                                            dataList.itemCount != null
                                                ? Row(
                                                    children: [
                                                      Container(
                                                        height: 25,
                                                        width: 30,
                                                        child: OutlinedButton(
                                                          onPressed: () async {
                                                            await cartDataBloc
                                                                .modifycartItems(
                                                                    dataList
                                                                        .id,
                                                                    -1);
                                                          },
                                                          child: Text(
                                                            "-",
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        122,
                                                                        176,
                                                                        42,
                                                                        1)),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          style: ButtonStyle(
                                                            side: MaterialStateProperty
                                                                .all<
                                                                    BorderSide>(
                                                              BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          122,
                                                                          176,
                                                                          42,
                                                                          1)),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      new Text(
                                                        '${dataList.itemCount}',
                                                        style: TextStyle(
                                                          fontFamily: "Nunito",
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Container(
                                                        height: 25,
                                                        width: 30,
                                                        child: OutlinedButton(
                                                          onPressed: () async {
                                                            await cartDataBloc
                                                                .modifycartItems(
                                                                    dataList
                                                                        .id,
                                                                    1);
                                                          },
                                                          child: Text(
                                                            "+",
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        122,
                                                                        176,
                                                                        42,
                                                                        1)),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          style: ButtonStyle(
                                                            side: MaterialStateProperty
                                                                .all<
                                                                    BorderSide>(
                                                              BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          122,
                                                                          176,
                                                                          42,
                                                                          1)),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ],
                                    ),
                                    flex: 7,
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: 5),Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: double.infinity,
                      margin: EdgeInsets.only(right: 12, left: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(7),
                        ),
                        color: Color(0xff7AB02A),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Total Items :',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.black),
                            ),

                            Spacer(),
                            Text(
                              'Grand Total :',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.black),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ):Container();

          //   Column(
          //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text(
          //           "Total Items : ${snapshot.data?.length}",
          //           style: TextStyle(
          //               fontWeight: FontWeight.w500,
          //               fontSize: 15,
          //               color:Colors.black),
          //         ),
          //         Text(
          //           "Grand Total : ${snapshot.data?.length}",
          //           style: TextStyle(
          //               fontWeight: FontWeight.w500,
          //               fontSize: 15,
          //               color:Colors.black),
          //         ),
          //       ],
          //     ),
          //    ]
          // );
        },
      ),
    );
  }
}
