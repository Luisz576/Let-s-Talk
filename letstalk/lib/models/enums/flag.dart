import 'package:flutter/material.dart';

enum Flag{
  none,
  verified,
  rocket,
  premium,
  youtuber,
  programmer,
  adm;

  IconData getIcon(){
    switch(this){
      case Flag.adm:
        return Icons.brightness_auto;
      case Flag.verified:
        return Icons.verified;
      case Flag.rocket:
        return Icons.rocket_launch;
      case Flag.premium:
        return Icons.diamond_outlined;
      case Flag.youtuber:
        return Icons.smart_display_rounded;
      case Flag.programmer:
        return Icons.data_array;
      default:
        return Icons.disabled_by_default_outlined;
    }
  }
  
  static Flag fromValue(String flag){
    switch(flag.trim().toLowerCase()){
      case "verified":
        return Flag.verified;
      case "adm":
        return Flag.adm;
      case "rocket":
        return Flag.rocket;
      case "premium":
        return Flag.premium;
      case "youtuber":
        return Flag.youtuber;
      case "programmer":
        return Flag.programmer;
      default:
        return Flag.none;
    }
  }
}