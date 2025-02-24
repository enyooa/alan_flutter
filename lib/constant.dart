import 'package:flutter/material.dart';

// const baseUrl = 'http://192.168.1.67:8000/api/';
// const websocketIp = '192.168.1.67';

//  const baseUrl = 'http://127.0.0.1:8000/api/';
const baseUrl = 'https://alantrade.kz/api/';
const basePhotoUrl = 'https://alantrade.kz/';

// const webSocketUrl = '185.22.65.56';
// const webSocketUrl = '192.168.1.67';
// const basePhotoUrl = 'http://192.168.1.67:8000/';

const primaryColor = Color(0xFF0288d1);
const accentColor = Color(0xFF0288d1);
const backgroundColor = Color(0xFFF1F3F8);
const borderColor = Color(0xFFD1D9E6);
const unselectednavbar = Colors.grey;
const Color errorColor = Color(0xFFB00020); // Red
const Color textColor = Colors.black87; // Default text color

// Define text styles
const TextStyle headingStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w100,
  color: Colors.white,
  
);

const TextStyle titleStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w100,
  color: Colors.black,
  
);

const TextStyle subheadingStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

const TextStyle bodyTextStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.normal,
  color: Colors.black,
);

const TextStyle captionStyle = TextStyle(
  fontSize: 10,
  fontWeight: FontWeight.w400,
  color: Colors.grey,
);

const TextStyle buttonTextStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);

const TextStyle formLabelStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w600,
  color: Colors.black87,
);

// Table styles
const TextStyle tableHeaderStyle = TextStyle(
  fontSize: 10,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const TextStyle tableCellStyle = TextStyle(
  fontSize: 10,
  fontWeight: FontWeight.normal,
  color: Colors.black87,
);

// Padding constants
const double horizontalPadding = 16.0;
const double verticalPadding = 12.0;
const EdgeInsets pagePadding = EdgeInsets.all(16.0);
const EdgeInsets elementPadding = EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0);
const EdgeInsets buttonPadding = EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0);

// Border styles
const BorderSide tableBorderSide = BorderSide(color: borderColor, width: 1.0);

final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: primaryColor,
  foregroundColor: Colors.white,
  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
);