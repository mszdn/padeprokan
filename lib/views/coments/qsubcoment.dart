 String querysubcom = """
    query(\$postId: String, \$skip: Int) {
  commentsConnection(
    query: { postId: \$postId }
    orderBy: createdAt_DESC
    limit: 10
    skip: \$skip
  ) {
    total
    data {
      id
      message: text
      attachments {
        url
      }
      user: createdBy {
        id
        name: firstName
        avatar
        email
      }
      createdAt
    }
  }
}
""";

String mutacreatesub = """
mutation(\$input: CreateCommentInput!) {
      createComment(input: \$input) {
        id
        message: text
        attachments {
          url
        }
        user: createdBy {
          id
          name: firstName
          avatar
          email
        }
        createdAt
      }
    }
    """;

String mutaupdatesub = """
mutation(\$id: String!, \$input: UpdateCommentInput!) {
      updateComment(id: \$id, input: \$input) {
        id
        message: text
        attachments {
          url
        }
        user: createdBy {
          id
          name: firstName
          avatar
          email
        }
        createdAt
      }
    }
""";

String mutadeletesub = """
mutation(\$id: String!) {
      deleteComment(id: \$id) {
        id
      }
    }
    """;