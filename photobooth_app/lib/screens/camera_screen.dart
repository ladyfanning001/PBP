import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:photobooth_app/screens/template_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  Future<void>? _initializeControllerFuture;
  int _countdown = 3;
  Timer? _timer;
  final List<String> _imagePaths = [];
  bool _isPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      setState(() {
        _isPermissionGranted = true;
      });
      _initializeCamera();
    } else {
      setState(() {
        _isPermissionGranted = false;
      });
    }
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _controller = CameraController(
        _cameras!.first,
        ResolutionPreset.high,
      );
      _initializeControllerFuture = _controller!.initialize();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        setState(() {
          _countdown--;
        });
      } else {
        _timer?.cancel();
        _takePicture();
      }
    });
  }

  Future<void> _takePicture() async {
    if (!_controller!.value.isInitialized) {
      return;
    }

    final path = join(
      (await getTemporaryDirectory()).path,
      '${DateTime.now()}.png',
    );

    try {
      final XFile imageFile = await _controller!.takePicture();
      _imagePaths.add(imageFile.path);

      if (_imagePaths.length < 3) {
        setState(() {
          _countdown = 3;
        });
        _startCountdown();
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TemplateScreen(imagePaths: _imagePaths),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take 3 Photos')),
      body: _isPermissionGranted
          ? FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      CameraPreview(_controller!),
                      if (_timer != null && _timer!.isActive)
                        Text(
                          '$_countdown',
                          style: const TextStyle(
                            fontSize: 120,
                            color: Colors.white,
                            fontFamily: 'PressStart2P',
                          ),
                        ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
          : const Center(
              child: Text('Camera permission denied'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_isPermissionGranted && (_timer == null || !_timer!.isActive)) {
            _startCountdown();
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
