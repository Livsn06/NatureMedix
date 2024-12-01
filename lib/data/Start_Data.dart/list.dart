import 'package:naturemedix/utils/_initApp.dart';
import '../../models/onboarding_model.dart';

Application _app = Application();
List<OnboardingModel> ONBOARD_INFO = [
  OnboardingModel(
    imageAsset: _app.image.BG2,
    title: 'Medicinal Plant',
    description:
        'Explore a variety of natural remedies. Learn how different plants can be used to treat various ailments effectively.',
  ),
  OnboardingModel(
    imageAsset: _app.image.BG3,
    title: 'Augmented Reality',
    description:
        'Immerse yourself in herbal knowledge with 3D models and augmented reality. Interact with plants and their properties in real-time.',
  ),
  OnboardingModel(
    imageAsset: _app.image.BG4,
    title: 'Plant Identifier',
    description:
        'Use your camera to identify plants and discover detailed information about their medicinal uses. Enhance your herbal knowledge easily.',
  ),
];
