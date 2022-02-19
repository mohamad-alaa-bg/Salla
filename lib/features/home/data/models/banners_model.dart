class BannerModel {
  int id;
  String image;

  BannerModel({required this.id, required this.image});

  factory BannerModel.fromJson({required banner}) {
    return BannerModel(
      id: banner['id'],
      image: banner['image'],
    );
  }
}
