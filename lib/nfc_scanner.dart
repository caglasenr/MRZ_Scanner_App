import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'dart:convert';
import 'dart:typed_data';

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
