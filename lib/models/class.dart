class SchoolClass {
  final int id;
  final String className;
  final String? classTeacher;
  final int? capacity;
  final String? stream;
  final DateTime createdAt;

  SchoolClass({
    required this.id,
    required this.className,
    this.classTeacher,
    this.capacity,
    this.stream,
    required this.createdAt,
  });

  factory SchoolClass.fromJson(Map<String, dynamic> json) {
    return SchoolClass(
      id: int.parse(json['id'].toString()),
      className: json['name'] ?? json['class_name'] ?? '',
      classTeacher: json['class_teacher'],
      capacity: json['capacity'] != null ? int.parse(json['capacity'].toString()) : null,
      stream: json['stream'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': className,
      'class_teacher': classTeacher,
      'capacity': capacity,
      'stream': stream,
      'created_at': createdAt.toIso8601String(),
    };
  }
}