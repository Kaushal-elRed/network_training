class Album {
  int? id;
  String? title;

  Album({this.id, this.title});

  Album.empty();

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}
