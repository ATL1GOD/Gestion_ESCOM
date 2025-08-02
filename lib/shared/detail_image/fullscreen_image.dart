import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestion_escom/core/utils/colors.dart';

class DetalleImagenScreen extends StatefulWidget {
  final String imagePath;
  final String? title;

  const DetalleImagenScreen({super.key, required this.imagePath, this.title});

  @override
  State<DetalleImagenScreen> createState() => _DetalleImagenScreenState();
}

class _DetalleImagenScreenState extends State<DetalleImagenScreen> {
  late TransformationController _transformationController;
  bool _isUiVisible = true;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  void _toggleUiVisibility() {
    setState(() {
      _isUiVisible = !_isUiVisible;
      if (_isUiVisible) {
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: SystemUiOverlay.values,
        );
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AnimatedOpacity(
          opacity: _isUiVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 250),
          child: AppBar(
            title: widget.title != null ? Text(widget.title!) : null,
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: AppColors.white),
            titleTextStyle: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        onTap: _toggleUiVisibility,
        onDoubleTap: () {
          setState(() {
            _transformationController.value = Matrix4.identity();
          });
        },
        child: Center(
          child: Hero(
            tag: widget.imagePath,
            child: InteractiveViewer(
              transformationController: _transformationController,
              panEnabled: true,
              minScale: 0.5,
              maxScale: 4.0,
              child: Image.asset(widget.imagePath, fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    );
  }
}
