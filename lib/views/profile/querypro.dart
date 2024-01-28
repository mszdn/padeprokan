String profiles = """
query(\$createdById: String) {
  profiles(where: { createdById: \$createdById }) {
    title
    facebook
    twitter
    linkedIn
    github
  }
}
""";

String educations = """
query(\$createdById: String) {
  educations(where: { createdById: \$createdById }, orderBy: yearStart_DESC) {
    id
    school
    degree
    study
    yearStart
    yearEnd
    description
    thumbnail
  }
}
""";

String works = """
query(\$createdById: String) {
  works(where: { createdById: \$createdById }, orderBy: startDate_DESC) {
    id
    title
    company
    address
    present
    startDate
    endDate
    description
    thumbnail
  }
}
""";

String skilss = """
query(\$createdById: String) {
  skills(where: { createdById: \$createdById }) {
    id
    name
  }
}
""";

String project = """
query(\$createdById: String) {
  projects(where: { createdById: \$createdById, projectType: SLIDE }) {
    id
    title
    link
    note
    projectType
    thumbnail
    createdAt
  }
}
""";

String projects1 = """
query(\$createdById: String) {
  projects(where: { createdById: \$createdById, projectType: PORTFOLIO }) {
    id
    title
    link
    note
    projectType
    thumbnail
    createdAt
  }
}
""";
