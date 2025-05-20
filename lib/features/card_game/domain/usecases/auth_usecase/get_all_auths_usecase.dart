import '../../entities/user_entity.dart';
import '../../repositories/auth_repository.dart';

class GetAllAuthsUsecase {
  final AuthRepository repository;

  GetAllAuthsUsecase(this.repository);

  List<UserEntity> call() {
    return repository.getAllAuths();
  }
}