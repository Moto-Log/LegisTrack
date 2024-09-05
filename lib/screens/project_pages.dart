import 'package:flutter/material.dart';
import 'package:legistrack/models/project.dart';
import 'projects_screen.dart';

class ProjectPages extends StatefulWidget {
  @override
  _ProjectPagesState createState() => _ProjectPagesState();
}

class _ProjectPagesState extends State<ProjectPages> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [
        ProjectsScreen(), 
      ],
    );
  }
}