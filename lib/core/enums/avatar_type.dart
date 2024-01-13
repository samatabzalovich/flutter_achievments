enum AvatarType {
  network,
  asset,
  none;

  static AvatarType fromString(String type) {
    switch (type) {
      case 'AvatarType.network':
        return AvatarType.network;
      case 'AvatarType.asset':
        return AvatarType.asset;
      case 'AvatarType.none':
        return AvatarType.none;
      default:
        return AvatarType.none;
    }
  }
}
