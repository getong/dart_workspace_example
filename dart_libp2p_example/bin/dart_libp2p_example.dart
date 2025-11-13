import 'package:dart_libp2p/dart_libp2p.dart';
import 'package:dart_libp2p/config/config.dart' as p2p_config;
import 'package:dart_libp2p/core/crypto/ed25519.dart' as crypto_ed25519;
import 'package:dart_libp2p/core/multiaddr.dart';
import 'package:dart_libp2p/p2p/security/noise/noise_protocol.dart';
import 'package:dart_libp2p/p2p/transport/udx_transport.dart';
import 'package:dart_libp2p/p2p/transport/connection_manager.dart'
    as p2p_conn_manager;
import 'package:dart_udx/dart_udx.dart';

Future<Host> createHost({String? listen}) async {
  final keyPair = await crypto_ed25519.generateEd25519KeyPair();
  final udx = UDX();
  final connMgr = p2p_conn_manager.ConnectionManager();

  final options = <p2p_config.Option>[
    p2p_config.Libp2p.identity(keyPair),
    p2p_config.Libp2p.connManager(connMgr),
    p2p_config.Libp2p.transport(
      UDXTransport(connManager: connMgr, udxInstance: udx),
    ),
    p2p_config.Libp2p.security(await NoiseSecurity.create(keyPair)),
    if (listen != null) p2p_config.Libp2p.listenAddrs([MultiAddr(listen)]),
  ];

  final host = await p2p_config.Libp2p.new_(options);
  await host.start();
  return host;
}

void main() async {
  final host1 = await createHost(listen: '/ip4/0.0.0.0/udp/0/udx');
  final host2 = await createHost(listen: '/ip4/0.0.0.0/udp/0/udx');

  print('Host 1: ${host1.id}');
  print('Host 2: ${host2.id}');

  await host1.connect(AddrInfo(host2.id, host2.addrs));
  print('Connected successfully!');

  await host1.close();
  await host2.close();
}
