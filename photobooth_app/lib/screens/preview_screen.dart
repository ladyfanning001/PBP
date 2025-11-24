import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PreviewScreen extends StatefulWidget {
  final List<String> imagePaths;
  final String template;

  const PreviewScreen({
    super.key,
    required this.imagePaths,
    required this.template,
  });

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  Uint8List? _composedImage;

  @override
  void initState() {
    super.initState();
    _composeImage();
  }

  Future<void> _composeImage() async {
    // This is a placeholder for the actual template image.
    // The user will provide the templates later.
    // For now, we will create a blank white image with a 5x15 cm aspect ratio.
    const int stripWidth = 500;
    const int stripHeight = 1500;

    final composedImage = img.Image(width: stripWidth, height: stripHeight);
    img.fill(composedImage, color: img.ColorRgb8(255, 255, 255));

    final int photoHeight = stripHeight ~/ 3;

    for (int i = 0; i < widget.imagePaths.length; i++) {
      final imageBytes = await File(widget.imagePaths[i]).readAsBytes();
      final image = img.decodeImage(imageBytes);
      if (image != null) {
        final resizedImage = img.copyResize(image, width: stripWidth, height: photoHeight);
        img.compositeImage(
          composedImage,
          resizedImage,
          dstY: i * photoHeight,
        );
      }
    }

    setState(() {
      _composedImage = Uint8List.fromList(img.encodePng(composedImage));
    });
  }

  Future<void> _downloadImage() async {
    if (_composedImage == null) return;
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/photobooth_${DateTime.now()}.png';
    final file = File(path);
    await file.writeAsBytes(_composedImage!);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Image saved to $path')),
    );
  }

  Future<void> _shareImage() async {
    if (_composedImage == null) return;
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/photobooth_share.png';
    final file = File(path);
    await file.writeAsBytes(_composedImage!);
    await Share.shareXFiles([XFile(path)], text: 'Check out my photobooth picture!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
      ),
      body: Center(
        child: _composedImage == null
            ? const CircularProgressIndicator()
            : Image.memory(_composedImage!),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.download),
              onPressed: _downloadImage,
            ),
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: _shareImage,
            ),
          ],
        ),
      ),
    );
  }
}
