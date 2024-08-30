/*import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'camera_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CameraApp(camera: firstCamera),
  ));
}*/

/*import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NFC Tarayıcı',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NfcReaderScreen(),
    );
  }
}

class NfcReaderScreen extends StatefulWidget {
  @override
  _NfcReaderScreenState createState() => _NfcReaderScreenState();
}

class _NfcReaderScreenState extends State<NfcReaderScreen> {
  String _nfcData = 'NFC verisi bekleniyor...';

  Future<void> readNFC() async {
    try {
      NFCTag tag = await FlutterNfcKit.poll();  // NFC etiketini tarar
      String tagData = await FlutterNfcKit.transceive('00A4040000');  // Veriyi çipten okur
      setState(() {
        _nfcData = 'Okunan NFC Verisi: $tagData';
      });
    } catch (e) {
      setState(() {
        _nfcData = 'NFC okuma hatası: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NFC Tarayıcı'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _nfcData,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: readNFC,
              child: Text('NFC ile Tara'),
            ),
          ],
        ),
      ),
    );
  }
}

String parseNfcData(String hexData) {
  // Hexadecimal string'i byte array'e dönüştürme
  Uint8List byteArray = hexStringToByteArray(hexData);

  // Byte array'i UTF-8 stringe dönüştürme (veya başka bir uygun format)
  String dataString = utf8.decode(byteArray, allowMalformed: true);

  return dataString;
}

Uint8List hexStringToByteArray(String hexString) {
  final length = hexString.length;
  final bytes = Uint8List(length ~/ 2);

  for (int i = 0; i < length; i += 2) {
    bytes[i ~/ 2] = int.parse(hexString.substring(i, i + 2), radix: 16);
  }

  return bytes;
}*/
/*import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'dart:convert';
import 'dart:typed_data';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NFC ile Kimlik Tarama',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ana Ekran'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NfcReaderScreen()),
            );
          },
          child: Text('Tarayıcıya Git'),
        ),
      ),
    );
  }
}

class NfcReaderScreen extends StatefulWidget {
  @override
  _NfcReaderScreenState createState() => _NfcReaderScreenState();
}

class _NfcReaderScreenState extends State<NfcReaderScreen> {
  String _nfcData = 'NFC verisi bekleniyor...';

  Future<void> readNFC() async {
    try {
      // NFC etiketini tarar
      NFCTag tag = await FlutterNfcKit.poll();

      // Çipten veri okur
      String tagData = await FlutterNfcKit.transceive('00A4040000');

      // Hexadecimal veriyi çözümleyip stringe dönüştürür
      String parsedData = hexStringToString(tagData);

      setState(() {
        _nfcData = 'Okunan NFC Verisi: $parsedData';
      });
    } catch (e) {
      setState(() {
        _nfcData = 'NFC okuma hatası: $e';
      });
    }
  }

  // Hexadecimal string'i ASCII string'e dönüştürür
  String hexStringToString(String hexString) {
    final bytes = hexStringToByteArray(hexString);
    return utf8.decode(bytes, allowMalformed: true);
  }

  // Hexadecimal string'i byte array'e dönüştürür
  Uint8List hexStringToByteArray(String hexString) {
    final length = hexString.length;
    final bytes = Uint8List(length ~/ 2);

    for (int i = 0; i < length; i += 2) {
      bytes[i ~/ 2] = int.parse(hexString.substring(i, i + 2), radix: 16);
    }

    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NFC Tarayıcı'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _nfcData,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: readNFC,
              child: Text('NFC ile Tara'),
            ),
          ],
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'nfc_scanner.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NFC ile Kimlik Tarama',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ana Ekran'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NfcReaderScreen()),
            );
          },
          child: Text('Tarayıcıya Git'),
        ),
      ),
    );
  }
}
class NfcReaderScreen extends StatefulWidget {
  @override
  _NfcReaderScreenState createState() => _NfcReaderScreenState();
}

class _NfcReaderScreenState extends State<NfcReaderScreen> {
  String _nfcData = 'NFC verisi bekleniyor...';

  Future<void> readNFC() async {
    try {
      // NFC etiketini tarar
      NFCTag tag = await FlutterNfcKit.poll();

      // Çipten veri okur
      String tagData = await FlutterNfcKit.transceive('00A4040000');
      // Ham NFC verisini göster
      print('Ham NFC Verisi: $tagData');

      // Veriyi UTF-8 olarak çözümleyip stringe dönüştürür
      String parsedData = utf8.decode(tagData.codeUnits);

      setState(() {
        _nfcData = 'Okunan NFC Verisi: $parsedData';
      });
    } catch (e) {
      setState(() {
        _nfcData = 'NFC okuma hatası: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NFC Tarayıcı'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _nfcData,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: readNFC,
              child: Text('NFC ile Tara'),
            ),
          ],
        ),
      ),
    );
  }
}
