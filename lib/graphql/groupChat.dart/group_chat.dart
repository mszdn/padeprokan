String getSpaceChats = """
query GetSpaceChat(\$spaceId: String!, \$limit: Int, \$skip: Int) {
        messagesConnection(
          where:{
            spaceId:\$spaceId
          }
          limit: \$limit
          skip: \$skip
          orderBy: createdAt_DESC
        ) {
          total
          limit
          skip
          data {
            id
            text
            parentMessage
            type: MessageType
            createdAt
            isDeleted
            files {
              id
              url
            }
            user: createdBy {
              id
              name: firstName
              avatar
            }
          }
        }
      }""";

String sendMessage = """
mutation SendMessage(
      \$text: String
      \$type: String
      \$parentMessage: String
      \$spaceId: String!
    ) {
      createMessage(
        input: {
          text: \$text
          MessageType: \$type
          parentMessage: \$parentMessage
          spaceId: \$spaceId
        }
      ) {
        id
      }
    }
""";
