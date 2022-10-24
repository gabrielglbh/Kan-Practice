abstract class IDatabaseRepository {
  Future<void> open();
  Future<void> close();
}
