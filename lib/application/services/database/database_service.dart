import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/services/i_database_repository.dart';

@injectable
class DatabaseService {
  final IDatabaseRepository _databaseRepository;

  DatabaseService(this._databaseRepository);

  Future<void> close() async {
    await _databaseRepository.close();
  }

  Future<void> open() async {
    await _databaseRepository.open();
  }
}
