class UserModel {
  final String id;
  final String username;
  final String email;
  final int age;
  final String gender;
  final double height;
  final double weight;
  final String lifestyle;
  final String goals;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.lifestyle,
    required this.goals,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
      'lifestyle': lifestyle,
      'goals': goals,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      age: map['age'] ?? 0,
      gender: map['gender'] ?? '',
      height: map['height'] ?? 0.0,
      weight: map['weight'] ?? 0.0,
      lifestyle: map['lifestyle'] ?? '',
      goals: map['goals'] ?? '',
    );
  }
}
