import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late TabController _tabController;
  CameraController? _cameraController;
  late List<CameraDescription> cameras;
  final List<XFile> _pictures = [];
  late Future<void> initCam;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    initCam = initCamera();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (!_cameraController!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _cameraController!.dispose();
    } else if (state == AppLifecycleState.resumed) {
      await initCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _tabController.index == 1 ? 'Images gallery' : 'Camera preview'),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FutureBuilder(
            future: initCam,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return _cameraController!.value.isInitialized
                    ? CameraPreview(_cameraController!)
                    : const SizedBox();
              }
              return const SizedBox();
            },
          ),
          ListView.builder(
            itemCount: _pictures.length,
            itemBuilder: ((context, index) {
              return Image.file(
                File(_pictures[index].path),
                fit: BoxFit.fitWidth,
              );
            }),
          ),
        ],
      ),
      floatingActionButton: _tabController.index == 1
          ? null
          : FloatingActionButton(
              onPressed: () async {
                _pictures.add(await _cameraController!.takePicture());
                setState(() {});
              },
              tooltip: 'Snapshot',
              child: const Icon(Icons.camera),
            ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _tabController.index,
          onTap: (value) {
            setState(() {
              _tabController.index = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: 'Camera',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.image),
              label: 'Gallery',
            ),
          ]),
    );
  }

  @override
  void dispose() {
    _cameraController!.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.max);
    await _cameraController!.initialize();
    setState(() {});
  }
}
