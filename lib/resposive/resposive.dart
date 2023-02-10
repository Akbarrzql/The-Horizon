import 'package:flutter/cupertino.dart';

bool isLandScape(BuildContext context) => MediaQuery.of(context).size.height < MediaQuery.of(context).size.width;