import 'package:customer_app/model/customer_hive_model.dart';
import 'package:hive/hive.dart';

class CustomerHiveModelAdaptor extends TypeAdapter<CustomerDetailHiveModel> {
  @override
  final int typeId = 0;

  @override
  CustomerDetailHiveModel read(BinaryReader reader) {
    final id = reader.readString();
    final panNumber = reader.readString();
    final name = reader.readString();
    final mobile = reader.readString();
    final email = reader.readString();
    final city = reader.readString();
    final state = reader.readString();
    final addressLine1 = reader.readString();
    final addressLine2 = reader.readString();
    final postalCode = reader.readString();
    return CustomerDetailHiveModel(
      id: id,
      panNumber: panNumber,
      name: name,
      mobile: mobile,
      email: email,
      city: city,
      state: state,
      addressLine1: addressLine1,
      addressLine2: addressLine2,
      postalCode: postalCode,
    );
  }

  @override
  void write(BinaryWriter writer, CustomerDetailHiveModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.panNumber);
    writer.writeString(obj.name);
    writer.writeString(obj.mobile);
    writer.writeString(obj.email);
    writer.writeString(obj.city);
    writer.writeString(obj.state);
    writer.writeString(obj.addressLine1);
    writer.writeString(obj.addressLine2);
    writer.writeString(obj.postalCode);
  }
}
