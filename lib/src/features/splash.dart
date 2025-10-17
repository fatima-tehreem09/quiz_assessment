import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import '../core/router/app_router.dart';
import '../core/constants/colors.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    Future<void>.delayed(const Duration(milliseconds: 2500), () {
      if (!mounted) return;
      context.go(AppRoutes.home);
    });
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.primaryGradient,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 1000),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.lightOnPrimary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(
                    Icons.quiz,
                    size: 60,
                    color: AppColors.lightOnPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              FadeInUp(
                duration: const Duration(milliseconds: 1200),
                child: Text(
                  'Quiz',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: AppColors.lightOnPrimary,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pacifico',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FadeInUp(
                duration: const Duration(milliseconds: 1400),
                child: Text(
                  'Create | Share | Discover',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.lightOnPrimary.withOpacity(0.9),
                    fontFamily: 'InterTight',
                  ),
                ),
              ),
              const SizedBox(height: 50),
              FadeInUp(
                duration: const Duration(milliseconds: 1600),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.lightOnPrimary.withOpacity(0.8),
                    ),
                    strokeWidth: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
