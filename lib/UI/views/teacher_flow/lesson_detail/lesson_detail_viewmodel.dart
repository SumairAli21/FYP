import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/models/lesson_data_model.dart';
import 'package:englify_app/services/file_viewer_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LessonDetailViewmodel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _fileViewerService = locator<FileViewerService>(); // ← locator se lo

  final LessonData lesson;
  final Map<String, dynamic> classroom;

  LessonDetailViewmodel({required this.lesson, required this.classroom});

  // ── Getters
  String get className => classroom['name'] ?? '';
  String get classCode => classroom['code'] ?? '';
  String get lessonNumberText =>
      'Lesson ${lesson.lessonNumber.toString().padLeft(2, '0')}';

  // ── File type getters (service use kar raha hai)
  bool get isPdf => FileViewerService.isPdf(lesson.contentUrl);
  bool get isWord => FileViewerService.isWord(lesson.contentUrl);
  bool get isPpt => FileViewerService.isPpt(lesson.contentUrl);
  bool get isFileSupported => FileViewerService.isSupported(lesson.contentUrl);

  // ── Download state
  bool isDownloading = false;
  double downloadProgress = 0.0;
  String? errorMessage;

  // ── File name getter
  String get fileName {
    if (lesson.contentUrl == null) return 'document';
    final segments = lesson.contentUrl!.split('/');
    final raw = segments.isNotEmpty ? segments.last : 'document';
    return Uri.decodeComponent(raw.split('?').first);
  }

  // ── Main open file function
  Future<void> openFile() async {
    if (lesson.contentUrl == null) return;
    if (isDownloading) return;

    isDownloading = true;
    downloadProgress = 0.0;
    errorMessage = null;
    notifyListeners();

    await _fileViewerService.downloadAndOpen(
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

  void onback() => _navigationService.back();

  void oncratequiz() {
    _navigationService.navigateTo(
      Routes.createQuizView,
      arguments: CreateQuizViewArguments(
        classid: classroom['id'] ?? '',
      lessonid: lesson.id ,
      lessontitle: lesson.title,
        )
    );
  }
}