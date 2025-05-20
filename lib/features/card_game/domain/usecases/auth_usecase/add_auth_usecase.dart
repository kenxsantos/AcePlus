import '../../entities/user_entity.dart';
import '../../repositories/auth_repository.dart';

class AddAuthUseecase {
  final AuthRepository repository;

  AddAuthUseecase(this.repository);

  Future<int?> call(UserEntity userEntity) async {
    return await repository.addAuth(userEntity);
  }
}