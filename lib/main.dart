import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/main_screen.dart';
import 'providers/cart_provider.dart';
import 'providers/order_provider.dart';
import 'providers/user_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/preferences_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProvider(create: (ctx) => OrderProvider()),
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
        ChangeNotifierProvider(create: (ctx) => ThemeProvider()),
        ChangeNotifierProvider(create: (ctx) => PreferencesProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'TechShop',
            theme: _buildLightTheme(),
            darkTheme: _buildDarkTheme(),
            themeMode: themeProvider.themeMode,
            home: const MainScreen(),
          );
        },
      ),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      primarySwatch: Colors.blue,
      primaryColor: const Color(0xFF2563EB),
      scaffoldBackgroundColor: const Color(0xFFF8FAFB),
      cardColor: Colors.white,
      colorScheme: ColorScheme.light(
        primary: const Color(0xFF2563EB),
        secondary: const Color(0xFF10B981),
        tertiary: const Color(0xFFF59E0B),
        surface: Colors.white,
        error: const Color(0xFFEF4444),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
        displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
        displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
        headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
        headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
        headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
        bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF374151)),
        bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF4B5563)),
        bodySmall: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE5E7EB))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1.5)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF2563EB), width: 2)),
        filled: true,
        fillColor: const Color(0xFFF9FAFB),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: const TextStyle(color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
        hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        iconTheme: IconThemeData(color: Color(0xFF111827), size: 24),
        titleTextStyle: TextStyle(color: Color(0xFF111827), fontSize: 20, fontWeight: FontWeight.w600),
        centerTitle: false,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF2563EB),
        unselectedItemColor: Color(0xFF9CA3AF),
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2563EB),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          elevation: 0,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF2563EB),
          side: const BorderSide(color: Color(0xFF2563EB), width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF2563EB),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFFF3F4F6),
        selectedColor: const Color(0xFF2563EB),
        labelStyle: const TextStyle(color: Color(0xFF374151), fontSize: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Color(0xFFE5E7EB), width: 1)),
      ),
      dividerColor: const Color(0xFFE5E7EB),
      dividerTheme: const DividerThemeData(thickness: 1, color: Color(0xFFE5E7EB)),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      primarySwatch: Colors.blue,
      primaryColor: const Color(0xFF3B82F6),
      scaffoldBackgroundColor: const Color(0xFF0F172A),
      cardColor: const Color(0xFF1E293B),
      colorScheme: ColorScheme.dark(
        primary: const Color(0xFF3B82F6),
        secondary: const Color(0xFF10B981),
        tertiary: const Color(0xFFFACC15),
        surface: const Color(0xFF1E293B),
        error: const Color(0xFFFCA5A5),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFFF1F5F9)),
        displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFF1F5F9)),
        displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFF1F5F9)),
        headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFF1F5F9)),
        headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFF1F5F9)),
        headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFFE2E8F0)),
        bodyLarge: TextStyle(fontSize: 16, color: Color(0xFFCBD5E1)),
        bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
        bodySmall: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFFF1F5F9)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF334155))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF334155), width: 1.5)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2)),
        filled: true,
        fillColor: const Color(0xFF1E293B),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: const TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.w500),
        hintStyle: const TextStyle(color: Color(0xFF64748B)),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1E293B),
        elevation: 0,
        scrolledUnderElevation: 1,
        iconTheme: IconThemeData(color: Color(0xFFF1F5F9), size: 24),
        titleTextStyle: TextStyle(color: Color(0xFFF1F5F9), fontSize: 20, fontWeight: FontWeight.w600),
        centerTitle: false,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1E293B),
        selectedItemColor: Color(0xFF3B82F6),
        unselectedItemColor: Color(0xFF64748B),
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3B82F6),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          elevation: 0,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF3B82F6),
          side: const BorderSide(color: Color(0xFF3B82F6), width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF3B82F6),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF334155),
        selectedColor: const Color(0xFF3B82F6),
        labelStyle: const TextStyle(color: Color(0xFFE2E8F0), fontSize: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF1E293B),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Color(0xFF334155), width: 1)),
      ),
      dividerColor: const Color(0xFF334155),
      dividerTheme: const DividerThemeData(thickness: 1, color: Color(0xFF334155)),
    );
  }
}
