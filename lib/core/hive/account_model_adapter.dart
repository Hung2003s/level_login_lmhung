import 'package:hive/hive.dart';
import 'package:level_login_lmhung/feature/auth/data/models/account_model.dart';

class AccountModelAdapter extends TypeAdapter<AccountModel> {
  @override
  final int typeId = 0;

  @override
  AccountModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountModel(
      id: fields[0] as String?,
      taxIdOrId: fields[1] as String,
      username: fields[2] as String,
      passwordHash: fields[3] as String,
      salt: fields[4] as String,
      fullName: fields[5] as String,
      enabled: fields[6] as bool,
      updatedAt: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AccountModel obj) {
    writer.writeByte(8);
    writer.writeByte(0);
    writer.write(obj.id);
    writer.writeByte(1);
    writer.write(obj.taxIdOrId);
    writer.writeByte(2);
    writer.write(obj.username);
    writer.writeByte(3);
    writer.write(obj.passwordHash);
    writer.writeByte(4);
    writer.write(obj.salt);
    writer.writeByte(5);
    writer.write(obj.fullName);
    writer.writeByte(6);
    writer.write(obj.enabled);
    writer.writeByte(7);
    writer.write(obj.updatedAt);
  }
}