String deleteSubComment = """
mutation(\$id: String!) {
      deleteSubComment(id: \$id) {
        id
        comment {
          id
        }
      }
    }
""";

String updateSubComment = """
mutation(\$id: String!, \$input: UpdateSubCommentInput!) {
      updateSubComment(id: \$id, input: \$input) {
        id
        text
        comment {
          id
        }
        attachments {
          url
        }
        user: createdBy {
          id
          name: firstName
          avatar
        }
        createdAt
  }
}
""";

String createSubComment = """
mutation(\$input: CreateSubCommentInput!) {
  createSubComment(input:\$input) {
    id
    text
    comment {
      id
    }
    attachments {
      url
    }
    user: createdBy {
      id
      name: firstName
      avatar
    }
    createdAt
  }
}
""";
