String deleteSpace = """
 mutation(\$spaceId: String!) {
      deleteSpace(id: \$spaceId) {
        id
      }
    }
    """;
