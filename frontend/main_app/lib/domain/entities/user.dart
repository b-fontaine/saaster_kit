sealed class UserEntity {}

class AnonymousEntity extends UserEntity {}

class AuthenticatedEntity extends UserEntity {
  final String email;
  final String name;

  AuthenticatedEntity({
    required this.email,
    required this.name,
  });
}
