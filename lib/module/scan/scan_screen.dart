import 'dart:io';

import 'package:base_project/module/scan/scan_controller.dart';
import 'package:base_project/shared/widgets/dot_loading.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/resources/resource.dart';
import '../../shared/resources/string.dart';
import '../../shared/utils/util.dart';
import '../../shared/widgets/widgets.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScanController scanController = ScanController();
    CameraController? cameraController;

    Future<void> initCamera() async {
      final cameras = await availableCameras();
      cameraController =
          CameraController(cameras.first, ResolutionPreset.high);

      await cameraController!.initialize();
      scanController.updateState();
    }

    Future<void> takePicture() async {
      if (!cameraController!.value.isInitialized) return;

      try {
        final XFile file = await cameraController!.takePicture();
        scanController.setCaptureImage(file);
      } catch (e) {
        debugPrint("Error when taking picture: $e");
      }
    }

    Future<void> pickImageFromGallery() async {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        scanController.setCaptureImage(pickedFile);
      }
    }

    Widget buildGetResultWidget() {
      return Column(
        children: [
          BBSGesture(
            onTap: () {
              scanController.onClickGetResult(onCheckInternet: (bool canGetResult) async {
                final bool networkConnected = await isNetworkConnected();
                if (networkConnected) {
                  if (canGetResult) {
                    scanController.getResult();
                  } else {

                  }
                } else {
                  const snackBar = SnackBar(content: Text(noInternetConnection));
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
              });
            },
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 22),
                padding: const EdgeInsets.symmetric(vertical: 14),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                  color: AppColors.colorFF34A853,
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.hardEdge,
                child: const Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BBSText(
                          content: getResult,
                          color: Colors.white,
                          textAlign: TextAlign.center,
                          fontSize: 18,
                          fontFamily: 'dmsans_bold',),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BBSImage(
                          padding: EdgeInsets.only(right: 12),
                          Constants.icSearch,
                          height: 30,
                          width: 30,
                          color: AppColors.white,
                          fit: BoxFit.scaleDown,
                        ),
                      ],
                    )
                  ],
                )
            ),
          ),
          BBSGesture(
            onTap: () {
              print('aaa');
            },
            child: Container(
              margin: const EdgeInsets.only(left: 22, right: 22, top: 16),
              padding: const EdgeInsets.symmetric(vertical: 14),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: Colors.white,
                      width: 1.0
                  )
              ),
              clipBehavior: Clip.hardEdge,
              child: const Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BBSText(
                        content: takeAnotherPhoto,
                        color: Colors.white,
                        textAlign: TextAlign.center,
                        fontSize: 18,
                        fontFamily: 'dmsans_bold',),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BBSImage(
                        padding: EdgeInsets.only(right: 12),
                        Constants.icTakeAnother,
                        height: 30,
                        width: 30,
                        color: AppColors.white,
                        fit: BoxFit.scaleDown,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget buildAiAnalyzing() {
      return Container(
        decoration: const BoxDecoration(
            color: Colors.black
        ),
        width: MediaQuery.of(context).size.width,
        child: const Column(
          children: [
            BBSImage(
              padding: EdgeInsets.only(top: 50),
              Constants.icScanAi,
              height: 70,
              width: 70,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: DotsLoading(),
            ),
            BBSText(
              margin: EdgeInsets.only(top: 10, bottom: 70),
              content: aiIsAnalyzing,
              color: Colors.white,
              textAlign: TextAlign.center,
              fontSize: 18,
              fontFamily: 'dmsans_bold',),
          ],
        ),
      );
    }

    return BBSBaseScaffold<ScanController>(
      controller: scanController,
      backgroundColor: Colors.black,
      initState: (controller) {
        initCamera();
      },
      onDispose: (controller) {
        cameraController?.dispose();
      },
      builder: (controller) {
        return SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  // Top bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child:
                    Stack(
                      children: [
                        BBSImage(
                          Constants.icCancel,
                          height: 20,
                          width: 20,
                          onTap: () {
                            Navigators.pop(context);
                          },
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(uploadOrCaptureRoom,
                                style: TextStyle(color: Colors.white, fontSize: 19, fontFamily: 'dmsans_bold')),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Camera preview
                  Container(
                    // margin: const EdgeInsets.symmetric(horizontal: 8),
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: cameraController != null &&
                        cameraController!.value.isInitialized
                        ? scanController.capturedImage != null
                        ? Image.file(
                      File(scanController.capturedImage!.path),
                      height: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    )
                        : FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width,
                        child: CameraPreview(cameraController!),
                      ),
                    )
                        : const Center(),
                  ),
                  const SizedBox(height: 50,),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: scanController.capturedImage == null ? Stack(
                      children: [
                        const BBSImage(
                          padding: EdgeInsets.only(left: 17, top: 22.5, bottom: 22.5),
                          Constants.icPhotoStorage,
                          height: 40,
                          width: 40,

                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BBSGesture(
                              onTap: () {
                                print('bbb');
                              },
                              child: BBSImage(
                                Constants.icTakeCapture,
                                height: 85,
                                width: 85,
                                // onTap: () {
                                //   takePicture();
                                // },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ) : Visibility(visible: !scanController.isShowSearching, child: buildGetResultWidget())
                  ),
                ],
              ),
              if (scanController.isShowSearching)
                Positioned(
                    bottom: 0,
                    child: buildAiAnalyzing()
                ),
            ],
          ),
        );
      },
    );
  }
}
