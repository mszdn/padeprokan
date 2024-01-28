String getActiveConferences = """
query GetConference(\$idSpace:String) {
        conferences(where:{
          spaceId:\$idSpace,
          conferenceStatus:ONAIR
        }, orderBy: createdAt_DESC) {
          id
          name
          token
          conferenceStatus
          createdAt
        }
      }""";
