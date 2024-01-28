String getWorkspaces = """
query(\$where: WorkspaceFilter, \$skip: Int) {
  workspacesConnection(where: \$where, skip: \$skip, orderBy: createdAt_ASC) {
    total
    data {
      id
      name
      description
      boards {
        name
        id
        background
      }
      students(limit:1000){
        id
        user{
          avatar
          id
          firstName
        }
      }
      createdBy {
        id
      }
    }
  }
}
""";

String getWorkspaceMini = """
query(\$where: WorkspaceFilter, \$skip: Int) {
  workspacesConnection(where: \$where, skip: \$skip, limit:1000, orderBy: createdAt_ASC) {
    total
    data {
      id
      name
      description
  }
}
}
""";

String getPersonalBoards = """
query(\$where: BoardFilter, \$skip: Int) {
  boardsConnection(where: \$where, skip: \$skip, orderBy: createdAt_ASC) {
    total
    data {
      id
      name
      background
    }
  }
}
""";

String getBoardStudents = """
query (\$id:String!){
  board(id: \$id) {
    createdBy {
      id
    } 
    students {
      id
      user {
        id
        firstName
        avatar
      }
    }
  }
}

""";

String getAllListsCards = """
query GetBoardList(\$boardId: String!, \$skip: Int) {
  listsConnection( skip: \$skip, limit: 1000, orderBy: index_ASC, where: {boardId:\$boardId, isDeleted_not: true}) {
    total
    data {
      id
      name
      index
      background
       cards(limit: 1000, where: { isDeleted_not: true }){
        id
      name
      duedate
      index
      isDone
      isDeleted
      cover {
          fileUrl
        }
      }
    }
  }
}
""";

String getDetailTasks = """
query GetDetailTask(\$id: String!) {
  card(id: \$id) {
    id
    name
    description
    isDone
    duedate
    cover {
      id
      url
    }
    attachments(where: {isDeleted_not: true}) {
      id
      name
      url
      createdAt
    }
    checklists {
      id
      name
      listChecklists {
        id
        title
        status
      }
    }
    cardLabels {
      id
      label {
        id
        color
        title
      }
    }
    students {
      user {
        id
        firstName
        avatar
      }
    }
    posts {
      id
      text
      createdAt
      comments {
        text
        createdAt
        createdBy {
          id
          firstName
          avatar
        }
      }
      createdBy {
        id
        firstName
        avatar
      }
    }
  }
}

""";
