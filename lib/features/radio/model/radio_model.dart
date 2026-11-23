class RadioModel {
  final int id;
  final String name;
  final String uri;

  const RadioModel({required this.id,required this.name,required this.uri});

  factory RadioModel.fromJson(Map<String, dynamic> json) {
    return RadioModel(
     id: json['id'] as int,
     name : json['name'] as String,
     uri: json['url'] as String,
    );
  }
}
