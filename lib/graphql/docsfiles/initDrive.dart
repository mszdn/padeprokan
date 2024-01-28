String getInitDrive = """
query InitDrive(\$spaceId: String, \$parentFolder: String, \$skip: Int) {
        # list folder
        foldersConnection(
          query: { spaceId: \$spaceId, parentFolder: \$parentFolder }
          skip: \$skip
        ) {
          data {
            id
            title: name
            userFiles {
              url
              title: name
              type
              owncloudUrl
              embedLink
              downloadUrl
              path
            }
            createdBy {
              id
            }
          }
        }

        # list file
        userFilesConnection(
          query: { spaceId: \$spaceId, folderId: \$parentFolder }
          skip: \$skip
          where: { type_not: "subfolder" }
        ) {
          data {
            id
            title: name
            type
            url
            owncloudUrl
            embedLink
            downloadUrl
            path
            createdBy {
              id
            }
          }
        }
      }
      """;
