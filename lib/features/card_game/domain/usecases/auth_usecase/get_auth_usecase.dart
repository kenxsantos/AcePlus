import '../../entities/user_entity.dart';
import '../../repositories/auth_repository.dart';

class GetAuthUsecase {
  final AuthRepository repository;

  GetAuthUsecase(this.repository);

  UserEntity? call(int id) {
    return repository.getAuth(id);
  }
}