class Category {
  int categoryId;
  String categoryName;
  double categoryPercent;

  Category({this.categoryId, this.categoryName, this.categoryPercent});

  Map<String, dynamic> toMap() => {
        "id": categoryId,
        "name": categoryName,
        "percentage": categoryPercent,
      };
}
