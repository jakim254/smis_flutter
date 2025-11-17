class Student {
  final int id;
  final String admissionNo;
  final String fullName;
  final DateTime? dob;
  final String gender;
  final String studentClass;
  final String? parentName;
  final String? parentPhone;
  final String? studentPic;
  final String? religion;
  final DateTime createdAt;
  final String? className; // For display

  Student({
    required this.id,
    required this.admissionNo,
    required this.fullName,
    this.dob,
    required this.gender,
    required this.studentClass,
    this.parentName,
    this.parentPhone,
    this.studentPic,
    this.religion,
    required this.createdAt,
    this.className,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: int.parse(json['id'].toString()),
      admissionNo: json['admission_no'] ?? '',
      fullName: json['full_name'] ?? '',
      dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
      gender: json['gender'] ?? 'M',
      studentClass: json['class']?.toString() ?? '',
      parentName: json['parent_name'],
      parentPhone: json['parent_phone'],
      studentPic: json['student_pic'],
      religion: json['religion'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
      className: json['class_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'admission_no': admissionNo,
      'full_name': fullName,
      'dob': dob?.toIso8601String().split('T')[0],
      'gender': gender,
      'class': studentClass,
      'parent_name': parentName,
      'parent_phone': parentPhone,
      'student_pic': studentPic,
      'religion': religion,
      'created_at': createdAt.toIso8601String(),
    };
  }

  String get displayGender {
    return gender == 'M' ? 'Male' : (gender == 'F' ? 'Female' : '');
  }

  String get displayDob {
    return dob != null ? 
      '${dob!.day}/${dob!.month}/${dob!.year}' : 'Not set';
  }
}