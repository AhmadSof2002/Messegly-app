import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:messegly/shared/styles/colors.dart';
import 'package:messegly/shared/styles/custom_icons_icons.dart';

Widget defaultTextButton(
        {required void Function()? onPressed,
        required String? text,
        Color? color = defaultColor,
        double? size = 15,
        FontWeight? fontWeight}) =>
    TextButton(
        onPressed: onPressed,
        child: Text('$text',
            style: GoogleFonts.montserrat(
                color: color, fontSize: size, fontWeight: fontWeight)));

Widget defaultTextFormField(
        {void Function(String)? onChange,
        void Function(String)? onSubmit,
        Function()? suffixPressed,
        required String? hintText,
        Color? hintColor,
        Color? prefixColor,
        IconData? suffixIcon,
        IconData? prefixIcon,
        bool isPass = false,
        TextEditingController? controller,
        String? Function(String?)? validate,
        double? radius = 10,
        bool? isFilled}) =>
    TextFormField(
      decoration: InputDecoration(
        suffixIcon: suffixIcon != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffixIcon))
            : null,
        prefixIcon: Icon(
          prefixIcon,
          color: prefixColor,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius!),
        ),
        hintStyle: GoogleFonts.montserrat(
            color: Colors.white60, fontWeight: FontWeight.bold),
        hintText: hintText,
        filled: isFilled,
        fillColor: Colors.white70,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10.0)),
      ),
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      obscureText: isPass,
      controller: controller,
      validator: validate,
    );

void navigateTo(BuildContext context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

void toastMessage({
  required String msg,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget defaultButton({
  double width = double.infinity,
  double radius = 10,
  Color color = Colors.blue,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      height: 40,
      width: width,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        elevation: 5,
        onPressed: function,
        color: color,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
    );

Widget defaultAppBar(
        {required BuildContext context,
        String? title,
        List<Widget>? actions,
        void Function()? leadButtonFunc}) =>
    AppBar(
      title: Text('${title}'),
      actions: actions,
      titleSpacing: 5.0,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            leadButtonFunc!();
          },
          icon: Icon(CustomIcons.Arrow___Left_2)),
    );
