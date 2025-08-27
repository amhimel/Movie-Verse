class MovieGenres {
  final int id;
  final String name;

  MovieGenres({required this.id, required this.name});

  factory MovieGenres.fromJson(Map<String, dynamic> json) {
    return MovieGenres(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'name' : name
    };
  }

  @override
  String toString() {
    return "MovieGenres(id: $id, name: $name)";
  }
}