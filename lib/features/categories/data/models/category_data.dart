class CategoryData {
  final int id;
  final String name;
  final String image;

  CategoryData({required this.id, required this.name, required this.image});

  factory CategoryData.fromJson(Map<String,dynamic> data) {
    return CategoryData(
      id: data['id'],
      name: data['name'],
      image: data['image'],
    );
  }
}
