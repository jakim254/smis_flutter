import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import '../../services/mock_data_service.dart';
import '../../models/dashboard_card.dart';
import '../admin/students/students_list.dart'; // ADD THIS IMPORT

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _currentDateTime = '';
  final user = MockDataService.mockUser;
  final school = MockDataService.mockSchoolInfo;

  @override
  void initState() {
    super.initState();
    _updateDateTime();
    // Update time every second
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateDateTime();
    });
  }

  void _updateDateTime() {
    final now = DateTime.now();
    final dateFormat = DateFormat('EEE, MMM d, y');
    final timeFormat = DateFormat('HH:mm:ss');
    setState(() {
      _currentDateTime = '${dateFormat.format(now)} - ${timeFormat.format(now)}';
    });
  }

  // Map Bootstrap icons to Flutter icons
  IconData _getFlutterIcon(String bootstrapIcon) {
    switch (bootstrapIcon) {
      case 'bi-bar-chart-line-fill':
        return Icons.bar_chart;
      case 'bi-building':
        return Icons.school;
      case 'bi-journal-text':
        return Icons.assignment;
      case 'bi-clipboard-data':
        return Icons.assessment;
      case 'bi-bar-chart-fill':
        return Icons.analytics;
      case 'bi-person-badge-fill':
        return Icons.people;
      case 'bi-book-fill':
        return Icons.menu_book;
      case 'bi-building-check':
        return Icons.business;
      case 'bi-shield-lock-fill':
        return Icons.admin_panel_settings;
      case 'bi-question-circle-fill':
        return Icons.help;
      case 'bi-search':
        return Icons.search;
      case 'bi-house-fill':
        return Icons.home;
      case 'bi-calendar-event-fill':
        return Icons.calendar_today;
      default:
        return Icons.dashboard;
    }
  }

  // ADD THIS METHOD: Handle navigation based on card title
  void _navigateToScreen(String title) {
    switch (title) {
      case 'Students':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentsListScreen(), // REMOVED const
          ),
        );
        break;
      case 'Teachers':
        // TODO: Navigate to Teachers screen
        break;
      case 'Classes':
        // TODO: Navigate to Classes screen
        break;
      case 'Results':
        // TODO: Navigate to Results screen
        break;
      case 'Analytics':
        // TODO: Navigate to Analytics screen
        break;
      case 'Reports':
        // TODO: Navigate to Reports screen
        break;
      // Add more cases as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf7f8fc),
      body: Column(
        children: [
          // Navbar - Matching your PHP design
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4b106e), Color(0xFFb71c1c), Color(0xFF10b981)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'SCHOOL MANAGEMENT INFORMATION SYSTEM - ${school['name']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Welcome, ${user['full_name']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        _currentDateTime,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.white),
                    onPressed: () {
                      // TODO: Implement logout
                    },
                  ),
                ],
              ),
            ),
          ),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Dashboard Header
                  const Text(
                    'School Dashboard',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Term Dates Button
                  Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Navigate to term dates
                      },
                      icon: const Icon(Icons.calendar_today),
                      label: const Text('Term Dates'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ).copyWith(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return const Color(0xFF16a34a); // Green color
                          },
                        ),
                      ),
                    ),
                  ),

                  // Dashboard Cards Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: MockDataService.dashboardCards.length,
                    itemBuilder: (context, index) {
                      final card = MockDataService.dashboardCards[index];
                      return _buildDashboardCard(card);
                    },
                  ),

                  // Kenya Flag Stripes
                  const SizedBox(height: 40),
                  _buildKenyaFlag(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(DashboardCard card) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFFFFF), Color(0xFFf4f1f8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            _navigateToScreen(card.title); // USE THE NEW NAVIGATION METHOD
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getFlutterIcon(card.icon),
                  size: 40,
                  color: const Color(0xFFa855f7), // Purple color from your PHP
                ),
                const SizedBox(height: 12),
                Text(
                  card.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    _navigateToScreen(card.title); // USE THE NEW NAVIGATION METHOD
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ).copyWith(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return const Color(0xFF16a34a); // Green color
                      },
                    ),
                  ),
                  child: Text(
                    card.buttonText,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKenyaFlag() {
    return Column(
      children: [
        Container(height: 2.4, color: Colors.black),
        Container(height: 2.4, color: Colors.white),
        Container(height: 2.4, color: Color(0xFFb91c1c)), // Red
        Container(height: 2.4, color: Colors.white),
        Container(height: 2.4, color: Color(0xFF16a34a)), // Green
      ],
    );
  }
}