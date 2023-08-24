class PostModel {
  String? name;
  String? image;
  String? uid;
  String? date;
  String? tags;
  String? textPost;
  String? postImage;

  PostModel({
    this.name,
    this.image,
    this.uid,
    this.date,
    this.tags,
    this.textPost,
    this.postImage,
  });

  PostModel.fromjson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.image = json['image'];
    this.uid = json['uid'];
    this.date = json['date'];
    this.tags = json['tags'];
    this.textPost = json['Text_Post'];
    this.postImage = json['Post_Image'];

  }

  Map<String, dynamic> toMap() {
    return {
      "name": this.name,
      "image": this.image,
      "uid": this.uid,
      'date':this.date,
      'tags':this.tags,
      "Text_Post": this.textPost,
      "Post_Image": this.postImage,
    };
  }
}
