class User {
  final String id;
  final String name;
  final String email;
  final String country;
  final String city;
  final String image;

  User({this.id, this.image, this.name, this.email, this.country, this.city});

  User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      image: json['image'] ??
          'https://www.pikpng.com/pngl/m/80-805523_default-avatar-svg-png-icon-free-download-264157.png',
      email: json['email'],
      country: json['country'],
      city: json['city'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "email": this.email,
      "name": this.name,
      "country": this.country,
      "city": this.city,
      "image": this.image,
    };
  }
}
