enum RewardType {
  childCreated,
  issued,
  pendingRewards,
  available;

  static RewardType fromString(String type) {
    switch (type) {
      case 'childCreated':
        return RewardType.childCreated;
      case 'issued':
        return RewardType.issued;
      case 'pendingRewards':
        return RewardType.pendingRewards;
      case 'available':
        return RewardType.available;
      default:
        throw Exception('Unknown RewardType: $type, try updating the app.');
    }
  }
}
