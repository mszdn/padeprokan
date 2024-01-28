String deleteCheckInRoom= """
mutation(\$id: String!) {
        deleteCheckInRoom(id: \$id) {
          id
        }
      }
""";