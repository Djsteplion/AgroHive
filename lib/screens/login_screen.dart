import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/social_provider.dart';
import '../styles.dart';
import '../screens/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool rememberMe = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _errorMessage;

  void _submitLogin() async {
    if (_formKey.currentState!.validate()) {
      final socialProvider = Provider.of<SocialProvider>(context, listen: false);
      final success = socialProvider.signIn(
        _usernameController.text,
        _passwordController.text,
        
      );

      if (success) {
        // Navigate to HomeScreen on successful login
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        setState(() {
          _errorMessage = 'Invalid username or password.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(15, 30, 15, 30),
          child: Form(
            key: _formKey,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child:Text(
                'Log In',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
               ),
              ),
              Center(
                child:Text(
                'Enter details below to log in to account',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ),
              const SizedBox(height: 23),
          
              Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'UserName',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
              TextFormField(
                controller: _usernameController,
                decoration: customizedUserNameDecoration,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  if (value.length < 4) {
                    return 'Username must be at least 4 characters long';
                  }
                  return null;
                },
              ),
                  const SizedBox(height: 25),
                  
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Password',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                labelText: 'Enter Password',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                suffixIcon: IconButton(
                            icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
                weight: 100,
                            ),
                            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
                            } ,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12, 
                            vertical: 16
                         ),
                          floatingLabelStyle: TextStyle(
                         color: Colors.black,
                         fontSize: 13.5,
                         ),
                           enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: Color.fromARGB(255, 28, 98, 6)),
                          ),// default border
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                color: Color.fromARGB(255, 28, 98, 6),
                width: 2,
                            )
                          ), //border when user is allegedly typing correctly 
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: Colors.red)
                          ),// when user has typed wrongly or left field blank 
                            focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: Colors.red)
                          ),
                    ),
                    
                      validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height:10),
                        
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (bool? value){
                              setState(() {
                                rememberMe = value ?? false;
                              });
                            },
                            activeColor: Colors.grey,
                            checkColor: Colors.grey,
                            fillColor: WidgetStateProperty.all(Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                                setState(() {
                                rememberMe = true;
                              });
                            },
                            child: Text(
                            'Remember me',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          ),
                        ],
                       ),
                      ),
                        
                      GestureDetector(
                        onTap: (){
                          // onTap logic
                        },
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: Color.fromARGB(255, 28, 98, 6),
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                  const SizedBox(height:40),
                  GestureDetector(
                    onTap: () {
                        _submitLogin();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical:22),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 28, 98, 6),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child:Center(
                        child:Text(
                        'Log in',
                        style:TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        )
                      ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                        
                 Center(
                  child: Text(
                    'or Log in with',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 18.5,
                    ),
                  ),
                 ),
                  SizedBox(height: 16),
                        
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap:() {
                        //
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/google_img.png'),
                              fit: BoxFit.cover,
                          )
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap:() {
                        //
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/apple_image.png'),
                            fit: BoxFit.cover,
                          )
                        ),
                      )
                    )
                  ],
                ),
                SizedBox(height: 20),
                        
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?" ,
                          style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18.5,
                          fontWeight: FontWeight.w400,
                        ),
                    ),
                    GestureDetector(
                      onTap: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignupScreen()),
                          );
                      },
                      child: Container(
                        margin: EdgeInsets.only(left:7),
                        child: Text(
                        'sign up',
                        style: TextStyle(
                          color: Color.fromARGB(255, 28, 98, 6),
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ),
                    ),
                  ],
                ),
                ],
              ),
            ],
          )
            /*
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _submitLogin,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Navigate to the SignupScreen
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: const Text("Don't have an account? Sign Up"),
                ),
              ],
            )
            */
            ,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
