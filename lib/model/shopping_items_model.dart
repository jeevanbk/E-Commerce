class ShoppingItemsModel {
  int? status;
  String? message;
  int? totalRecord;
  //String? perPage;
  int? totalPage;
  List<Data>? data;

  ShoppingItemsModel(
      {this.status,
        this.message,
        this.totalRecord,
      //  this.perPage,
        this.totalPage,
        this.data});

  ShoppingItemsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalRecord = json['totalRecord'];
   // perPage = json['perPage'];
    totalPage = json['totalPage'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? slug;
  String? title;
  String? description;
  int? price;
  String? featuredImage;
  String? status;
  String? createdAt;
  int? itemCount = 1;

  Data(
      {this.id,
        this.slug,
        this.title,
        this.description,
        this.price,
        this.featuredImage,
        this.status,
        this.createdAt,
      this.itemCount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    featuredImage = json['featured_image'];
    status = json['status'];
    createdAt = json['created_at'];
    itemCount = json['itemCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['featured_image'] = this.featuredImage;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['itemCount'] = this.itemCount;
    return data;
  }
}