import 'package:flutter/material.dart';
import 'package:first_app/ui/widgets/drawer.widget.dart';
class LoginPage extends StatelessWidget {
   LoginPage({super.key});
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:  AppBar(
         title: Text("Login Page", style: TextStyle(
           color: Colors.white
         ),),
         backgroundColor: Colors.deepOrange,
       ),
       body : Center(
         child: Container(
           alignment: Alignment.center,
           height: 800,
           width: 400,
           child: Card(
             color: Colors.white,
             child: Padding(
               padding: const EdgeInsets.all(10),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Image(image: AssetImage("images/hp.PNG")),
                   SizedBox(
                     height: 40,
                   ),
                   TextFormField(
                     controller: loginController,

                     decoration: InputDecoration(
                       //icon: Icon(Icons.lock),
                       suffixIcon: Icon(Icons.lock),
                       border: OutlineInputBorder(
                         borderSide: BorderSide(width: 1, color: Colors.deepOrange),
                          borderRadius: BorderRadius.circular(10)),
                     ),
                   ),
                   SizedBox(
                     height: 20,
                   ),
                   TextFormField(
                     controller: passwordController ,
                     obscureText: true,
                     decoration: InputDecoration(
                       //icon: Icon(Icons.lock),
                       suffixIcon: Icon(Icons.visibility),
                       border: OutlineInputBorder(
                           borderSide: BorderSide(width: 1, color: Colors.deepOrange),
                           borderRadius: BorderRadius.circular(10)),
                     ),
                   ),
                   SizedBox(
                     height: 10,
                   ),
                   Container(
                     width: double.infinity,
                     child: ElevatedButton(
                         onPressed: (){
                           String username = loginController.text;
                           String password = passwordController.text;
                           if(username== "admin" && password=="1234"){
                               Navigator.pushNamed(context, "/home");
                           }
                         },
                         child: Text("Log In", style: TextStyle(
                           fontSize: 22,
                           color: Colors.white
                         ),),
                       style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.deepOrange
                       ),

                     ),
                   )
                 ],
               ),
             ),
           ),
         ),
       )

    );
  }
}
