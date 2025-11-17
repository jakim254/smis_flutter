class Subject {
  final int id;
  final String code;
  final String name;

  Subject({
    required this.id,
    required this.code,
    required this.name,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: int.parse(json['id'].toString()),
      code: json['code'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
    };
  }
}