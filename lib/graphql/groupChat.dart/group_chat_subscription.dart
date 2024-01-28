String messageAdded = """
  subscription GetMessageAdded(\$spaceId:String){
        messageAdded(where:{
          spaceId:\$spaceId
        }){
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
      }""";
