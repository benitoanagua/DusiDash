import 'package:fluent_ui/fluent_ui.dart';

class NonAuthLayout extends StatelessWidget {
  final Widget child;

  const NonAuthLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Imagen remota de fondo
        Positioned.fill(
          child: Image.network(
            'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                color: Colors.grey[20],
                child: const Center(child: ProgressRing()),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.blue.dark,
                child: const Center(
                  child: Icon(
                    FluentIcons.image_crosshair,
                    size: 64,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        ),
        // Layout principal con scroll
        LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 500),
                    margin: const EdgeInsets.all(20),
                    child: Acrylic(
                      luminosityAlpha: 0.9,
                      tintAlpha: 0.8,
                      tint: Colors.blue.withValues(alpha: 0.3),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Logo de Flutter
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.1,
                                      ),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const FlutterLogo(
                                  size: 60,
                                  style: FlutterLogoStyle.horizontal,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Text(
                                'Dusi Dash',
                                style: FluentTheme.of(context).typography.title
                                    ?.copyWith(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'Business Management Dashboard',
                                style: FluentTheme.of(context).typography.body,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24.0),
                              child,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
