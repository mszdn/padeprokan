String getSchedule = """
query(\$idSpace:String!){
      events(where:{spaceId:\$idSpace}) {
        id
        title
        start
        end
        allDay
        description
      }
    }
""";