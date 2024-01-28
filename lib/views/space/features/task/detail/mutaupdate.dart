String mutaupdatedesc = """ 
 mutation UpdateCard(\$id: String!, \$input: UpdateCardInput!) {
  updateCard(id: \$id, input: \$input) {
    id
    description
  }
}
    """;