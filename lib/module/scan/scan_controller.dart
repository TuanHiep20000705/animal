import 'dart:io';

import 'package:base_project/shared/resources/resource.dart';
import 'package:base_project/shared/widgets/bbs_base_controller.dart';
import 'package:camera/camera.dart';
import 'dart:developer';
import 'dart:typed_data';
import 'package:google_generative_ai/google_generative_ai.dart';

class ScanController extends BBSBaseController {
  bool _isShowSearching = false;

  bool get isShowSearching => _isShowSearching;

  XFile? _capturedImage;

  XFile? get capturedImage => _capturedImage;

  bool _canGetResult = true;

  bool get canGetResult => _canGetResult;

  void setCaptureImage(XFile xFile) {
    _capturedImage = xFile;
    notifyListeners();
  }

  void updateState() {
    notifyListeners();
  }

  Future<void> onClickGetResult({required Function(bool) onCheckInternet}) async {
    onCheckInternet(_canGetResult);
  }

  Future<void> getResult() async {
    const prompt = '''
You are a stone expert (geologist/mineralogist) who analyzes and describes any type of stone—gemstones, minerals, rocks, and crystals—based on its name and properties.
Use this exact structure:
{"GemstoneName":"string","RarityScore":number,"EstimatedValuePerCarat":{"FairQuality":number,"GoodQuality":number,"VeryGoodQuality":number},"Definition":"string","Identification":"string","CommonUses":["string1","string2"]}
Important rules:
- The descriptive sentences in Identification are separated by ". "
- The names and strings must preserve all spaces
- No formatting (remove all newlines, tabs, spaces)
- No explanatory text
- No code blocks (```json```)
- Never include trailing commas
- Escape special characters in strings
- Use double quotes ONLY
''';

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey:
          Constants.geminiApiKey,
    );

    try {
      var json = '';
      Uint8List imageBytes = await File(_capturedImage!.path).readAsBytes();
      final content = [
        Content.multi([
          TextPart(prompt),
          DataPart('image/png', imageBytes),
        ])
      ];

      final stream = model.generateContentStream(content);

      _isShowSearching = true;
      notifyListeners();

      await for (final response in stream) {
        if (response.text != null) {
          json += response.text!;
        }
      }

      log(">>> Done, result: $json");
    } catch (e, st) {
      log("Fail when call gemini: $e", stackTrace: st);
    } finally {
      _isShowSearching = false;
      notifyListeners();
    }
  }
}
