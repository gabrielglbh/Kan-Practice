part of 'backup_bloc.dart';

@freezed
class BackupState with _$BackupState {
  const factory BackupState.loading() = BackupLoading;
  const factory BackupState.loaded(String message) = BackupLoaded;
  const factory BackupState.initial() = BackupInitial;
  const factory BackupState.error(String message) = BackupError;
  const factory BackupState.versionRetrieved(
    String version,
    List<String> notes,
  ) = BackupVersionRetrieved;
  const factory BackupState.notesRetrieved(
    List<String> notes,
  ) = BackupNotesRetrieved;
}
