// String getSpace = """query getSpace(\$id: String!) {
//   space(id: \$id) {
//     id
//     name
//     courses{
//       id
//       title
//       description
//       courseCategories{
//         id
//         name
//       }
//     }
//     createdBy {
//       id
//     }
//   }
// }

// """;
String allCoursesQuery = """
query(\$idCourse:String!) {
  course(id:\$idCourse) {
    title
    id
    space{
      id
      createdBy{
        id
      }
    }
    courseCategories {
      id
      name
    }
    sections{
      id
      title
      description
      lectures{
        id
        title
        type
        description
        embed
        article{
          id
          title
          markdown  
          createdBy {
            avatar
            id
            firstName
          }
        }
        quiz{
          id
          subdesc
          title
          questions{
            id
            title
            desc
            options {
              id
              check
              desc
            }
          }
        }
      }
    }
    finishTime
    description
  }
}
""";
