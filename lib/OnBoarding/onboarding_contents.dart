import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents(
      {required this.title, required this.image, required this.desc});
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Ilmu pengetahuan dari sumber terpercaya",
    image: "assets/book.gif",
    desc: "Kami menyediakan berbagai macam ilmu pengetahuan dari sumber terpercaya",
  ),
  OnboardingContents(
    title: "Kumpulan artikel terbaru",
    image: "assets/education.gif",
    desc: "Kami menyediakan berbagai macam artikel terbaru",
  ),
  OnboardingContents(
    title: "Cara baru untuk menjelajahi dunia",
    image: "assets/globe.gif",
    desc: "Jelajahi dunia dengan cara baru, dengan cara yang lebih mudah dan lebih menyenangkan.",
  ),
];