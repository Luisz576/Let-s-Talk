import 'package:flutter/material.dart';

enum Flag{
  none,
  verified,
  rocket,
  adm;

  IconData getIcon(){
    switch(this){
      case Flag.adm:
        return Icons.brightness_auto;
      case Flag.verified:
        return Icons.verified;
      case Flag.rocket:
        return Icons.rocket_launch;
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
      default:
        return Flag.none;
    }
  }
}