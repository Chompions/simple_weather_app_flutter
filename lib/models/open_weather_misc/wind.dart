class Wind {
  Wind({
    this.speed,
    this.deg,
    this.gust,
  });

  num? speed;
  int? deg;
  num? gust;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"],
        deg: json["deg"],
        gust: json["gust"],
      );
}
