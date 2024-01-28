String createComment="""
mutation(\$input: CreateCommentInput!) {
      createComment(input: \$input) {
        id
        message: text
        attachments {
          url
        }
        replied: subComments {
          id
          text
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



String updateComment="""
mutation(\$id: String!, \$input: UpdateCommentInput!) {
      updateComment(id: \$id, input: \$input) {
        id
        message: text
        attachments {
          url
        }
        replied: subComments {
          id
          text
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



String deleteComment="""
mutation(\$id: String!) {
      deleteComment(id: \$id) {
        id
      }
    }
""";


