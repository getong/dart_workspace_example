enum LayoutKind { row, column }

class LayoutSpec {
  const LayoutSpec({
    required this.slug,
    required this.title,
    required this.message,
    required this.kind,
  });

  final String slug;
  final String title;
  final String message;
  final LayoutKind kind;
}

const List<LayoutSpec> layoutSpecs = <LayoutSpec>[
  LayoutSpec(
    slug: 'row-rainbow',
    title: 'Row Rainbow',
    message: 'Even spacing keeps row content balanced.',
    kind: LayoutKind.row,
  ),
  LayoutSpec(
    slug: 'row-chips',
    title: 'Row Chips',
    message: 'A Row can act like a compact command bar.',
    kind: LayoutKind.row,
  ),
  LayoutSpec(
    slug: 'column-cards',
    title: 'Column Cards',
    message: 'Columns are ideal for stacked content blocks.',
    kind: LayoutKind.column,
  ),
  LayoutSpec(
    slug: 'column-dashboard',
    title: 'Column Dashboard',
    message: 'Mix Expanded widgets to create dashboard sections.',
    kind: LayoutKind.column,
  ),
];

LayoutSpec? findLayoutSpec(String slug) {
  for (final LayoutSpec spec in layoutSpecs) {
    if (spec.slug == slug) {
      return spec;
    }
  }
  return null;
}

abstract class LayoutDemo {
  LayoutDemo(this.spec);

  final LayoutSpec spec;

  List<String> buildSteps();
}

mixin HeaderMixin on LayoutDemo {
  String headerLine() {
    final String kindLabel = spec.kind.name.toUpperCase();
    return '$kindLabel DEMO :: ${spec.title} (${spec.slug})';
  }
}

mixin MessageMixin on LayoutDemo {
  String messageLine() => 'Message: ${spec.message}';
}

mixin StepFormatterMixin on LayoutDemo {
  String stepsBlock() {
    final StringBuffer buffer = StringBuffer();
    final List<String> steps = buildSteps();
    for (var i = 0; i < steps.length; i++) {
      buffer.writeln('  ${i + 1}. ${steps[i]}');
    }
    return buffer.toString().trimRight();
  }
}

class RowLayoutDemo extends LayoutDemo
    with HeaderMixin, MessageMixin, StepFormatterMixin {
  RowLayoutDemo(super.spec);

  @override
  List<String> buildSteps() => <String>[
    'Create a horizontal container',
    'Place child blocks side-by-side',
    'Control spacing with a row-like strategy',
  ];
}

class ColumnLayoutDemo extends LayoutDemo
    with HeaderMixin, MessageMixin, StepFormatterMixin {
  ColumnLayoutDemo(super.spec);

  @override
  List<String> buildSteps() => <String>[
    'Create a vertical container',
    'Stack cards top-to-bottom',
    'Use stretch/alignment to fill available width',
  ];
}

LayoutDemo createLayoutDemo(LayoutSpec spec) {
  if (spec.kind == LayoutKind.row) {
    return RowLayoutDemo(spec);
  }
  return ColumnLayoutDemo(spec);
}

String renderLayoutDemo(String slug) {
  final LayoutSpec? spec = findLayoutSpec(slug);
  if (spec == null) {
    return 'Layout "$slug" was not found.';
  }

  final LayoutDemo demo = createLayoutDemo(spec);
  final HeaderMixin header = demo as HeaderMixin;
  final MessageMixin message = demo as MessageMixin;
  final StepFormatterMixin formatter = demo as StepFormatterMixin;

  return <String>[
    header.headerLine(),
    message.messageLine(),
    'Steps:',
    formatter.stepsBlock(),
  ].join('\n');
}
