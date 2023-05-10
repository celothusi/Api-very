class DrawerOptionModel {
  DrawerOptionModel({
    this.drawerName,
    this.drawerImage,
  });

  String? drawerName;
  String? drawerImage;

  factory DrawerOptionModel.fromJson(Map<String, dynamic> json) =>
      DrawerOptionModel(
        drawerName: json["drawerName"],
        drawerImage: json["drawerImage"],
      );

  Map<String, dynamic> toJson() => {
        "drawerName": drawerName,
        "drawerImage": drawerImage,
      };
}
