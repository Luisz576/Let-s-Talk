class CallMe{

  static final Map<String, Function()> _funcs = {};

  static add(String key, Function() func){
    _funcs[key] = func;
  }

  static Function()? remove(String key){
    return _funcs.remove(key);
  }

  static call(String key){
    if(_funcs[key] != null){
      _funcs[key]!();
    }
  }

}