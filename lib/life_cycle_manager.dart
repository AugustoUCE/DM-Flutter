import 'package:flutter/material.dart';
import 'package:persistencia/controllers/login_controller.dart';
//observador para el ciclo de vida de la app /si se cierra o en segundo plano
class LifecycleManager extends StatefulWidget {
  final Widget child;

  const LifecycleManager({Key? key, required this.child}) : super(key: key);

  @override
  _LifecycleManagerState createState() => _LifecycleManagerState();
}

class _LifecycleManagerState extends State<LifecycleManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.inactive) {
      _saveDataOnExit();
    }
    super.didChangeAppLifecycleState(state);
  }
  //guardar datos
  void _saveDataOnExit() {
   
    LoginController().saveDataOnExit();
  }
  //para envolver el widget principal
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
