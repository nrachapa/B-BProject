class SampleUser {
  final String firstName;
  final String lastName;
  final int age;

  const SampleUser({
    required this.firstName,
    required this.lastName,
    required this.age,
  });

  SampleUser copy({
    String? firstName,
    String? lastName,
    int? age,
  }) =>
      SampleUser(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        age: age ?? this.age,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SampleUser &&
          runtimeType == other.runtimeType &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          age == other.age;

  @override
  int get hashCode => firstName.hashCode ^ lastName.hashCode ^ age.hashCode;
}