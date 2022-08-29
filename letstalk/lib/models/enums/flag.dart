enum Flag{
  none,
  verified,
  adm;
  
  static Flag fromValue(String flag){
    switch(flag){
      case "verified":
        return Flag.verified;
      case "adm":
        return Flag.adm;
      default:
        return Flag.none;
    }
  }
}