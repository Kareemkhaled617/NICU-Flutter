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
    email = json['Email'];
    name = json['Username'];
    phone = json['phone'];
    uId = json['ID'];
    isEmailVerified = json['isEmailVerified'];
    image = json['Image'];
    cover = json['cover'];
    bio = json['bio'];
  }

  Map<String, dynamic> toMap() {
    return {
      'Username': name,
      'Email': email,
      'phone': phone,
      'isEmailVerified': isEmailVerified,
      'Image': image,
      'cover': cover,
      'bio': bio,
      'ID': uId,
    };
  }
}
