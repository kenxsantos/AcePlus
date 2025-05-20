import '../../entities/user_entity.dart';
import '../../repositories/auth_repository.dart';

class AddAuthUsecase {
  final AuthRepository repository;

  AddAuthUsecase(this.repository);

  Future<int?> call(UserEntity userEntity) async {
    return await repository.addAuth(userEntity);
  }
}