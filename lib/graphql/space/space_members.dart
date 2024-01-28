String getSpaceMembers = """
query(\$id:String!){
  space(id:\$id){
    students{
      user{
        id
        firstName
        email
				avatar        
      }
      id
    }
createdBy{
  id
}
  }
}""";

String getSearchUsers = """
query(\$where: UserFilter, \$skip: Int,\$limit: Int) {
      usersConnection(where: \$where, skip: \$skip, limit:\$limit) {
        total
        data {
          id
          firstName
          email
          avatar
          studentId
        }
      }
    }
""";

String addMemberstoSpace = """
mutation(\$studentId: String!, \$spaceId: String!) {
      addStudentOnSpace(studentId: \$studentId, spaceId: \$spaceId) {
        id
      }
      
      addSpaceOnStudent(studentId: \$studentId, spaceId: \$spaceId) {
        id
      }
    }
""";

String removeMemberstoSpace = """
  mutation(\$studentId: String!, \$spaceId: String!) {
      removeStudentOnSpace(studentId: \$studentId, spaceId: \$spaceId) {
        id
      }

      removeSpaceOnStudent(studentId: \$studentId, spaceId: \$spaceId) {
        id
      }
    }""";
