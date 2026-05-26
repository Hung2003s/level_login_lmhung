class Account {
  final String? id;
  final String taxIdOrId;
  final String username;
  final String passwordHash;
  final String salt;
  final String fullName;
  final bool enabled;
  final int updatedAt;

  const Account({
    this.id,
    required this.taxIdOrId,
    required this.username,
    required this.passwordHash,
    required this.salt,
    required this.fullName,
    required this.enabled,
    required this.updatedAt,
  });
}