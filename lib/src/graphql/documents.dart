const registerMutation = r'''
mutation Register($signupInput: SignupInput!) {
  signup(signupInput: $signupInput) {
    access_token
    refresh_token
  }
}
''';

const loginMutation = r'''
mutation Login($loginInput: LoginInput!) {
  login(loginInput: $loginInput) {
    access_token
    refresh_token
  }
}
''';

const refreshMutation = r'''
mutation Refresh {
  refreshAccessToken {
    access_token
  }
}
''';

const usersQuery = r'''
query GetUsers {
  users {
    id
    username
    email
  }
}
''';

const userQuery = r'''
query GetUser($id: ID!) {
  user(id: $id) {
    id
    username
    email
  }
}
''';

const createWorkspaceMutation = r'''
mutation CreateWorkspace($createWorkspaceInput: CreateWorkspaceInput!) {
  createWorkspace(createWorkspaceInput: $createWorkspaceInput) {
    id
    owner {
      id, username, email
    }
    title
    members {
      id, username, email
    }
    tasks {
      id, title, workspace, parentTask
    }
  }
}
''';

const updateWorkspaceMutation = r'''
mutation UpdateWorkspace($updateWorkspaceInput: UpdateWorkspaceInput!) {
  updateWorkspace(updateWorkspaceInput: $updateWorkspaceInput) {
    id
    owner {
      id, username, email
    }
    title
    members {
      id, username, email
    }
    tasks {
      id, title, workspace, parentTask
    }
  }
}
''';

const removeWorkspaceMutation = r'''
mutation RemoveWorkspace($id: ID!) {
  removeWorkspace(id: $id) {
    id
  }
}
''';

const addMemberMutation = r'''
mutation AddMember($addMemberInput: AddMemberInput!) {
  addMember(addMemberInput: $addMemberInput) {
    id
    owner {
      id, username, email
    }
    title
    members {
      id, username, email
    }
    tasks {
      id, title, workspace, parentTask
    }
  }
}
''';

const removeMemberMutation = r'''
mutation RemoveMember($removeMemberInput: RemoveMemberInput!) {
  removeMember(removeMemberInput: $removeMemberInput) {
    id
    owner {
      id, username, email
    }
    title
    members {
      id, username, email
    }
    tasks {
      id, title, workspace, parentTask
    }
  }
}
''';

const workspacesQuery = r'''
query GetWorkspaces {
  workspaces {
    id
    title
  }
}
''';

const workspaceQuery = r'''
query GetWorkspace($id: ID!) {
  workspace(id: $id) {
    id
    owner {
      id, username, email
    }
    title
    members {
      id, username, email
    }
    tasks {
      id, title, workspace, parentTask
    }
  }
}
''';

const createTaskMutation = r'''
mutation CreateTask($createTaskInput: CreateTaskInput!) {
  createTask(createTaskInput: $createTaskInput) {
    id
    title
    workspace
    parentTask
  }
}
''';

const updateTaskMutation = r'''
mutation UpdateTask($updateTaskInput: UpdateTaskInput!) {
  updateTask(updateTaskInput: $updateTaskInput) {
    id
    title
    workspace
    parentTask
  }
}
''';

const removeTaskMutation = r'''
mutation RemoveTask($id: ID!) {
  removeTask(id: $id) {
    id
  }
}
''';

const taskQuery = r'''
query GetTask($id: ID!) {
  task(id: $id) {
    id
    title
    workspace
    parentTask
  }
}
''';
