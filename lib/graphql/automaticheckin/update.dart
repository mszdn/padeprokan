String updateCheckInRoom = """
mutation(\$id: String!, \$input: UpdateCheckInRoomInput!) {
        updateCheckInRoom(id: \$id, input: \$input) {
          id
        }
      }
""";
