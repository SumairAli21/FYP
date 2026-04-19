import 'package:flutter/material.dart';

class FileAttachmentCard extends StatelessWidget {
  final String fileUrl;
  final String? fileName;
  final bool isDownloading;
  final double progress;
  final VoidCallback onTap;

  const FileAttachmentCard({
    super.key,
    required this.fileUrl,
    required this.onTap,
    this.fileName,
    this.isDownloading = false,
    this.progress = 0.0,
  });

  String get _normalizedUrl => fileUrl.trim().toLowerCase();

  FileType get _fileType {
    if (_normalizedUrl.contains('.pdf')) return FileType.pdf;
    if (_normalizedUrl.contains('.doc') || _normalizedUrl.contains('.docx')) return FileType.word;
    if (_normalizedUrl.contains('.ppt') || _normalizedUrl.contains('.pptx')) return FileType.ppt;
    return FileType.unknown;
  }

  IconData get _fileIcon {
    switch (_fileType) {
      case FileType.pdf:   return Icons.picture_as_pdf;
      case FileType.word:  return Icons.description;
      case FileType.ppt:   return Icons.slideshow;
      default:             return Icons.insert_drive_file;
    }
  }

  Color get _fileColor {
    switch (_fileType) {
      case FileType.pdf:   return const Color(0xFFE53935);
      case FileType.word:  return const Color(0xFF1565C0);
      case FileType.ppt:   return const Color(0xFFE65100);
      default:             return const Color(0xFF546E7A);
    }
  }

  String get _fileLabel {
    switch (_fileType) {
      case FileType.pdf:   return 'PDF';
      case FileType.word:  return 'WORD';
      case FileType.ppt:   return 'PPT';
      default:             return 'FILE';
    }
  }

  String get _displayName {
    if (fileName != null && fileName!.isNotEmpty) return fileName!;
    final segments = fileUrl.split('/');
    final raw = segments.isNotEmpty ? segments.last : 'Document';
    return Uri.decodeComponent(raw.split('?').first);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDownloading ? null : onTap, // downloading ke waqt disable
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                // ── Left colored block (file type)
                Container(
                  width: 56,
                  height: 72,
                  decoration: BoxDecoration(
                    color: _fileColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(_fileIcon, color: Colors.white, size: 26),
                      const SizedBox(height: 4),
                      Text(
                        _fileLabel,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // ── File name + status
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _displayName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isDownloading
                              ? 'Downloading... ${(progress * 100).toStringAsFixed(0)}%'
                              : 'Tap to open',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDownloading ? _fileColor : Colors.grey[500],
                            fontWeight: isDownloading
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ── Right: progress indicator or chevron
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: isDownloading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 2.5,
                            color: _fileColor,
                            backgroundColor: Colors.grey[200],
                          ),
                        )
                      : Icon(
                          Icons.chevron_right,
                          color: Colors.grey[400],
                          size: 22,
                        ),
                ),
              ],
            ),

            // ── Bottom progress bar (sirf downloading ke waqt)
            if (isDownloading)
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[200],
                  color: _fileColor,
                  minHeight: 3,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

enum FileType { pdf, word, ppt, unknown }