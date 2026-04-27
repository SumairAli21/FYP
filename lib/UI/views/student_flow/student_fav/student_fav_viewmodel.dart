import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/models/lesson_data_model.dart';
import 'package:englify_app/services/favourite_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StudentFavViewmodel  extends BaseViewModel{
   final _navigationService = locator<NavigationService>();
  final _favService = locator<FavouriteService>();

  List<Map<String, dynamic>> allFavourites = [];
  List<Map<String, dynamic>> filteredFavourites = [];

  final searchController = TextEditingController();

  Future<void> init() async {
    setBusy(true);
    try {
      allFavourites = await _favService.getfav();
      filteredFavourites = List.from(allFavourites);
    } catch (e) {
      print('Failed to load favourites: $e');
    }
    setBusy(false);
  }

  void onSearchChange(String value) {
    if (value.trim().isEmpty) {
      filteredFavourites = List.from(allFavourites);
    } else {
      filteredFavourites = allFavourites
          .where((fav) => (fav['lessonTitle'] as String)
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void onFavTap(Map<String, dynamic> fav) {
  final lesson = LessonData(
    id: fav['lessonId'] ?? '',
    classId: fav['classId'] ?? '',        
    title: fav['lessonTitle'] ?? '',
    description: '',
    imageUrl: fav['imageUrl'],
    contentUrl: null,
    teacherId: '',                         
    lessonNumber: 0,
  );

  final classroom = {
    'id': fav['classId'] ?? '',
    'name': fav['className'] ?? '',
  };

  _navigationService.navigateToStdSelectLessonView(
    lesson: lesson,
    classroom: classroom,
  );
}

  void onBack() => _navigationService.back();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}