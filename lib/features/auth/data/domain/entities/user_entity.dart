// This user entity will be ued to represent the user data regardless "بغض النظر" the service that will be used and this entity will holds the data of the user

class UserEntity {
  final String name;
  final String email;
  final String uId;

  UserEntity({
    required this.name,
    required this.email,
    required this.uId,
  });
}
