import 'package:flutter/material.dart';

class MRZDetailsPage extends StatelessWidget {
  final String name;
  final String surname;
  final String identificationNumber;
  final String birthDate;
  final String gender;
  //final String genderCode;

  const MRZDetailsPage({
    Key? key,
    required this.name,
    required this.surname,
    required this.identificationNumber,
    required this.birthDate,
    required this.gender,
    //required this.genderCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MRZ Bilgileri"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration:BoxDecoration(
                  color: Colors.blue,
                ),
                width: 120,
                height: 150,
              ),
            ),*/
            SizedBox(height:40 ,),
            Text(
              'İsim: $name',
               style: TextStyle(
                 fontSize: 20
               ),),
            SizedBox(height:10 ,),
            Text(
                'Soyisim: $surname',
              style: TextStyle(
                  fontSize: 20
              ),),
            SizedBox(height:10 ,),
            Text(
              'Kimlik Numarası: $identificationNumber',
              style: TextStyle(
                  fontSize: 20
              ),),
            SizedBox(height:10 ,),
            Text(
                'Doğum Tarihi: $birthDate',
              style: TextStyle(
                  fontSize: 20
              ),),
            SizedBox(height:10 ,),
            Text(
                'Cinsiyet: $gender',
              style: TextStyle(
                  fontSize: 20
              ),),
            //Text('Cinsiyet kodu:$genderCode ')
          ],
        ),
      ),
    );
  }
}

