// String CoursesQuery = """
// query getCourse(\$id: String!,) {
//         course(id: \$id) {
//           id
//           title
//         }
//       }

// """;

String coursesQuery = """
query(\$idSpace: String!) {
  courses(where: { spaceId: \$idSpace }) {
    title
    id
    courseCategories {
      id
      name
    }
    finishTime
    description 
    createdBy{
      id
    }  
  } 
}


""";
