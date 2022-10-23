import 'package:flutter/material.dart';

abstract class IBackupRepository {
  Future<String> getVersion();
  Future<List<String>> getVersionNotes(BuildContext context);
  Future<String> createBackUp();
  Future<String> restoreBackUp();
  Future<String> removeBackUp();
  Future<String> getLastUpdated(BuildContext context);
}
