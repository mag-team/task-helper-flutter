const _fullWorkspace = r'''
id
owner {
  id, username, email
}
title
description
members {
  id, username, email
}
tasks {
  id, title, workspace, parentTask
}
properties {
  name, type, values
}
''';

const _fullUser = r'''
id
username
email
''';

const _fullTask = r'''
id
title
workspace
parentTask
properties {
  name, value
}
''';

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

const usersQuery = '''
query GetUsers {
  users {
    $_fullUser
  }
}
''';

const userQuery = '''
query GetUser(\$id: ID!) {
  user(id: \$id) {
    $_fullUser
  }
}
''';

const createWorkspaceMutation = '''
mutation CreateWorkspace(\$createWorkspaceInput: CreateWorkspaceInput!) {
  createWorkspace(createWorkspaceInput: \$createWorkspaceInput) {
    $_fullWorkspace
  }
}
''';

const updateWorkspaceMutation = '''
mutation UpdateWorkspace(\$updateWorkspaceInput: UpdateWorkspaceInput!) {
  updateWorkspace(updateWorkspaceInput: \$updateWorkspaceInput) {
    $_fullWorkspace
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

const addMemberMutation = '''
mutation AddMember(\$addMemberInput: AddMemberInput!) {
  addMember(addMemberInput: \$addMemberInput) {
    $_fullWorkspace
  }
}
''';

const removeMemberMutation = '''
mutation RemoveMember(\$removeMemberInput: RemoveMemberInput!) {
  removeMember(removeMemberInput: \$removeMemberInput) {
    $_fullWorkspace
  }
}
''';

const addWorkspacePropertyMutation = '''
mutation AddWorkspaceProperty(\$addWorkspacePropertyInput: AddWorkspacePropertyInput!) {
  addWorkspaceProperty(addWorkspacePropertyInput: \$addWorkspacePropertyInput) {
    $_fullWorkspace
  }
}
''';

const removeWorkspacePropertyMutation = '''
mutation RemoveWorkspaceProperty(\$removeWorkspacePropertyInput: RemoveWorkspacePropertyInput!) {
  removeWorkspaceProperty(removeWorkspacePropertyInput: \$removeWorkspacePropertyInput) {
    $_fullWorkspace
  }
}
''';

const updateWorkspacePropertyMutation = '''
mutation UpdateWorkspaceProperty(\$updateWorkspacePropertyInput: UpdateWorkspacePropertyInput!) {
  updateWorkspaceProperty(updateWorkspacePropertyInput: \$updateWorkspacePropertyInput) {
    $_fullWorkspace
  }
}
''';

const addValueToWorkspacePropertyMutation = '''
mutation AddValueToWorkspaceProperty(\$addValueToWorkspacePropertyInput: AddValueToWorkspacePropertyInput!) {
  addValueToWorkspaceProperty(addValueToWorkspacePropertyInput: \$addValueToWorkspacePropertyInput) {
    $_fullWorkspace
  }
}
''';

const removeValueFromWorkspacePropertyMutation = '''
mutation RemoveValueFromWorkspaceProperty(\$removeValueFromWorkspacePropertyInput: RemoveValueFromWorkspacePropertyInput!) {
  removeValueFromWorkspaceProperty(removeValueFromWorkspacePropertyInput: \$removeValueFromWorkspacePropertyInput) {
    $_fullWorkspace
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

const workspaceQuery = '''
query GetWorkspace(\$id: ID!) {
  workspace(id: \$id) {
    $_fullWorkspace
  }
}
''';

const createTaskMutation = '''
mutation CreateTask(\$createTaskInput: CreateTaskInput!) {
  createTask(createTaskInput: \$createTaskInput) {
    $_fullTask
  }
}
''';

const updateTaskMutation = '''
mutation UpdateTask(\$updateTaskInput: UpdateTaskInput!) {
  updateTask(updateTaskInput: \$updateTaskInput) {
    $_fullTask
  }
}
''';

const updateTaskPropertyMutation = '''
mutation UpdateTaskProperty(\$updateTaskPropertyInput: UpdateTaskPropertyInput!) {
  updateTaskProperty(updateTaskPropertyInput: \$updateTaskPropertyInput) {
    $_fullTask
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

const taskQuery = '''
query GetTask(\$id: ID!) {
  task(id: \$id) {
    $_fullTask
  }
}
''';
