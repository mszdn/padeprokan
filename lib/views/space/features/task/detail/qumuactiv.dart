String quactivity = """
query GetDetailTask(\$id: String!) {
      card(id: \$id) {
        id
        name
        description
        isDone
        duedate
        cover {
          id
          url
        }
        attachments(where:{isDeleted_not:true}){
          id
          name
          url
          createdAt
        }
        checklists {
          id
          name
          listChecklists {
            id
            title
            status
          }
        }
        cardLabels {
          id
          label {
            id
            color
            title
          }
        }
        students {
          user {
            id
            firstName
            avatar
          }
        }
        posts {
          id
          text
          createdAt
          comments {
            text
            createdAt
            createdBy {
              id
              firstName
              avatar
            }
          }
          createdBy {
            id
            firstName
            avatar
          }
        }
      }
    }
""";

String postactiv = """ 
mutation AddPost(\$input: CreatePostInput!) {
      createPost(input: \$input) {
        id
        text
        createdAt
        comments {
          id
        }
        createdBy {
          id
          firstName
          avatar
        }
      }
    }
    """;

String updateactiv = """
    mutation UpdatePost(\$id: String!, \$input: UpdatePostInput!) {
      updatePost(id: \$id, input: \$input) {
        text
      }
    }
    """;

String deleteactiv = """
mutation UpdatePost(\$id: String!) {
      deletePost(id: \$id) {
        id
      }
    }
""";

String postphotoactiv = """
mutation (\$input: CreateAttachmentInput!) {
      createAttachment (input: \$input) {
        id
        name
        url
        createdAt
      }
    }
""";

String updatephotoactiv = """
mutation UpdateAttachment(\$id: String!, \$input: UpdateAttachmentInput!) {
      updateAttachment(id: \$id, input: \$input) {
        id
        name
        url
        fileUrl
        createdAt
        isDeleted
      }
    }
""";

String addcomentactiv = """
mutation AddComment(\$input: CreateCommentInput!) {
      createComment(input: \$input) {
        id
        text
        createdAt
        createdBy {
          id
          firstName
          avatar
        }
      }
    }
""";