import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'recognize_text.dart';



class CameraApp extends StatefulWidget {
  final CameraDescription camera;

  const CameraApp({Key? key, required this.camera}) : super(key: key);

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  File? imageFile;
  Rect? frameRect;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _cameraController.initialize();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        frameRect = Rect.fromLTWH(
          MediaQuery.of(context).size.width * 0.25,
          MediaQuery.of(context).size.height * 0.5 - 25,
          250,
          50,
        );
      });
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _captureAndRecognizeText(BuildContext context) async {
    await RecognizeText.captureAndRecognizeText(
      context: context,
      cameraController: _cameraController,
      initializeControllerFuture: _initializeControllerFuture,
      setImageFile: (file) {
        setState(() {
          imageFile = file;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Anasayfa")),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return OrientationBuilder(
              builder: (context, orientation) {
                return Stack(
                  children: [
                    Center(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: CameraPreview(_cameraController),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: orientation == Orientation.portrait ? 300 : 100,
                        height: orientation == Orientation.portrait ? 100 : 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () => _captureAndRecognizeText(context),
                          child: const Text("Fotoğraf Çek"),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

