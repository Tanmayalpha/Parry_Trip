import 'package:flutter/material.dart';
import 'package:parry_trip2/constants/app_colors.dart';
import 'package:http/http.dart' as http;

class MultiCityWidget extends StatelessWidget {
  MultiCityWidget({
    Key? key,
    this.toController,
    this.fromController,
    this.dateController,
    this.tapOnTo,
    this.tapOnDate,
    this.tapOnFrom
  }) : super(key: key);
  TextEditingController? fromController;
  TextEditingController? toController;
  TextEditingController? dateController;
  VoidCallback? tapOnFrom;
  VoidCallback? tapOnTo;
  VoidCallback? tapOnDate;

  @override
  Widget build(BuildContext context) {
    return fromAndToAndDateWidget(context);
  }

  Widget fromAndToAndDateWidget(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("From"),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: TextFormField(
                  readOnly: true,
                  controller: fromController,
                  onTap: tapOnFrom,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    hintText: 'city',
                  ),
                ),
              ),
            ],
          ),
          Icon(
            Icons.compare_arrows_rounded,
            color: colors.black54.withOpacity(0.4),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text("To"),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: TextFormField(
                  readOnly: true,
                  controller: toController,
                  onTap: tapOnTo,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      hintText: 'Select',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: colors.black54.withOpacity(0.4))),
                ),
              )
            ],
          )
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Select Date"),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.5,
            child: TextFormField(
              readOnly: true,
              controller: dateController,
              onTap: tapOnDate,
              textAlign: TextAlign.left,
              decoration: const InputDecoration(
                hintText: 'Select Date',
              ),
            ),
          ),
        ],
      ),
    ]);
  }



}
