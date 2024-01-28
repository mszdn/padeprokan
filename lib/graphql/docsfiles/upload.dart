String upload = """
mutation UploadFile(\$input: CreateUserFileInput!) {
      createUserFile(input: \$input) {
        id
        title: name
        type
        url
        owncloudUrl
        embedLink
        downloadUrl
        path
        createdBy {
          id
        }
      }
    }""";
