class ProductModel {
  ProductModel({
    this.id = 0,
    this.title = '',
    this.description = '',
    this.price = 0,
    this.discountPercentage = 0,
    this.rating = 0.0,
    this.stock = 0,
    this.brand = '',
    this.category = '',
    this.thumbnail = '',
    this.images,
    this.isInCart = false,
    this.qty = 0.0,
  });

  int id;
  String title;
  String description;
  int price;
  double discountPercentage;
  double rating;
  int stock;
  String brand;
  String category;
  String thumbnail;
  bool isInCart;
  double qty;
  List<String>? images;

  ProductModel copyWith({
    int? id,
    String? title,
    String? description,
    int? price,
    double? discountPercentage,
    double? rating,
    int? stock,
    String? brand,
    String? category,
    String? thumbnail,
    List<String>? images,
    bool? isInCart,
  }) =>
      ProductModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        price: price ?? this.price,
        discountPercentage: discountPercentage ?? this.discountPercentage,
        rating: rating ?? this.rating,
        stock: stock ?? this.stock,
        brand: brand ?? this.brand,
        category: category ?? this.category,
        thumbnail: thumbnail ?? this.thumbnail,
        images: images ?? this.images,
        isInCart: isInCart ?? this.isInCart,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"] == null ? 0 : json["id"],
        title: json["title"] == null ? '' : json["title"],
        description: json["description"] == null ? '' : json["description"],
        price: json["price"] == null ? 0.0 : json["price"],
        discountPercentage: json["discountPercentage"] == null
            ? 0.0
            : json["discountPercentage"].toDouble(),
        rating: json["rating"] == null ? 0.0 : json["rating"].toDouble(),
        stock: json["stock"] == null ? 0 : json["stock"],
        brand: json["brand"] == null ? '' : json["brand"],
        category: json["category"] == null ? '' : json["category"],
        thumbnail: json["thumbnail"] == null ? '' : json["thumbnail"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "price": price == null ? null : price,
        "discountPercentage":
            discountPercentage == null ? null : discountPercentage,
        "rating": rating == null ? null : rating,
        "stock": stock == null ? null : stock,
        "brand": brand == null ? null : brand,
        "category": category == null ? null : category,
        "thumbnail": thumbnail == null ? null : thumbnail,
        "images":
            images == null ? null : List<dynamic>.from(images!.map((x) => x)),
        "isInCart": isInCart == null ? null : isInCart
      };
}
