import '../models/dashboard_card.dart';

class MockDataService {
  // Mock dashboard cards based on your PHP index.php
  static List<DashboardCard> get dashboardCards => [
    DashboardCard(
      icon: 'bi-bar-chart-line-fill',
      title: 'Brief Summary',
      route: '/brief-summary',
      buttonText: 'View Summary',
    ),
    DashboardCard(
      icon: 'bi-building',
      title: 'Classes',
      route: '/classes',
      buttonText: 'Manage Classes',
    ),
    DashboardCard(
      icon: 'bi-journal-text',
      title: 'Exams',
      route: '/exams',
      buttonText: 'Manage Exams',
    ),
    DashboardCard(
      icon: 'bi-clipboard-data',
      title: 'Results',
      route: '/results',
      buttonText: 'View Results',
    ),
    DashboardCard(
      icon: 'bi-bar-chart-fill',
      title: 'Analytics',
      route: '/analytics',
      buttonText: 'View Analytics',
    ),
    DashboardCard(
      icon: 'bi-person-badge-fill',
      title: 'Teachers',
      route: '/teachers',
      buttonText: 'Manage Teachers',
    ),
    DashboardCard(
      icon: 'bi-book-fill',
      title: 'Subjects',
      route: '/subjects',
      buttonText: 'Manage',
    ),
    DashboardCard(
      icon: 'bi-building-check',
      title: 'School Info',
      route: '/school-info',
      buttonText: 'Manage',
    ),
    DashboardCard(
      icon: 'bi-shield-lock-fill',
      title: 'Administrator',
      route: '/admin-panel',
      buttonText: 'Go to Panel',
    ),
    DashboardCard(
      icon: 'bi-question-circle-fill',
      title: 'Help',
      route: '/help',
      buttonText: 'Open Help',
    ),
    DashboardCard(
      icon: 'bi-search',
      title: 'Search Student',
      route: '/search-student',
      buttonText: 'Search',
    ),
  ];

  // Mock user data
  static Map<String, dynamic> get mockUser => {
    'id': 1,
    'username': 'admin',
    'full_name': 'System Administrator',
  };

  // Mock school info
  static Map<String, dynamic> get mockSchoolInfo => {
    'name': 'Kenya High School',
  };
}