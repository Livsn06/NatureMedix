import 'package:naturemedix/utils/_initApp.dart';

import '../../models/plant_model.dart';

List<PlantData> plantDatabase = [
  PlantData(
    plantBasicInfo: PlantBasicInfo(
      plantName: 'Lagundi',
      scientificName: 'Vitex negundo',
      plantImage: Application().plant.PLNTIMG1,
      description:
          'Lagundi is a popular medicinal plant in the Philippines used for treating respiratory conditions. Its leaves and flowers are traditionally brewed into tea to relieve symptoms of cough, asthma, and fever. The plant contains anti-inflammatory and analgesic properties, which help in reducing pain and discomfort. Lagundi is also recognized for its effectiveness in managing flu-like symptoms and improving overall respiratory health.',
      treatments: ['Cough', 'Fever', 'asthma', 'diarrhea'],
      remedy: ['Tea', 'Essential Oil', 'Ointment', 'Syrup', 'Tincture'],
    ),
    remedyInfo: RemedyInfo(
      remedyName: 'Lagundi Tea',
      remedyType: 'Tea',
      description:
          'Lagundi tea helps reduce respiratory discomfort, clears airways, and eases inflammation. It’s a popular remedy for coughs and asthma attacks.',
      remedyImage: Application().plant.PLNTIMG1,
      treatments: ['Cough', 'Fever', 'asthma', 'diarrhea'],
    ),
    ingredients: [
      '6 tablespoons fresh Lagundi leaves (or 2 tablespoons dried)',
      '2 cups of water',
      '(Optional) Honey or lemon for flavor',
    ],
    steps: [
      'Boil 2 cups of water and add the Lagundi leaves.',
      'Simmer for 10-15 minutes, then strain the tea.',
      'Add honey or lemon if desired. Drink warm.',
    ],
  ),
  PlantData(
    plantBasicInfo: PlantBasicInfo(
      plantName: 'Ulasimang Bato',
      scientificName: 'Peperomia pellucida',
      plantImage: Application().plant.PLNTIMG2,
      description:
          'Ulasimang Bato is a natural remedy for managing gout and arthritis. Its anti-inflammatory and diuretic properties help reduce pain and swelling caused by excess uric acid. The plant is also used to treat kidney stones, supporting overall kidney health. It is often consumed as a decoction or applied topically to alleviate joint discomfort.',
      treatments: ['Gout', 'Arthritis', 'Kidney stones'],
      remedy: ['Tea', 'Decoction', 'Poultice'],
    ),
    remedyInfo: RemedyInfo(
      remedyName: 'Ulasimang Bato Decoction',
      remedyType: 'Decoction',
      description:
          'This decoction helps relieve symptoms of gout and arthritis by promoting uric acid removal. It also aids in kidney health.',
      remedyImage: Application().plant.PLNTIMG2,
      treatments: ['Gout', 'Arthritis', 'Kidney stones'],
    ),
    ingredients: [
      '1 cup fresh Ulasimang Bato leaves',
      '3 cups of water',
    ],
    steps: [
      'Boil 3 cups of water, add the leaves, and simmer for 15-20 minutes.',
      'Strain and drink the decoction twice daily.',
    ],
  ),
  PlantData(
    plantBasicInfo: PlantBasicInfo(
      plantName: 'Sambong',
      scientificName: 'Blumea balsamifera',
      plantImage: Application().plant.PLNTIMG3,
      description:
          'Sambong is widely used for treating kidney-related issues and hypertension. It acts as a diuretic, promoting urine flow to help manage kidney stones and urinary tract infections. The plant is also known for its anti-hypertensive properties, aiding in the regulation of blood pressure. Drinking Sambong tea regularly can detoxify the body and improve kidney health.',
      treatments: ['Kidney stones', 'Urinary infections', 'Hypertension'],
      remedy: ['Tea', 'Decoction', 'Infusion'],
    ),
    remedyInfo: RemedyInfo(
      remedyName: 'Sambong Tea',
      remedyType: 'Tea',
      description:
          'Sambong tea helps detoxify the kidneys and manage hypertension, and it is effective for urinary infections.',
      remedyImage: Application().plant.PLNTIMG3,
      treatments: ['Kidney stones', 'Urinary infections', 'Hypertension'],
    ),
    ingredients: [
      '5-6 fresh Sambong leaves',
      '3 cups of water',
      '(Optional) Honey or lemon for flavor',
    ],
    steps: [
      'Boil 3 cups of water, add Sambong leaves, and simmer for 15 minutes.',
      'Strain the tea and drink twice daily.',
    ],
  ),
  PlantData(
    plantBasicInfo: PlantBasicInfo(
      plantName: 'Akapulko',
      scientificName: 'Cassia alata',
      plantImage: Application().plant.PLNTIMG4,
      description:
          'Akapulko is primarily used for its antifungal properties, making it an effective treatment for skin conditions such as ringworm and scabies. The plant can also be used to combat fungal infections of the nails and scalp. Its juice or ointment form is applied directly to affected areas to reduce itching and inflammation. Akapulko is a go-to remedy for individuals suffering from persistent fungal skin infections.',
      treatments: [
        'Skin Infections',
        'Fungal Infections',
        'Eczema',
        'Constipation'
      ],
      remedy: ['Tea', 'Ointment', 'Poultice'],
    ),
    remedyInfo: RemedyInfo(
      remedyName: 'Akapulko Ointment',
      remedyType: 'Ointment',
      description:
          'Akapulko ointment is applied to fungal infections to reduce itching and inflammation while eliminating fungi.',
      remedyImage: Application().plant.PLNTIMG4,
      treatments: ['Ringworm', 'Scabies', 'Fungal infections'],
    ),
    ingredients: [
      '1 cup fresh Akapulko leaves',
      '2 tablespoons coconut oil or petroleum jelly',
    ],
    steps: [
      'Crush the leaves to extract the juice and mix with oil or petroleum jelly.',
      'Apply to affected areas twice daily.',
    ],
  ),
  PlantData(
    plantBasicInfo: PlantBasicInfo(
      plantName: 'Niyog-niyogan',
      scientificName: 'Quisqualis indica',
      plantImage: Application().plant.PLNTIMG5,
      description:
          'Niyog-niyogan is commonly used as a natural deworming agent in traditional medicine. The seeds are consumed to expel intestinal parasites and improve digestive health. It is particularly effective in treating parasitic infections like ascariasis and trichuriasis. Regular consumption of Niyog-niyogan seeds helps in maintaining a parasite-free digestive system.',
      treatments: ['Intestinal Worms', 'Diarrhea', 'Stomach Pain', 'Fever'],
      remedy: ['Tea', 'Decoction', 'Infusion'],
    ),
    remedyInfo: RemedyInfo(
      remedyName: 'Niyog-niyogan Seed Remedy',
      remedyType: 'Oral remedy',
      description:
          'The seeds of Niyog-niyogan help remove parasites from the intestines and are taken to treat infections like ascariasis and trichuriasis.',
      remedyImage: Application().plant.PLNTIMG5,
      treatments: ['Deworming', 'Parasitic infections'],
    ),
    ingredients: [
      '10-12 Niyog-niyogan seeds',
      'Water',
    ],
    steps: [
      'Crush and swallow the seeds with water before bedtime.',
      'Repeat once a week for three weeks.',
    ],
  ),
  PlantData(
    plantBasicInfo: PlantBasicInfo(
      plantName: 'Yerba Buena',
      scientificName: 'Mentha cordifolia',
      plantImage: Application().plant.PLNTIMG6,
      description:
          'Yerba Buena, also known as Peppermint, is widely used to alleviate headaches, muscle pain, and digestive issues. It is effective in reducing bloating, gas, and colic. The leaves are often brewed into a tea to relieve these discomforts. Yerba Buena is also applied topically to soothe muscle aches and improve circulation.',
      treatments: [
        'Headaches',
        'Digestive Issues',
        'Cold Symptoms',
        'Muscle Pain'
      ],
      remedy: ['Tea', 'Essential Oil', 'Ointment'],
    ),
    remedyInfo: RemedyInfo(
      remedyName: 'Yerba Buena Tea',
      remedyType: 'Tea',
      description:
          'Yerba Buena tea soothes headaches and muscle pain, and provides relief from digestive issues.',
      remedyImage: Application().plant.PLNTIMG6,
      treatments: ['Headaches', 'Muscle pain', 'Indigestion'],
    ),
    ingredients: [
      '1 cup fresh Yerba Buena leaves',
      '2 cups of water',
      '(Optional) Honey or sugar',
    ],
    steps: [
      'Boil 2 cups of water and add Yerba Buena leaves.',
      'Simmer for 10-15 minutes, strain, and sweeten if desired.',
    ],
  ),
  PlantData(
    plantBasicInfo: PlantBasicInfo(
      plantName: 'Tsaang Gubat',
      scientificName: 'Carmona retusa',
      plantImage: Application().plant.PLNTIMG7,
      description:
          'Tsaang Gubat is well-known for its ability to treat digestive disorders, especially diarrhea and colic. The plant also has applications in oral health, providing relief from mouth sores and gum inflammation. It can be consumed as a tea to alleviate stomach discomfort and promote digestive wellness. Additionally, Tsaang Gubat helps soothe minor stomach pains and cramps.',
      treatments: [
        'Diarrhea',
        'Stomach Pain',
        'Oral Health',
        'acid Reflux',
        'Skin Wounds'
      ],
      remedy: ['Tea', 'Mouthwash', 'Ointment'],
    ),
    remedyInfo: RemedyInfo(
      remedyName: 'Tsaang Gubat Tea',
      remedyType: 'Tea',
      description:
          'Tsaang Gubat tea is consumed to alleviate digestive problems such as diarrhea and stomach pain.',
      remedyImage: Application().plant.PLNTIMG7,
      treatments: ['Diarrhea', 'Stomach pain', 'Oral health'],
    ),
    ingredients: [
      '1 cup fresh Tsaang Gubat leaves',
      '3 cups of water',
    ],
    steps: [
      'Boil 3 cups of water, add the leaves, and simmer for 15 minutes.',
      'Strain and drink the tea twice daily.',
    ],
  ),
  PlantData(
    plantBasicInfo: PlantBasicInfo(
      plantName: 'Bayabas',
      scientificName: 'Psidium guajava',
      plantImage: Application().plant.PLNTIMG8,
      description:
          'Bayabas, or Guava, is commonly used for wound disinfection and as a natural antiseptic. The leaves are boiled and used to wash wounds, helping prevent infections. Bayabas is also effective in treating diarrhea due to its antimicrobial properties. It is often consumed as a tea or applied topically to affected areas.',
      treatments: ['Diarrhea', 'Skin Wounds', 'Oral Health'],
      remedy: ['Tea', 'Mouthwash', 'Ointment', 'Bath Soak'],
    ),
    remedyInfo: RemedyInfo(
      remedyName: 'Bayabas Leaf Wash',
      remedyType: 'Topical wash',
      description:
          'Bayabas leaf wash is used to clean wounds and prevent infection. It also has antimicrobial properties.',
      remedyImage: Application().plant.PLNTIMG8,
      treatments: ['Wounds', 'Infections', 'Diarrhea'],
    ),
    ingredients: [
      '5-6 Bayabas leaves',
      '2 cups of water',
    ],
    steps: [
      'Boil the Bayabas leaves in water for 10 minutes.',
      'Use the liquid as a wash for wounds, or drink as a tea for diarrhea.',
    ],
  ),
  PlantData(
    plantBasicInfo: PlantBasicInfo(
      plantName: 'Ampalaya',
      scientificName: 'Momordica charantia',
      plantImage: Application().plant.PLNTIMG1,
      description:
          'Ampalaya, or Bitter Gourd, is widely known for its ability to manage blood sugar levels in diabetic patients. It is rich in antioxidants and helps regulate insulin production. Consuming Ampalaya juice or dishes made from its fruit aids in lowering blood sugar levels. It is also used to promote liver health and digestion.',
      treatments: ['Diabetes', 'Skin Conditions', 'Digestion'],
      remedy: ['Tea', 'Juice', 'Ointment', 'Food'],
    ),
    remedyInfo: RemedyInfo(
      remedyName: 'Ampalaya Juice',
      remedyType: 'Juice',
      description:
          'Ampalaya juice is consumed to help regulate blood sugar levels and improve insulin sensitivity, especially for diabetics.',
      remedyImage: Application().plant.PLNTIMG1,
      treatments: ['Diabetes', 'Blood sugar regulation'],
    ),
    ingredients: [
      '1 medium-sized Ampalaya (Bitter Gourd)',
      '1 cup water',
      '(Optional) Honey or lemon for taste',
    ],
    steps: [
      'Slice the Ampalaya and remove the seeds.',
      'Blend the fruit with water until smooth, then strain and drink the juice.',
      'Add honey or lemon if desired.',
    ],
  ),
  PlantData(
    plantBasicInfo: PlantBasicInfo(
      plantName: 'Bawang',
      scientificName: 'Allium sativum',
      plantImage: Application().plant.PLNTIMG2,
      description:
          'Bawang, or Garlic, is a natural remedy for lowering cholesterol levels and improving heart health. It has potent anti-inflammatory and antioxidant properties that benefit the cardiovascular system. Bawang is also known to help boost the immune system, preventing colds and infections. Consuming raw or cooked garlic can help in reducing hypertension and promoting overall well-being.',
      treatments: ['Infections', 'Hypertension', 'Cholesterol'],
      remedy: ['Tea', 'Paste', 'Ointment', 'Oral Remedy'],
    ),
    remedyInfo: RemedyInfo(
      remedyName: 'Bawang Paste',
      remedyType: 'Paste',
      description:
          'Bawang paste is applied topically to treat infections and inflammation. It can also be consumed to lower cholesterol.',
      remedyImage: Application().plant.PLNTIMG2,
      treatments: ['Infections', 'Hypertension', 'Cholesterol'],
    ),
    ingredients: [
      '4-5 cloves of garlic',
      '1 tablespoon olive oil or coconut oil',
    ],
    steps: [
      'Crush the garlic and mix with oil to form a paste.',
      'Apply the paste to affected areas or consume it raw for health benefits.',
    ],
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
