import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:level_login_lmhung/feature/auth/domain/entities/account.dart';

class AccountModel {
  final String? id;
  final String taxIdOrId;
  final String username;
  final String passwordHash;
  final String salt;
  final String fullName;
  final bool enabled;
  final int updatedAt;

  const AccountModel({
    this.id,
    required this.taxIdOrId,
    required this.username,
    required this.passwordHash,
    required this.salt,
    required this.fullName,
    required this.enabled,
    required this.updatedAt,
  });

  factory AccountModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AccountModel(
      id: doc.id,
      taxIdOrId: data['taxIdOrId'] as String,
      username: data['username'] as String,
      passwordHash: data['passwordHash'] as String,
      salt: data['salt'] as String,
      fullName: data['fullName'] as String,
      enabled: data['enabled'] as bool,
      updatedAt: data['updatedAt'] as int,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'taxIdOrId': taxIdOrId,
      'username': username,
      'passwordHash': passwordHash,
      'salt': salt,
      'fullName': fullName,
      'enabled': enabled,
      'updatedAt': updatedAt,
    };
  }

  /// Convert to domain entity
  Account toEntity() {
    return Account(
      id: id,
      taxIdOrId: taxIdOrId,
      username: username,
      passwordHash: passwordHash,
      salt: salt,
      fullName: fullName,
      enabled: enabled,
      updatedAt: updatedAt,
    );
  }

  /// Create from domain entity
  factory AccountModel.fromEntity(Account account) {
    return AccountModel(
      id: account.id,
      taxIdOrId: account.taxIdOrId,
      username: account.username,
      passwordHash: account.passwordHash,
      salt: account.salt,
      fullName: account.fullName,
      enabled: account.enabled,
      updatedAt: account.updatedAt,
    );
  }
}