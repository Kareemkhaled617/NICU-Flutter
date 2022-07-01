class UserCreateModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isEmailVerified;
  String? image;
  String? cover;
  String? bio;

  UserCreateModel(
      {this.email,
      this.name,
      this.phone,
      this.uId,
      this.isEmailVerified,
      this.image,
      this.bio,
      this.cover});

  UserCreateModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'isEmailVerified': isEmailVerified,
      'image': image,
      'cover': cover,
      'bio': bio,
      'uId': uId,
    };
  }
}
