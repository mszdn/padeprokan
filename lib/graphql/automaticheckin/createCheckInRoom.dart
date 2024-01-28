String createCheckInRoom ="""
mutation(\$question: String, \$time: String, \$spaceId: String!) {
        createCheckInRoom(
          input: { question: \$question, time: \$time, spaceId: \$spaceId }
        ) {
          id
        }
      }
""";