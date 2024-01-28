String deleteFile = """
 mutation DeleteFile(\$id: String!) {
      deleteUserFile(id: \$id) {
        id
      }
    }""";

String deleteFolder = """
mutation (\$id: String!) {
      deleteFolder(id: \$id) {
        id
      }
    }""";
