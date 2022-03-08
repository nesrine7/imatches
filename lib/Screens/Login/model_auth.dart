class Club{
  String? title;
  Club({this.title});
  factory Club.fromJson(Map<String,dynamic> json){
    return Club(
      title: json['title']
    );
  }
}