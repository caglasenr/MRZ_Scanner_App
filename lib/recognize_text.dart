import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:mrz_scanner_app/mrz_details_page.dart';


class RecognizeText {
  static Future<void> captureAndRecognizeText({
    required BuildContext context,
    required CameraController cameraController,
    required Future<void> initializeControllerFuture,
    required Function(File) setImageFile,
  }) async {
    try {
      await initializeControllerFuture;
      final image = await cameraController.takePicture();

      final imageFile = File(image.path);
      setImageFile(imageFile);

      final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
      final inputImage = InputImage.fromFile(imageFile);
      final recognizedText = await textRecognizer.processImage(inputImage);

      String text = recognizedText.text;
      textRecognizer.close();

      List<String> mrzLines = text.split('\n');
      if (mrzLines.length >= 3) {
        String line1 = mrzLines[0];
        String line2 = mrzLines[1];
        String line3 = mrzLines[2];

        String identificationNumber = line1.substring(16,27).replaceAll('<', ''); // Kimlik Numarası
        String birthDate = line2.substring(0, 6); // Doğum Tarihi
        String genderCode = line2.substring(7,9); // Cinsiyet

        String yearPart = birthDate.substring(0, 2);
        String monthPart = birthDate.substring(2, 4);
        String day = birthDate.substring(4, 6);

        int surnameEndIndex = line3.indexOf('<'); // İlk < işareti görülene kadar git
        String surname = line3.substring(0, surnameEndIndex); // İlk < işaretine kadar olan karakterleri al

        int nameStartIndex = line3.indexOf('<', surnameEndIndex + 1) + 1; // İsim ve soyisim arasında iki adet < var, ismin başlangıcını bul
        int nameEndIndex = line3.indexOf('<', nameStartIndex); // İsim başlangıcından son < işaretine kadar olan karakterleri al

        if (nameEndIndex == -1) { // İsimden sonra 3. satırda ikinci < işareti bulunmaz ise ismin bitişi üçüncü satır uzunluğu olur
          nameEndIndex = line3.length;
        }
        String name = line3.substring(nameStartIndex, nameEndIndex);

        int currentYear = DateTime.now().year % 100;
        int year = int.parse(yearPart);

        if (year <= currentYear) { // Yıl bilgisi şu anki yıldan küçük ise 2000 ve sonraki doğum tarihleri için
          year += 2000;
        } else { // Yıl bilgisi şu anki yıldan büyük ise 1999 ve önceki doğum tarihleri için
          year += 1900;
        }

        List<String> months = [
          'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
          'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'
        ];
        int monthIndex = int.parse(monthPart) - 1;
        String month = monthIndex >= 0 && monthIndex < 12 ? months[monthIndex] : "Geçersiz";

        String gender = genderCode.trim() == 'F' ? 'Kadın' : 'Erkek';

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MRZDetailsPage(
              name: name,
              surname: surname,
              identificationNumber: identificationNumber,
              birthDate: "$day $month $year",
              gender: gender,
              //genderCode:genderCode,
            ),
          ),
        );
      }

      print("Tanınan Metin: $text");
    } catch (e) {
      print("Hata: $e");
    }
  }
}
