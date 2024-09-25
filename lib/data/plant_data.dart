import 'package:naturemedix/utils/_initApp.dart';

import '../models/plant_model.dart';

List<PlantBasicInfo> plants = [
  PlantBasicInfo(
    plantName: 'Lagundi',
    scientificName: 'Vitex negundo',
    description:
        'Lagundi, also known as the five-leaved chaste tree, is commonly used to treat respiratory issues such as coughs, colds, and fever. It has anti-inflammatory, analgesic, and antipyretic properties that help soothe respiratory discomforts. Lagundi is also effective in treating asthma and bronchitis and has been recognized for its medicinal benefits by the Department of Health.',
    plantImage: Application().plant.PLNTIMG1,
  ),
  PlantBasicInfo(
    plantName: 'Ulasimang Bato',
    scientificName: 'Peperomia pellucida',
    description:
        'Ulasimang Bato, also known as Pepper Elder, is a medicinal plant recognized for its diuretic properties. It is commonly used to treat kidney stones, urinary tract infections, and gout. In addition to its anti-inflammatory and analgesic effects, Ulasimang Bato is also believed to help reduce blood uric acid levels, making it beneficial for managing conditions like arthritis.',
    plantImage: Application().plant.PLNTIMG2,
  ),
  PlantBasicInfo(
    plantName: 'Sambong',
    scientificName: 'Blumea balsamifera',
    description:
        'Sambong is widely known for treating kidney stones and urinary infections. Acting as a natural diuretic, it aids in flushing out excess fluids and toxins from the body, making it useful in managing hypertension and edema. Sambong leaves are also used to alleviate coughs, colds, and mild respiratory issues due to its anti-inflammatory properties.',
    plantImage: Application().plant.PLNTIMG3,
  ),
  PlantBasicInfo(
    plantName: 'Akapulko',
    scientificName: 'Cassia alata',
    description:
        'Akapulko, or ringworm bush, is famous for its potent antifungal properties, particularly in treating skin conditions such as ringworm, scabies, and eczema. It is used topically as an ointment or poultice, derived from the leaves. Akapulko is also considered effective against fungal infections of the nails and scalp.',
    plantImage: Application().plant.PLNTIMG4,
  ),
  PlantBasicInfo(
    plantName: 'Niyog-niyogan',
    scientificName: 'Quisqualis indica',
    description:
        'Niyog-niyogan is commonly used for deworming and is known to expel intestinal parasites, particularly in treating ascariasis and trichuriasis. The seeds are ingested to achieve this remedy. Aside from its antiparasitic benefits, Niyog-niyogan is also believed to have antioxidant properties, promoting digestive health.',
    plantImage: Application().plant.PLNTIMG5,
  ),
  PlantBasicInfo(
    plantName: 'Yerba Buena',
    scientificName: 'Mentha cordifolia',
    description:
        'Yerba Buena, or Peppermint, is a well-known medicinal plant in the Philippines, commonly used for its analgesic, anti-inflammatory, and soothing effects. It provides relief from headaches, muscle pains, toothaches, and stomach cramps. Yerba Buena is also used to treat colds, coughs, and digestive discomforts such as flatulence and bloating.',
    plantImage: Application().plant.PLNTIMG6,
  ),
  PlantBasicInfo(
    plantName: 'Tsaang Gubat',
    scientificName: 'Carmona retusa',
    description:
        'Tsaang Gubat is a widely recognized medicinal plant used to treat gastrointestinal issues such as diarrhea, dysentery, and stomach pains. Its anti-inflammatory and antimicrobial properties make it effective in soothing digestive problems. Tsaang Gubat is also believed to help manage skin allergies and itching when applied topically.',
    plantImage: Application().plant.PLNTIMG7,
  ),
];

List<RemedyInfo> remedies = [
  RemedyInfo(
    remedyName: 'Echinacea Tea',
    remedyType: 'Tea',
    treatments: ['Respiratory conditions', 'Cough', 'Asthma'],
    description: 'Relieves flu and cold symptoms effectively.',
    remedyImage: Application().remedy.PLNTRMDY1,
  ),
  RemedyInfo(
    remedyName: 'Ginger Lemon Tea',
    remedyType: 'Tea',
    treatments: ['Kidney stones', 'Urinary tract infections'],
    description: 'Soothes throat and reduces cough symptoms.',
    remedyImage: Application().remedy.PLNTRMDY2,
  ),
  RemedyInfo(
    remedyName: 'Coconut Oil',
    remedyType: 'Oil',
    treatments: ['Dry skin', 'Hair health'],
    description:
        'Coconut oil for moisturizing dry skin and promoting healthy hair.',
    remedyImage: Application().remedy.PLNTRMDY3,
  ),
  RemedyInfo(
    remedyName: 'Akapulko Ointment',
    remedyType: 'Ointment',
    treatments: ['Ringworm', 'Scabies', 'Eczema'],
    description: 'Treats fungal infections like ringworm and eczema.',
    remedyImage: Application().remedy.PLNTRMDY4,
  ),
  RemedyInfo(
    remedyName: 'Calamansi Juice',
    remedyType: 'Juice',
    treatments: ['Cough', 'Digestive issues'],
    description: 'Relieves cough and aids digestion effectively.',
    remedyImage: Application().remedy.PLNTRMDY5,
  ),
];
