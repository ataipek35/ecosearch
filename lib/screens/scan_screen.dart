import 'package:flutter/material.dart';

import '../core/app_routes.dart';
import '../core/app_colors.dart';
import '../core/app_spacing.dart';
import '../core/app_text_styles.dart';
import '../data/sample_data.dart';
import '../utils/validation_utils.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/info_banner.dart';
import '../widgets/screen_body.dart';

/// Barcode 1234567890123 finds a product, any other
/// valid barcode opens the "Product not found" screen.
class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  static const String _demoBarcode = '1234567890123';

  final _formKey = GlobalKey<FormState>();
  final _barcodeController = TextEditingController();
  bool _flashOn = false;

  @override
  void dispose() {
    _barcodeController.dispose();
    super.dispose();
  }

  void _search() {
    if (!_formKey.currentState!.validate()) return;
    if (_barcodeController.text.trim() == _demoBarcode) {
      Navigator.pushNamed(
        context,
        AppRoutes.analysis,
        arguments: SampleData.originalSoap,
      );
    } else {
      Navigator.pushNamed(context, AppRoutes.notFound);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: ScreenBody(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton.filledTonal(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
              iconSize: 28,
              tooltip: 'Close scanner',
              style: IconButton.styleFrom(
                fixedSize: const Size(52, 52),
                backgroundColor: scheme.secondaryContainer,
                foregroundColor: scheme.primary,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/images/scan_preview.jpg', fit: BoxFit.cover),
                  Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      heightFactor: 0.35,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.scanFrame,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Container(
                            height: 2,
                            margin: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                            ),
                            color: AppColors.scanFrame,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: AppSpacing.md,
                    top: AppSpacing.md,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.photo_camera_outlined,
                            size: 14,
                            color: Colors.white,
                          ),
                          SizedBox(width: AppSpacing.xs + 2),
                          Text(
                            'Illustrative camera preview',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: AppTextStyles.fontFamily,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: AppSpacing.md,
                    top: AppSpacing.sm + 4,
                    child: IconButton.filledTonal(
                      onPressed: () => setState(() => _flashOn = !_flashOn),
                      icon: Icon(
                        _flashOn ? Icons.flash_on : Icons.flash_off,
                      ),
                      iconSize: 20,
                      tooltip: _flashOn ? 'Turn flash off' : 'Turn flash on',
                      style: IconButton.styleFrom(
                        fixedSize: const Size(40, 40),
                        backgroundColor: scheme.secondaryContainer,
                        foregroundColor: scheme.primary,
                      ),
                    ),
                  ),
                  Positioned(
                    left: AppSpacing.md,
                    right: AppSpacing.md,
                    bottom: AppSpacing.md,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.sm + 4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Place the barcode inside the frame',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: AppTextStyles.fontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const InfoBanner(
            muted: true,
            icon: Icons.shield_outlined,
            text: 'Camera access is needed to scan barcodes. If access is '
                'denied, allow it in device settings or search by name.',
          ),
          const SizedBox(height: AppSpacing.md),
          Form(
            key: _formKey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _barcodeController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: (_) => _search(),
                    validator: ValidationUtils.validateBarcode,
                    decoration: InputDecoration(
                      hintText: 'Enter barcode manually',
                      errorMaxLines: 2,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm + 4),
                SizedBox(
                  width: 100,
                  child: TonalButton(label: 'Search', onPressed: _search),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Center(
            child: LinkText(
              label: 'Search by name instead',
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.results,
                    (route) => false,
              )
            ),
          ),
        ],
      ),
    );
  }
}
