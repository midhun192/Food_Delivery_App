import 'package:flutter/material.dart';
import 'package:food_delivery_app/Widgets/small_text.dart';
import 'package:food_delivery_app/utils/Colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({
    super.key,
    required this.text,
  });

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  double textHeight = Dimensions.height120;

  bool hiddenText = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          bottom: Dimensions.height10, top: Dimensions.height10),
      child: secondHalf.isEmpty
          ? SmallText(
              text: firstHalf,
              size: Dimensions.height17,
              color: AppColors.paraColor)
          : Column(
              children: [
                SmallText(
                    height: Dimensions.height2,
                    color: AppColors.paraColor,
                    size: Dimensions.height17,
                    text: hiddenText
                        ? firstHalf + "..."
                        : (firstHalf + secondHalf)),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                        text: "Show more",
                        color: AppColors.mainColor,
                        size: Dimensions.height17,
                      ),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: AppColors.mainColor,
                        size: Dimensions.height20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
