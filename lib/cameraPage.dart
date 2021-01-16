import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scavenger/dTypes.dart';
import 'dart:io';
import 'dart:async';

import 'package:camera/camera.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

import 'package:scavenger/reqs.dart';
import 'package:scavenger/globals.dart' as globals;

Future<void> openCameraPage(context, mem, g, l, callback) async {
  final cameras = await availableCameras();
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CameraPage(
              mem: mem, g: g, cams: cameras, l: l, callback: callback)));
}

Future<List<String>> takePicture(initController, controller, context) async {
  try {
    await initController;
    //Make path
    final path =
        join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');

    await controller.takePicture(path);

    final bin = await File(path).readAsBytes();
    String encoded = base64Encode(bin);
    print("ENCODED LENGTH: " + encoded.length.toString());
    List labels = await getLabels(encoded);

    Navigator.pop(context);
    return labels;
  } catch (error) {
    // SOMETHING WENT WRONG
    print(error);
    return [];
  }
}

class CameraPage extends StatefulWidget {
  final MainMem mem;
  final Game g;
  final cams;
  List<String> l;
  Function callback;
  CameraPage(
      {Key key,
      @required this.mem,
      @required this.g,
      @required this.cams,
      @required this.l,
      @required this.callback})
      : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController controller;
  Future<void> initController;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cams.first, ResolutionPreset.medium);
    initController = controller.initialize();
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Capture your find!")),
      body: FutureBuilder<void>(
          //AS DEMONSTRATED HERE https://flutter.dev/docs/cookbook/plugins/picture-using-camera
          future: initController,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(controller);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      /* persistentFooterButtons: [
        IconButton(icon: Icon(Icons.camera), onPressed: () {})
      ], */ //UGLY
      floatingActionButton: Container(
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white54),
          child: IconButton(
              iconSize: 40,
              icon: Icon(Icons.camera),
              onPressed: () async {
                widget.l.addAll(
                    await takePicture(initController, controller, context));
                print("Pic taken. L: " + widget.l.toString());
                globals.gamePageSetState();
              })),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
