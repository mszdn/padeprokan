String createFolder = """
 mutation CreateFolder(\$input: CreateFolderInput!) {
      createFolder(input: \$input) {
        id
        title: name
        userFiles {
          url
          title: name
          type
          owncloudUrl
          embedLink
          downloadUrl
          path
        }
        createdBy {
          id
        }
      }
    }""";
