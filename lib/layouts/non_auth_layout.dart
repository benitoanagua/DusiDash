import 'package:fluent_ui/fluent_ui.dart';

class NonAuthLayout extends StatelessWidget {
  final Widget child;

  const NonAuthLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
        Center(
          child: Container(
            width: 512,
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const FlutterLogo(
                  size: 256,
                  style: FlutterLogoStyle.horizontal,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Dusi Dash',
                  style: FluentTheme.of(context).typography.title?.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Business Management Dashboard',
                  style: FluentTheme.of(context).typography.body?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32.0),
                Acrylic(
                  luminosityAlpha: 0.9,
                  tintAlpha: 0.8,
                  tint: Colors.blue.withValues(alpha: 0.3),
                  child: Container(
                    padding: const EdgeInsets.all(32.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
