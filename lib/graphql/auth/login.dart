String loginMutation = """
    mutation Login(\$email:EmailAddress!, \$password:String){
      login(input:{
        email:\$email
        password:\$password
      }){
         token
    user {
      address
      avatar
      cardId
      email
      firstName
      id
      phone
      role
      studentId
      selfie
    }
      }
    }
""";
