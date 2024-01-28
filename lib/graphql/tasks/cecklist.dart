String createChecklist= """
mutation CreateChecklist(\$input: CreateChecklistInput!) {
      createChecklist(input: \$input) {
        id
        name
        listChecklists {
          id
          title
          status
        }
      }
    }
""";

String  updateChecklist= """
mutation UpdateChecklist(\$id: String!, \$input: UpdateChecklistInput!) {
      updateChecklist(id: \$id, input: \$input) {
        id
        name
      }
    }
""";

String deleteChecklist="""
mutation DeleteChecklist(\$id: String!) {
      deleteChecklist(id: \$id) {
        id
      }
    }
""";

String  createListChecklist="""
mutation CreateChecklistItem (\$input: CreateListChecklistInput!) {
      createListChecklist(input: \$input) {
        id
        title
        status
      }
    }
""";

 String updateListChecklist="""
mutation UpdateChecklistItem(\$id: String!, \$input: UpdateListChecklistInput!) {
      updateListChecklist(id: \$id, input: \$input) {
        id
        title
        status
      }
    }
""";

String deleteListChecklist="""
mutation DeleteChecklistItem (\$id: String!) {
      deleteListChecklist (id: \$id) {
        id
        status
        checklist {
          id
        }
      }
    }
""";