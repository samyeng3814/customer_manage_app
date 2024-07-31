import 'package:customer_app/nav/page_transition.dart';
import 'package:flutter/material.dart';

popContext(context, [dynamic result]) {
  Navigator.of(context).pop(result);
}

pushContext(context, {required Widget route, Function(dynamic)? function}) {
  Navigator.push(context, createRoute(route)).then((value) {
    if (value != null && function != null) {
      function(value);
    }
  });
}

pushReplacementContext(context,
    {required Widget route, Function(dynamic)? function}) {
  Navigator.pushReplacement(context, createRoute(route)).then((value) {
    if (value != null) {
      function!(value);
    }
  });
}
