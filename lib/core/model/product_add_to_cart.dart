class ProductAddToCart {
  ProductAddToCart({
    this.id = 0,
    this.quantity = 0,
  });

  int id;
  int quantity;

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "quantity": quantity == null ? null : quantity,
      };
}
