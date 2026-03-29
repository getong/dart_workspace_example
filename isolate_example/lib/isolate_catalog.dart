enum IsolateDemoKind { oneShot, convenienceApi, longLivedWorker }

class IsolateDemoSpec {
  const IsolateDemoSpec({
    required this.slug,
    required this.title,
    required this.description,
    required this.kind,
  });

  final String slug;
  final String title;
  final String description;
  final IsolateDemoKind kind;
}

const List<IsolateDemoSpec> isolateDemos = <IsolateDemoSpec>[
  IsolateDemoSpec(
    slug: 'spawn-sum',
    title: 'Spawn + SendPort',
    description: 'Create a one-shot isolate and return a computed sum.',
    kind: IsolateDemoKind.oneShot,
  ),
  IsolateDemoSpec(
    slug: 'isolate-run-prime',
    title: 'Isolate.run Prime',
    description: 'Use Isolate.run for short background CPU work.',
    kind: IsolateDemoKind.convenienceApi,
  ),
  IsolateDemoSpec(
    slug: 'worker-text',
    title: 'Long-lived Text Worker',
    description: 'Keep one isolate alive and process multiple requests.',
    kind: IsolateDemoKind.longLivedWorker,
  ),
];

IsolateDemoSpec? findIsolateDemo(String slug) {
  for (final IsolateDemoSpec demo in isolateDemos) {
    if (demo.slug == slug) {
      return demo;
    }
  }
  return null;
}
