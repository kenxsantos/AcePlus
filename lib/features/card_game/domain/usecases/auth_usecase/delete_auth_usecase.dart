import '../../repositories/auth_repository.dart';

class DeleteAuthUsecase {
  final AuthRepository repository;

  DeleteAuthUsecase(this.repository);

  Future<void> call(int id) async {
    return await repository.deleteAuth(id);
  }
}