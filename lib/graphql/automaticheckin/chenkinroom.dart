String checkInRoom = """
 query(\$id: String!) {
  checkInRoom(id: \$id) {
    id
    question
    time
    comments {
      id
      text
      subComments{
        text
        id
      createdBy{
        firstName
        email
        avatar
      }
    }
       createdBy {
        firstName
        email
        avatar
      }
    }
  }
}
""";
