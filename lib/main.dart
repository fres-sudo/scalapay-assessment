import 'package:flutter/material.dart';
import 'package:scalapay_assessment/di/dependency_injector.dart';
import 'package:scalapay_assessment/pages/products_page.dart';
import 'package:scalapay_assessment/ui/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return DependencyInjector(
      child: MaterialApp(
        title: 'Scalapay Assessment',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        home: ProductsPage(),
      ),
    );
  }
}
