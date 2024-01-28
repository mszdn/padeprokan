String RegisterMutation = """
  mutation Register(
      \$email:EmailAddress!,
      \$password: String!,
      \$firstName: String!
    ){
    register(
      input: {
        email: \$email,
        password:\$password,
        firstName: \$firstName,
      }
    ){
      token
      user {
        firstName
      }
    }
  }
""";
