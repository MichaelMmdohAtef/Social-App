class RegisterModel{
  String? name;
  String? email;
  String? phone;
  String? uid;
  String? image;
  String? cover;
  String? bio;
  bool? isVerificationEmail;

  RegisterModel(
      this.name,
      this.email,
      this.phone,
      this.uid,
      this.image,
      this.cover,
      this.bio,
      this.isVerificationEmail
      );

  RegisterModel.fromjson(Map<String,dynamic> json){
    this.name=json['name'];
    this.email=json['email'];
    this.phone=json['phone'];
    this.uid=json['uid'];
    this.image=json['image'];
    this.cover=json['cover'];
    this.bio=json['bio'];
    this.isVerificationEmail=json['verification_email'];
  }

  Map<String,dynamic> toMap(){
    return {
      "name":this.name,
      "email":this.email,
      "phone":this.phone,
      "uid":this.uid,
      "image":this.image,
      "cover":this.cover,
      "bio":this.bio,
      "verification_email":this.isVerificationEmail
    };
  }
}