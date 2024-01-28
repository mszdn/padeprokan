String getBoards = """
query(\$spaceId: String){
  infoBoard{
    
  }
}
""";

// const { loading: loadingPosts, refetch: getPosts } = useQuery(
//     gql`
//       query($spaceId: String, $skip: Int) {
//         postsConnection(
//           orderBy: createdAt_DESC
//           query: { spaceId: $spaceId }
//           limit: 10
//           skip: $skip
//         ) {
//           total
//           data {
//             id
//             text
//             createdAt
//             attachments {
//               id
//               name
//               url
//             }
//             sender: createdBy {
//               id
//               name: firstName
//               avatar
//             }
//           }
//         }
//       }
//     `,
//     {