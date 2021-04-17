import 'dart:convert';

DetailArticle detailArticleFromJson(String response) {
  final jsonData = json.decode(response);
  final data = jsonData["data"];
  return DetailArticle.fromJson(data);
}

class DetailArticle {
  int id;
  String judul;
  var tags;
  String deskripsi;
  int user_id;
  String nama_user;
  String created_at;
  String cover;
  String avatar;
  String kontent;

  DetailArticle(
      {this.id,
      this.judul,
      this.tags,
      this.user_id,
      this.deskripsi,
      this.nama_user,
      this.cover,
      this.created_at,
      this.kontent,
      this.avatar});

  factory DetailArticle.fromJson(Map<String, dynamic> json) => DetailArticle(
        id: json["id"],
        judul: json["judul"],
        deskripsi: json["deskripsi"],
        nama_user: json["name"],
        user_id: json["user_id"],
        created_at: json["date"],
        tags: json["tags_array"],
        cover: json["cover"],
        avatar: json["avatar"],
        kontent: json["kontent"],
      );
}
