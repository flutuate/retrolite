class RegisterContent {
  final String email;
  final String password;

  RegisterContent(this.email, this.password);

  Map<String, dynamic> toJson() =>
      {
        'email': email,
        'password': password,
      };
}
