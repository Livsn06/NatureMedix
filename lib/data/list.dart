import 'package:naturemedix/utils/_initApp.dart';
import '../models/onboarding_model.dart';

Application _app = Application();
List<OnboardingModel> ONBOARD_INFO = [
  OnboardingModel(
    imageAsset: _app.image.BG2,
    title: 'Medicinal Plant',
    description:
        'Discover an extensive range of natural remedies and uncover their healing properties for various ailments',
  ),
  OnboardingModel(
    imageAsset: _app.image.BG3,
    title: 'Augmented Reality',
    description:
        'Immerse yourself in the world of herbal knowledge with interactive 3D models and augmented reality experiences',
  ),
  OnboardingModel(
    imageAsset: _app.image.BG4,
    title: 'Plant Identifier',
    description:
        'Effortlessly identify plants using your camera and access comprehensive information about their medicinal uses',
  ),
];
