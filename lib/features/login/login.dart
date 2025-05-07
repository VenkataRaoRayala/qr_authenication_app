import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qrbasedauthenication/features/qr_scanner.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => QrScanner(),));
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    final emailEditingController = TextEditingController();
    final passwordEditingController = TextEditingController();
    return Column(children: [
       TextFormField(
         controller: emailEditingController,
         decoration: const InputDecoration(
           border: OutlineInputBorder(),
           labelText: 'Email',
         ),
       ),
      TextFormField(
        controller: passwordEditingController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Password',
        ),
      ),
      SizedBox(height: 20,),
      ElevatedButton(onPressed: () async{
        try {
           await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailEditingController.text,
            password: passwordEditingController.text,
          ).then((value) {
            if(value.user!=null){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QrScanner(),));
            }
          },);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            print('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
          }
        } catch (e) {
          print(e);
        }


      }, child: Text('Sign In'))
    ],);
  }
}
