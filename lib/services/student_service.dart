import '../models/student.dart';

class StudentService {
  // Mock data based on your PHP system
  static List<Student> get mockStudents => [
    Student(
      id: 1,
      admissionNo: 'ADM001',
      fullName: 'JAMES MWANGI',
      dob: DateTime(2007, 5, 12),
      gender: 'M',
      studentClass: '1',
      parentName: 'Mr. Mwangi',
      parentPhone: '0712345678',
      religion: 'Christian',
      createdAt: DateTime.now(),
      className: 'Form 1',
    ),
    Student(
      id: 2,
      admissionNo: 'ADM002',
      fullName: 'MARY WANJIKU',
      dob: DateTime(2007, 8, 20),
      gender: 'F',
      studentClass: '1',
      parentName: 'Mrs. Wanjiku',
      parentPhone: '0723456789',
      religion: 'Christian',
      createdAt: DateTime.now(),
      className: 'Form 1',
    ),
    Student(
      id: 3,
      admissionNo: 'ADM003',
      fullName: 'JOHN KAMAU',
      dob: DateTime(2006, 3, 15),
      gender: 'M',
      studentClass: '2',
      parentName: 'Mr. Kamau',
      parentPhone: '0734567890',
      religion: 'Christian',
      createdAt: DateTime.now(),
      className: 'Form 2',
    ),
    Student(
      id: 4,
      admissionNo: 'ADM004',
      fullName: 'SOPHIE AKINYI',
      dob: DateTime(2007, 11, 5),
      gender: 'F',
      studentClass: '1',
      parentName: 'Mrs. Akinyi',
      parentPhone: '0745678901',
      religion: 'Christian',
      createdAt: DateTime.now(),
      className: 'Form 1',
    ),
  ];

  // Mock classes for dropdowns
  static List<Map<String, dynamic>> get mockClasses => [
    {'id': '1', 'name': 'Form 1'},
    {'id': '2', 'name': 'Form 2'},
    {'id': '3', 'name': 'Form 3'},
    {'id': '4', 'name': 'Form 4'},
  ];

  // Search students
  static List<Student> searchStudents(String query) {
    if (query.isEmpty) return mockStudents;
    
    return mockStudents.where((student) =>
      student.admissionNo.toLowerCase().contains(query.toLowerCase()) ||
      student.fullName.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  // Get students by class
  static List<Student> getStudentsByClass(String classId) {
    return mockStudents.where((student) => student.studentClass == classId).toList();
  }

  // Add new student
  static void addStudent(Student student) {
    // In real app, this would call API
    // For now, we'll just add to mock list
    mockStudents.add(student);
  }

  // Update student
  static void updateStudent(Student updatedStudent) {
    final index = mockStudents.indexWhere((s) => s.id == updatedStudent.id);
    if (index != -1) {
      mockStudents[index] = updatedStudent;
    }
  }

  // Delete student
  static void deleteStudent(int studentId) {
    mockStudents.removeWhere((s) => s.id == studentId);
  }

  // Delete multiple students
  static void deleteMultipleStudents(List<int> studentIds) {
    mockStudents.removeWhere((s) => studentIds.contains(s.id));
  }
}