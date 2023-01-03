import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';

/// TODO When adding a new study mode, be sure to update [TestHistoryFilters] too
enum StudyModes { writing, reading, recognition, listening, speaking }

extension StudyModesExt on StudyModes {
  String get mode {
    switch (this) {
      case StudyModes.writing:
        return "study_modes_writing".tr();
      case StudyModes.reading:
        return "study_modes_reading".tr();
      case StudyModes.recognition:
        return "study_modes_recognition".tr();
      case StudyModes.listening:
        return "study_modes_listening".tr();
      case StudyModes.speaking:
        return "study_modes_speaking".tr();
    }
  }

  IconData get icon {
    switch (this) {
      case StudyModes.writing:
        return Icons.edit_note_outlined;
      case StudyModes.reading:
        return Icons.chrome_reader_mode_outlined;
      case StudyModes.recognition:
        return Icons.find_in_page_rounded;
      case StudyModes.listening:
        return Icons.volume_up_rounded;
      case StudyModes.speaking:
        return Icons.spatial_audio_off_rounded;
    }
  }

  String get japMode {
    switch (this) {
      case StudyModes.writing:
        return "study_modes_writing_ext".tr();
      case StudyModes.reading:
        return "study_modes_reading_ext".tr();
      case StudyModes.recognition:
        return "study_modes_recognition_ext".tr();
      case StudyModes.listening:
        return "study_modes_listening_ext".tr();
      case StudyModes.speaking:
        return "study_modes_speaking_ext".tr();
    }
  }

  Color get color {
    switch (this) {
      case StudyModes.writing:
        return Colors.blue.shade300;
      case StudyModes.reading:
        return Colors.purple.shade300;
      case StudyModes.recognition:
        return Colors.orange.shade300;
      case StudyModes.listening:
        return Colors.green.shade300;
      case StudyModes.speaking:
        return Colors.red.shade200;
    }
  }

  String get page {
    switch (this) {
      case StudyModes.writing:
        return KanPracticePages.writingStudyPage;
      case StudyModes.reading:
        return KanPracticePages.readingStudyPage;
      case StudyModes.recognition:
        return KanPracticePages.recognitionStudyPage;
      case StudyModes.listening:
        return KanPracticePages.listeningStudyPage;
      case StudyModes.speaking:
        return KanPracticePages.speakingStudyPage;
    }
  }
}
