String getSpaces = """
 query(\$where: SpaceFilter, \$skip: Int, \$queryConference: JSON, \$limit:Int) {
      spacesConnection(where: \$where, skip: \$skip,limit:\$limit) {
        total
        data {
          id
          name
          needKyc
          students{
            id
            user{
						firstName
              id
              avatar
            }
          }
          conferences(query: \$queryConference) {
            conferenceStatus
          }
          spaceMenu{
            conference
            course
            docFile
            schedule
            autoCheckIn
            groupChat
            infoBoard
            task
            id
            
          }
          createdBy {
            id
          }
        }
      }
    }""";
