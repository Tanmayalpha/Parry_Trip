import 'package:flutter/material.dart';
import 'package:parry_trip2/constants/app_colors.dart';

class Btn extends StatelessWidget {
  final String? title;
  final VoidCallback? onPress;
  double? height;
  double? width;
  double? fSize;
  IconData? icon;
  Btn(
      {Key? key,
      this.title,
      this.onPress,
      this.height,
      this.width,
      this.fSize,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.red,
                Colors.redAccent
                /*colors.grad1Color,
                colors.grad2Color,*/
              ],
              stops: [
                0,
                1,
              ]),
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(color:CustomColors.primaryColor)
        ),
        height: height,
        width: width,
        child: Center(
          child: Text(
            "$title",
            style: TextStyle(
              color: colors.whiteTemp,
              fontSize: fSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class Btn1 extends StatelessWidget {
  final String? title;
  final VoidCallback? onPress;
  double? height;
  double? width;
  double? fSize;
  bool loading;
  IconData? icon;
  Btn1(
      {Key? key,
      this.title,
      this.onPress,
      this.height,
      this.width,
      this.fSize,
      this.icon,
      this.loading = false})
      : super(key: key);

  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.red,
                Colors.redAccent
                /*colors.grad2Color,
                colors.grad2Color,*/
              ],
              stops: [
                0,
                1,
              ]),
          borderRadius: BorderRadius.circular(50),
          // border: Border.all(color:CustomColors.primaryColor)
        ),
        height: height,
        width: width,
        child: Center(
          child: !loading
              ? Text(
                  "$title",
                  style: TextStyle(
                    color: colors.whiteTemp,
                    fontSize: fSize,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : CircularProgressIndicator(
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}

class BtnSearch extends StatelessWidget {
  final String? title;
  final VoidCallback? onPress;
  double? height;
  double? width;
  double? fSize;
  IconData? icon;
  BtnSearch(
      {Key? key,
      this.title,
      this.onPress,
      this.height,
      this.width,
      this.fSize,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
              colors: [
                colors.grad1Color,
                colors.grad2Color,
              ],
              stops: [
                0,
                1,
              ]),
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(color:CustomColors.primaryColor)
        ),
        height: height,
        width: width,
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$title",
              style: TextStyle(
                color: colors.whiteTemp,
                fontSize: fSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: colors.whiteTemp,
            )
          ],
        )),
      ),
    );
  }
}

class BtnSearch1 extends StatelessWidget {
  final String? title;
  final VoidCallback? onPress;
  double? height;
  double? width;
  double? fSize;
  IconData? icon;
  BtnSearch1(
      {Key? key,
        this.title,
        this.onPress,
        this.height,
        this.width,
        this.fSize,
        this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.red,
                Colors.redAccent
              ],
              stops: [
                0,
                1,
              ]),
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(color:CustomColors.primaryColor)
        ),
        height: height,
        width: width,
        child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$title",
                  style: TextStyle(
                    color: colors.whiteTemp,
                    fontSize: fSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: colors.whiteTemp,
                )
              ],
            )),
      ),
    );
  }
}

