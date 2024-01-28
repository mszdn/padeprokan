String postphoto123 = """
mutation(\$input: CreatePostAttachmentInput!) {
      createPostAttachment(input: \$input) {
        id
        name
        url
      }
    }
""";

String deletephoto = """
mutation(\$id: String!) {
      deletePostAttachment(id: \$id) {
        id
      } 
    }
    """;
