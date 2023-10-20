//use with auto_exporter package
import 'export.dart';
import 'package:protobuf/protobuf.dart';

const int MYPACKAGE_MYMESSAGE = 1;
const int MYPACKAGE_OTHERMESSAGE = 2;

const Map<Type, int> PROTOBUF_MESSAGE_TYPES = {
    MyMessage: MYPACKAGE_MYMESSAGE,
    OtherMessage: MYPACKAGE_OTHERMESSAGE,
};

/// Builds a [GeneratedMessage] from bytes.
typedef T MessageBuilder<T extends GeneratedMessage>(List<int> bytes);

/// Used to obtain the matching [MessageBuilder] for each defined message code.
final Map<int, MessageBuilder> PROTOBUF_MESSAGE_LIST = <int, MessageBuilder>{
    MYPACKAGE_MYMESSAGE: (List<int> bytes) => MyMessage.fromBuffer(bytes),
    MYPACKAGE_OTHERMESSAGE: (List<int> bytes) => OtherMessage.fromBuffer(bytes),
};
