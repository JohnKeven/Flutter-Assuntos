// ignore_for_file: file_names
class Post {
  int userId;
  int? id;
  String title;
  String body;

  Post(this.userId, this.id, this.title, this.body);

  Map toJson() {
    return {
      "userId": userId,
      "id": id,
      "title": title,
      "body": body,
    };
  }
}
