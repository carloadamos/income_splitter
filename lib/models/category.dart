class Category {
  int categoryId;
  String categoryName;
  double categoryPercent;

  Category({this.categoryId, this.categoryName, this.categoryPercent});

  Map<String, dynamic> toMap() => {
        "name": categoryName,
        "percentage": categoryPercent,
      };

  factory Category.fromMap(Map<String, dynamic> json) => new Category(
    categoryId: json["id"],
    categoryName: json["name"],
    categoryPercent: double.parse(json["percentage"].toString()),
  );

}
