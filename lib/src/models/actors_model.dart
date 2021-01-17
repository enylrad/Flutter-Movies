class Cast {
  List<Actor> actors = List();

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final actor = Actor.fromJsonMap(item);
      actors.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  getPhotoImage() {
    if (profilePath == null) {
      return 'https://farm5.staticflickr.com/4363/36346283311_74018f6e7d_o.png';
    } else {
      return 'https://www.themoviedb.org/t/p/w600_and_h900_bestv2$profilePath';
    }
  }
}
