enum UserType {
  unknown,
  parent,
  child;

  static UserType fromString(String value) {
    switch (value) {
      case 'parent':
        return UserType.parent;
      case 'child':
        return UserType.child;
      default:
        return UserType.unknown;
    }
  }
}

enum Role {
  unknown,
  mom,
  dad,
  son,
  daughter;

  static Role fromString(String value) {
    switch (value) {
      case 'mom':
        return Role.mom;
      case 'dad':
        return Role.dad;
      case 'son':
        return Role.son;
      case 'daughter':
        return Role.daughter;
      default:
        return Role.unknown;
    }
  }
}