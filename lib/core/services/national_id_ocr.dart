import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tesseract_ocr/ocr_engine_config.dart';
import 'package:tesseract_ocr/tesseract_ocr.dart';

class NationalIdOcr {
  NationalIdOcr({required this.imagePicker});
  final ImagePicker imagePicker;

  Future<NationalIdScanResult?> recognize({required ImageSource source}) async {
    final image = await imagePicker.pickImage(
      source: source,
      imageQuality: 100,
      maxWidth: 2400,
      maxHeight: 2400,
    );
    if (image == null) return null;
    final recognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final generatedPaths = <String>[];
    try {
      final imagePaths = <String>[image.path];
      final enhancedPaths = await _createEnhancedImagePaths(image);
      generatedPaths.addAll(enhancedPaths);
      imagePaths.addAll(enhancedPaths);

      for (final imagePath in imagePaths) {
        try {
          final tesseractText = await TesseractOcr.extractText(
            imagePath,
            config: const OCRConfig(
              language: 'ara+eng',
              engine: OCREngine.tesseract,
            ),
          );
          final tesseractResult = extractNationalIdScanResult(tesseractText);
          if (tesseractResult != null) return tesseractResult;
        } catch (_) {
          // ML Kit remains the fallback if the local Arabic model is unavailable.
        }

        final result = await recognizer.processImage(
          InputImage.fromFilePath(imagePath),
        );
        final scanResult = extractNationalIdScanResult(result.text);
        if (scanResult != null) return scanResult;
      }
      return null;
    } finally {
      await recognizer.close();
      for (final generatedPath in generatedPaths) {
        final generatedFile = File(generatedPath);
        if (await generatedFile.exists()) {
          await generatedFile.delete();
        }
      }
    }
  }

  Future<List<String>> _createEnhancedImagePaths(XFile source) async {
    final decoded = img.decodeImage(await source.readAsBytes());
    if (decoded == null) return const [];

    final oriented = img.bakeOrientation(decoded);
    final enlarged = img.copyResize(
      oriented,
      width: oriented.width < 1800 ? 1800 : oriented.width,
      interpolation: img.Interpolation.cubic,
    );
    final enhanced = img.contrast(img.grayscale(enlarged), contrast: 150);
    final lowerSection = img.copyCrop(
      enhanced,
      x: 0,
      y: (enhanced.height * 0.58).round(),
      width: enhanced.width,
      height: (enhanced.height * 0.42).round(),
    );

    final directory = await getTemporaryDirectory();
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final fullPath = '${directory.path}/national_id_full_$timestamp.jpg';
    final lowerPath = '${directory.path}/national_id_lower_$timestamp.jpg';
    await File(fullPath).writeAsBytes(img.encodeJpg(enhanced, quality: 96));
    await File(
      lowerPath,
    ).writeAsBytes(img.encodeJpg(lowerSection, quality: 96));
    return [fullPath, lowerPath];
  }
}

class NationalIdScanResult {
  const NationalIdScanResult({required this.nationalId, this.fullName});

  final String nationalId;
  final String? fullName;
}

NationalIdScanResult? extractNationalIdScanResult(String text) {
  final nationalId = extractNationalIdFromText(text);
  if (nationalId == null) return null;
  return NationalIdScanResult(
    nationalId: nationalId,
    fullName: extractNameFromOcrText(text),
  );
}

String? extractNationalIdFromText(String text) {
  final normalized = text
      .replaceAllMapped(
        RegExp(r'[٠-٩]'),
        (match) => '${match.group(0)!.codeUnitAt(0) - 0x0660}',
      )
      .replaceAllMapped(
        RegExp(r'[۰-۹]'),
        (match) => '${match.group(0)!.codeUnitAt(0) - 0x06F0}',
      )
      .replaceAll(RegExp(r'[^0-9\s]'), ' ');
  final match = RegExp(r'(?<!\d)\d{14}(?!\d)').firstMatch(normalized);
  if (match != null) return match.group(0);

  final sourceLines = text.split(RegExp(r'[\r\n]+'));
  final normalizedLines = normalized.split(RegExp(r'[\r\n]+'));
  for (var index = 0; index < normalizedLines.length; index++) {
    final line = normalizedLines[index];
    final sourceLine = sourceLines[index];
    final digitsOnly = line.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.length == 14 &&
        RegExp(r'\d').hasMatch(line) &&
        !RegExp(r'[A-Za-z]').hasMatch(sourceLine)) {
      return digitsOnly;
    }
  }
  return null;
}

String? extractNameFromOcrText(String text) {
  final candidates = text
      .split(RegExp(r'[\r\n]+'))
      .map((line) => line.trim().replaceAll(RegExp(r'\s+'), ' '))
      .where((line) {
        final words = line.split(' ');
        final isArabicName = RegExp(
          r"^[\u0600-\u06FF][\u0600-\u06FF .'-]+$",
        ).hasMatch(line);
        final isLatinName = RegExp(r"^[A-Za-z][A-Za-z .'-]+$").hasMatch(line);
        return words.length >= 2 &&
            line.isNotEmpty &&
            !RegExp(r'\d').hasMatch(line) &&
            (isArabicName || isLatinName);
      })
      .toList();
  if (candidates.isEmpty) return null;
  candidates.sort((a, b) => b.length.compareTo(a.length));
  return candidates.first;
}
