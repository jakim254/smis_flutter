import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/student.dart';

class StudentApiService {
  static const String baseUrl = 'http://10.0.2.2/smis/api'; // For Android emulator
  // static const String baseUrl = 'http://localhost/smis/api'; // For web

  // Get all students
  static Future<List<Student>> getStudents() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/students.php'));
      
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Student.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load students');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Get students by class
  static Future<List<Student>> getStudentsByClass(int classId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/students.php?class_id=$classId'));
      
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Student.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load students');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Add new student
  static Future<bool> addStudent(Student student) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/students.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(student.toJson()),
      );
      
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Update student
  static Future<bool> updateStudent(Student student) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/students.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(student.toJson()),
      );
      
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Delete student
  static Future<bool> deleteStudent(int studentId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/students.php?id=$studentId'),
      );
      
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}