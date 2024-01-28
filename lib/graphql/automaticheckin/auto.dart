String checkInRooms = """
query(\$spaceId: String) {
  checkInRooms(where: { spaceId: \$spaceId }) {
    id
    question
    time
    space{
      students{
        user{
          id
          firstName
          avatar
        }
      }
    }
  }
}
""";
