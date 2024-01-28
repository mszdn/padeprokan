String createWorkspace = """
mutation(\$input: CreateWorkspaceInput!) {
  createWorkspace(input: \$input) {
    id
    name
    description
    createdBy {
      id
    }
  }
}
""";

String createBoard = """
mutation (\$input: CreateBoardInput!) {
  createBoard(input: \$input) {
    id
    name
    background
    workspace {
      id
    }
    createdBy {
      id
    }
  }
}

""";

String deleteBoard = """
mutation (\$id: String!) {
  deleteBoard(id: \$id) {
    id
  }
}
""";

String updateBoardMembers = """
mutation(\$boardId:String!, \$studentIds:[String]){
  updateBoard(id:\$boardId, input:{
    studentsIds:\$studentIds
  }){
    id
    students{
      id
    }
  }
}""";

String addCard = """
mutation AddCard(\$input: CreateCardInput!) {
  createCard(input: \$input) {
    id
    name
  }
}

""";

String addList = """
mutation AddList(\$input: CreateListInput!) {
  createList(input: \$input) {
    id
    name
    index
    background
  }
}
""";

String deleteList = """
mutation UpdateList(\$id: String!, \$input: UpdateListInput!) {
  updateList(id: \$id, input: \$input) {
    id
  }
}

""";


String updateCard="""
mutation UpdateCard(\$id: String!, \$input: UpdateCardInput!) {
      updateCard(id: \$id, input: \$input) {
        id
        name
        duedate
        cover {
          url
        }
        attachments(query: { isDeleted: false }) {
          id
        }
        posts {
          id
        }
        checklists {
          listChecklists {
            status
          }
        }
        cardLabels {
          id
          label {
            color
          }
        }
        students {
          user {
            id
            firstName
            avatar
          }
      }
}
}
""";