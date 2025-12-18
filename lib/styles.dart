import 'package:flutter/material.dart';

//44 000 5909 33 -> jos electricty (prepaid meter )
const customizedNameDecoration = InputDecoration(
    labelText: 'Enter your full name here',
    contentPadding: EdgeInsets.symmetric(
    horizontal: 12, 
    vertical: 16
 ),
 floatingLabelStyle: TextStyle(
 color: Colors.black,
 fontSize: 13.5,
 ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green),
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),// default border
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(
        color: Colors.green,
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
);

const customizedUserNameDecoration = InputDecoration(
    labelText: 'Username',
    contentPadding: EdgeInsets.symmetric(
    horizontal: 12, 
    vertical: 16
 ),
 floatingLabelStyle: TextStyle(
 color: Colors.black,
 fontSize: 13.5,
 ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green),
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),// default border
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(
        color: Colors.green,
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
);

const customEmailDecoration1 = InputDecoration(
  labelText: 'Enter email here',
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
    borderSide: BorderSide(color: Colors.green),
  ),// default border
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(
        color: Colors.green,
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
);// when user is typing wrongly


///////////////////////////////////////////////////////

const customEmailDecoration2 = InputDecoration(
  labelText: 'Enter email here',
  contentPadding: EdgeInsets.symmetric(
    horizontal: 12, 
    vertical: 16
 ),
 floatingLabelBehavior: FloatingLabelBehavior.never,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(color: Colors.green),
  ),// default border
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(
        color: Colors.green,
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
);// when user is typing wrongly


const customizedPasswordDecoration2 = InputDecoration(
labelText: 'Enter Password',
border: OutlineInputBorder(),
contentPadding: EdgeInsets.symmetric(
    horizontal: 12, 
    vertical: 16
 ),
  floatingLabelBehavior: FloatingLabelBehavior.never,
   enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green),
  ),// default border
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(
        color: Colors.green,
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
);