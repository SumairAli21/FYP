import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/models/lesson_data_model.dart';
import 'package:englify_app/services/favourite_service.dart';
import 'package:englify_app/services/file_viewer_service.dart';
import 'package:englify_app/services/pints_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StdLessondetailViewmodel extends BaseViewModel {
  final _navigationservice = locator<NavigationService>();
  final _fileviewerservice = locator<FileViewerService>();
  final _favservice = locator<FavouriteService>();
  final _pointsseervice = locator<PointsService>();

  final LessonData lesson;
  final Map<String, dynamic> classroom;

  StdLessondetailViewmodel({required this.classroom, required this.lesson});

  String get classname => classroom['name'] ?? '';
  String get lessonNumberText =>
      'Lesson ${lesson.lessonNumber.toString().padLeft(2, '0')}';

  int? quizscore;
  final int totalpoints = 100;

  String get scoretext {
    if (quizscore == null) return '0/100';
    return '$quizscore/100';
  }

  bool get isQuizAttempted => quizscore != null;

  bool isFavourite = false;
  bool isTogglingFavourite = false;

  Future<void> init() async {
    setBusy(true);
    final results = await Future.wait([
      _pointsseervice.getquizpoints(lesson.id),
      _favservice.isfav(lesson.id),
    ]);
    quizscore = results[0] as int?;
    isFavourite = results[1] as bool;
    setBusy(false);
  }

  Future<void> toggleFavourite() async {
    if (isTogglingFavourite) return;

    // ✅ Optimistic update — pehle locally flip karo, UI turant respond kare
    isFavourite = !isFavourite;
    isTogglingFavourite = true;
    notifyListeners();

    final result = await _favservice.togglefavlesson(
      lessonid: lesson.id,
      lessontitle: lesson.title,
      classid: classroom['id'] ?? '',
      classname: classroom['name'] ?? '',
      lessonimageurl: lesson.imageUrl,
    );

    // ✅ Server result se confirm karo
    isFavourite = result;
    isTogglingFavourite = false;
    notifyListeners();
  }

  bool get isPdf => FileViewerService.isPdf(lesson.contentUrl);
  bool get isWord => FileViewerService.isWord(lesson.contentUrl);
  bool get isPpt => FileViewerService.isPpt(lesson.contentUrl);
  bool get isFileSupported => FileViewerService.isSupported(lesson.contentUrl);

  bool isDownloading = false;
  double downloadProgress = 0.0;
  String? errorMessage;

  String get fileName {
    if (lesson.contentUrl == null) return 'document';
    final segments = lesson.contentUrl!.split('/');
    final raw = segments.isNotEmpty ? segments.last : 'document';
    return Uri.decodeComponent(raw.split('?').first);
  }

  Future<void> openFile() async {
    if (lesson.contentUrl == null) return;
    if (isDownloading) return;

    isDownloading = true;
    downloadProgress = 0.0;
    errorMessage = null;
    notifyListeners();

    await _fileviewerservice.downloadAndOpen(
      fileUrl: lesson.contentUrl!.trim(),
      fileName: fileName,
      onProgress: (progress) {
        downloadProgress = progress;
        notifyListeners();
      },
      onError: (error) {
        errorMessage = error;
        isDownloading = false;
        notifyListeners();
      },
      onSuccess: () {
        isDownloading = false;
        notifyListeners();
      },
    );
  }

  void onAttemptQuiz() {
    _navigationservice.navigateToQuizAttemptView(
      classId: classroom['id'] ?? '',
      lessonId: lesson.id,
      lessonTitle: lesson.title,
    );
  }

  void onBack() => _navigationservice.back();
}
