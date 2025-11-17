import 'package:flutter/material.dart';
import '../../../models/student.dart';
import '../../../services/student_service.dart';

class StudentsListScreen extends StatefulWidget {
  final String? classId;

  const StudentsListScreen({super.key, this.classId});

  @override
  State<StudentsListScreen> createState() => _StudentsListScreenState();
}

class _StudentsListScreenState extends State<StudentsListScreen> {
  List<Student> students = [];
  List<int> selectedStudentIds = [];
  bool selectAll = false;

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  void _loadStudents() {
    if (widget.classId != null) {
      students = StudentService.getStudentsByClass(widget.classId!);
    } else {
      students = StudentService.mockStudents;
    }
    setState(() {});
  }

  void _toggleStudentSelection(int studentId) {
    setState(() {
      if (selectedStudentIds.contains(studentId)) {
        selectedStudentIds.remove(studentId);
      } else {
        selectedStudentIds.add(studentId);
      }
    });
  }

  void _toggleSelectAll(bool? value) {
    setState(() {
      selectAll = value ?? false;
      if (selectAll) {
        selectedStudentIds = students.map((s) => s.id).toList();
      } else {
        selectedStudentIds.clear();
      }
    });
  }

  void _deleteSelectedStudents() {
    if (selectedStudentIds.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 8),
            Text('Confirm Delete'),
          ],
        ),
        backgroundColor: Colors.white,
        content: Text(
          'Are you sure you want to delete ${selectedStudentIds.length} selected student(s)? This cannot be undone.',
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              StudentService.deleteMultipleStudents(selectedStudentIds);
              _loadStudents();
              selectedStudentIds.clear();
              selectAll = false;
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${selectedStudentIds.length} student(s) deleted successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Yes, Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final className = widget.classId != null ? 
      StudentService.mockClasses.firstWhere(
        (c) => c['id'] == widget.classId,
        orElse: () => {'name': 'Unknown'}
      )['name'] : null;

    return Scaffold(
      backgroundColor: const Color(0xFFf8f9fa),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header with navigation buttons
            _buildHeader(className),
            
            const SizedBox(height: 20),
            
            // Page title
            _buildTitle(className),
            
            const SizedBox(height: 16),
            
            // Export buttons
            _buildExportButtons(),
            
            const SizedBox(height: 16),
            
            // Students table
            Expanded(
              child: _buildStudentsTable(),
            ),
            
            // Delete selected button and total count
            _buildFooter(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to add student
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildHeader(String? className) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // Back to Dashboard button
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1a1a1a), Color(0xFF28a745)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.home),
                label: const Text('Back to Dashboard'),
              ),
            ),
            
            const SizedBox(width: 8),
            
            // Go to Classes button
            if (className == null)
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B0000), Color(0xFFFF4500)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () {
                    // TODO: Navigate to classes
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Go to Classes'),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildTitle(String? className) {
    String title = "Students List";
    if (className != null) {
      title = "Students List in Form $className";
    }
    
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildExportButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            // TODO: Export PDF
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: const Text('Download PDF'),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            // TODO: Export Excel
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          child: const Text('Download Excel'),
        ),
      ],
    );
  }

  Widget _buildStudentsTable() {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          // Table header
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  // Checkbox
                  SizedBox(
                    width: 40,
                    child: Checkbox(
                      value: selectAll,
                      onChanged: _toggleSelectAll,
                      fillColor: MaterialStateProperty.all(Colors.white),
                    ),
                  ),
                  
                  // Header cells
                  Expanded(
                    flex: 2,
                    child: _buildHeaderCell('Photo'),
                  ),
                  Expanded(
                    flex: 3,
                    child: _buildHeaderCell('Admission No'),
                  ),
                  Expanded(
                    flex: 4,
                    child: _buildHeaderCell('Full Name'),
                  ),
                  Expanded(
                    flex: 3,
                    child: _buildHeaderCell('Class'),
                  ),
                  Expanded(
                    flex: 2,
                    child: _buildHeaderCell('DOB'),
                  ),
                  Expanded(
                    flex: 2,
                    child: _buildHeaderCell('Gender'),
                  ),
                  Expanded(
                    flex: 2,
                    child: _buildHeaderCell('Religion'),
                  ),
                  Expanded(
                    flex: 3,
                    child: _buildHeaderCell('Parent Phone'),
                  ),
                  Expanded(
                    flex: 4,
                    child: _buildHeaderCell('Actions'),
                  ),
                ],
              ),
            ),
          ),
          
          // Table body
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return _buildStudentRow(student);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildStudentRow(Student student) {
    final isSelected = selectedStudentIds.contains(student.id);
    
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
        color: isSelected ? Colors.blue[50] : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Checkbox
            SizedBox(
              width: 40,
              child: Checkbox(
                value: isSelected,
                onChanged: (value) => _toggleStudentSelection(student.id),
              ),
            ),
            
            // Photo
            Expanded(
              flex: 2,
              child: CircleAvatar(
                radius: 25,
                backgroundImage: student.studentPic != null 
                  ? NetworkImage('http://localhost/smis/assets/uploads/${student.studentPic}')
                  : const AssetImage('assets/images/placeholder.png') as ImageProvider,
                child: student.studentPic == null 
                  ? const Icon(Icons.person, size: 25)
                  : null,
              ),
            ),
            
            // Admission No
            Expanded(
              flex: 3,
              child: Text(
                student.admissionNo,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            
            // Full Name
            Expanded(
              flex: 4,
              child: Text(
                student.fullName.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            
            // Class
            Expanded(
              flex: 3,
              child: Text(
                student.className ?? 'Unknown',
                textAlign: TextAlign.center,
              ),
            ),
            
            // DOB
            Expanded(
              flex: 2,
              child: Text(
                student.displayDob,
                textAlign: TextAlign.center,
              ),
            ),
            
            // Gender
            Expanded(
              flex: 2,
              child: Text(
                student.displayGender,
                textAlign: TextAlign.center,
              ),
            ),
            
            // Religion
            Expanded(
              flex: 2,
              child: Text(
                student.religion ?? 'Not set',
                textAlign: TextAlign.center,
              ),
            ),
            
            // Parent Phone
            Expanded(
              flex: 3,
              child: Text(
                student.parentPhone ?? 'Not set',
                textAlign: TextAlign.center,
              ),
            ),
            
            // Actions
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Edit button
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Navigate to edit student
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    ),
                    child: const Text('Edit'),
                  ),
                  
                  const SizedBox(width: 4),
                  
                  // View button
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Navigate to student view
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    ),
                    child: const Text('View'),
                  ),
                  
                  const SizedBox(width: 4),
                  
                  // Delete button
                  ElevatedButton(
                    onPressed: () {
                      _showDeleteConfirmation(student);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    ),
                    child: const Text('Delete'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(Student student) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: Text('Are you sure you want to delete ${student.fullName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              StudentService.deleteStudent(student.id);
              _loadStudents();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Student deleted successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        // Delete Selected Button
        if (selectedStudentIds.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: _deleteSelectedStudents,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: Text('Delete Selected (${selectedStudentIds.length})'),
            ),
          ),
        
        // Total Students Count
        Container(
          padding: const EdgeInsets.all(16),
          child: Chip(
            label: Text(
              'Total Students: ${students.length}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          ),
        ),
      ],
    );
  }
}