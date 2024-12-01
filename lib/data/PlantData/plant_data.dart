import 'package:naturemedix/utils/_initApp.dart';
import '../../models/plant_info.dart';
import '../../models/remedy_info.dart';

List<PlantData> plantList = [
  PlantData(
    plantName: "Lagundi",
    scientificName: "Vitex negundo",
    plantImages: [
      Application().plant.PLNTIMG1,
      Application().plant.PLNTIMG1,
    ],
    description:
        "Lagundi (Vitex negundo) is a shrub native to tropical regions, particularly in Asia, known for its distinctive five-leaf clusters and purple flowers. It is widely recognized for its medicinal properties, particularly in treating coughs, colds, and respiratory issues, as it has expectorant and anti-inflammatory effects. Traditionally, the leaves are brewed into tea or used in herbal preparations, making lagundi a popular choice in alternative medicine for promoting respiratory health.",
    treatments: ["Cough", "Asthma", "Fever", "Bronchitis"],
    remedyList: [
      RemedyInfo(
          rating: 0,
          remedyType: "Herbal Remedy",
          remedyName: "Lagundi Tea",
          treatment: "Cough Relief",
          description:
              "Lagundi is commonly used to alleviate symptoms of cough and respiratory conditions. The leaves are boiled to make a tea that helps soothe the throat and clear airways.",
          remedyImages: [
            Application().remedy.PLNTRMDY1,
          ],
          ingredients: [
            "Fresh Lagundi leaves (about 5-6 pieces)",
            "2 cups of water",
          ],
          steps: [
            "1. Wash the Lagundi leaves thoroughly.",
            "2. Boil 2 cups of water in a pot.",
            "3. Add the Lagundi leaves to the boiling water.",
            "4. Let it simmer for 10-15 minutes.",
            "5. Strain the liquid and let it cool.",
            "6. Drink the Lagundi tea while warm.",
          ],
          usage: [
            "Adults: 1 cup, 3 times a day."
          ],
          sideEffects: [
            "1. Allergic Reactions: Some people may experience allergic reactions such as itchy skin or swollen lips.",
            "2. Gastrointestinal Issues: Overuse or high doses may lead to mild gastrointestinal issues like nausea or diarrhea.",
            "3. Other: As with any herbal remedy, it's always best to consult with a healthcare professional before use, especially for pregnant or lactating mothers."
          ]),
      RemedyInfo(
          rating: 0,
          remedyType: "Herbal Remedy",
          remedyName: "Lagundi Decoction",
          treatment: "Fever Relief",
          description:
              "Lagundi is often used to lower fever. A decoction made from the leaves helps reduce body temperature and relieve associated symptoms such as body aches and chills.",
          remedyImages: [
            Application().remedy.PLNTRMDY2,
          ],
          ingredients: [
            "Fresh Lagundi leaves (about 7-10 pieces)",
            "4 cups of water",
          ],
          steps: [
            "1. Clean the Lagundi leaves thoroughly.",
            "2. Boil 4 cups of water in a pot.",
            "3. Add the Lagundi leaves and let it simmer for 15-20 minutes.",
            "4. Strain the liquid and allow it to cool slightly.",
            "5. Drink the decoction while warm.",
          ],
          usage: [
            "Adults: 1 cup, 3 times a day."
          ],
          sideEffects: [
            "1. Allergic Reactions: Some people may experience allergic reactions such as itchy skin or swollen lips.",
            "2. Gastrointestinal Issues: Overuse or high doses may lead to mild gastrointestinal issues like nausea or diarrhea.",
            "3. Other: As with any herbal remedy, it's always best to consult with a healthcare professional before use, especially for pregnant or lactating mothers."
          ]),
      RemedyInfo(
          rating: 0,
          remedyType: "Herbal Remedy",
          remedyName: "Lagundi Syrup",
          treatment: "Bronchitis Relief",
          description:
              "Lagundi syrup, made from Lagundi leaf extract, is effective for treating severe coughs and bronchitis.",
          remedyImages: [
            Application().remedy.PLNTRMDY5,
          ],
          ingredients: [
            "Fresh Lagundi leaves extract",
            "Honey (optional)",
          ],
          steps: [
            "1. Extract juice from fresh Lagundi leaves.",
            "2. Mix the extract with honey (optional).",
            "3. Take 1-2 tablespoons.",
          ],
          usage: [
            "Take 2-3 times daily."
          ],
          sideEffects: [
            "1. Allergic Reactions: Some people may experience allergic reactions such as itchy skin or swollen lips.",
            "2. Gastrointestinal Issues: Overuse or high doses may lead to mild gastrointestinal issues like nausea or diarrhea.",
            "3. Other: As with any herbal remedy, it's always best to consult with a healthcare professional before use, especially for pregnant or lactating mothers."
          ]),
      RemedyInfo(
          rating: 0,
          remedyType: "Herbal Remedy",
          remedyName: "Lagundi Bath",
          treatment: "Body Pain and Fever Relief",
          description:
              "Lagundi-infused bath water helps relieve body pains and reduce fever, providing soothing relief.",
          remedyImages: [
            Application().remedy.lagundi_bath,
          ],
          ingredients: [
            "Fresh Lagundi leaves (20-30 pieces)",
            "Bath water",
          ],
          steps: [
            "1. Boil fresh Lagundi leaves in a large pot.",
            "2. Pour the boiled leaves and water into your bath.",
            "3. Soak in the Lagundi-infused bath for 15-20 minutes.",
          ],
          usage: [
            "Once a day until symptoms improve."
          ],
          sideEffects: [
            "1. Allergic Reactions: Some people may experience allergic reactions such as itchy skin or swollen lips.",
            "2. Gastrointestinal Issues: Overuse or high doses may lead to mild gastrointestinal issues like nausea or diarrhea.",
            "3. Other: As with any herbal remedy, it's always best to consult with a healthcare professional before use, especially for pregnant or lactating mothers."
          ]),
    ],
  ),
  PlantData(
    plantName: "Ulasimang Bato",
    scientificName: "Peperomia pellucida",
    plantImages: [
      Application().plant.PLNTIMG2,
    ],
    description:
        "Ulasimang Bato (Peperomia pellucida) is a small, creeping herb native to tropical regions, often found in damp, shaded areas. Recognized for its succulent, heart-shaped leaves and tiny white flowers, it is commonly used in traditional medicine for its anti-inflammatory and diuretic properties. Ulasimang Bato is also valued for its culinary uses, where the leaves can be eaten fresh in salads or cooked as a vegetable, contributing both flavor and nutritional benefits.",
    treatments: ["Urinary tract infections", "Gout"],
    remedyList: [
      RemedyInfo(
          rating: 0,
          remedyType: "Herbal Remedy",
          remedyName: "Ulasimang Bato Juice",
          treatment: "Diuretic",
          description:
              "Ulasimang Bato is used to create a refreshing juice that helps in detoxifying the body and relieving inflammation.",
          remedyImages: [
            Application().remedy.ulasimang_juice,
          ],
          ingredients: [
            "Fresh Ulasimang Bato leaves (about 10-15 pieces)",
            "2 cups of water",
          ],
          steps: [
            "1. Wash the Ulasimang Bato leaves thoroughly.",
            "2. Blend the leaves with 2 cups of water.",
            "3. Strain the mixture to obtain the juice.",
            "4. Drink the juice fresh.",
          ],
          usage: [
            "Adults: 1 cup, 2 times a day.",
            "Children: Consult a pediatrician before use."
          ],
          sideEffects: [
            "1. Allergic Reactions: May cause itchy skin, rashes, or swelling in those allergic to the plant.",
            "2. Gastrointestinal Issues: Overconsumption might lead to stomach cramps, nausea, or diarrhea.",
            "3. Potential Interaction with Medications: Could interact with medications like blood thinners, so consultation with a healthcare professional is advisable before use.",
            "4. Other Considerations: Consult with a healthcare professional before use, especially for children and pregnant or lactating women."
          ]),
    ],
  ),
  PlantData(
    plantName: "Sambong",
    scientificName: "Blumea balsamifera",
    plantImages: [
      Application().plant.PLNTIMG3,
    ],
    description:
        "Sambong (Blumea balsamifera) is a flowering plant native to Southeast Asia, particularly valued for its medicinal properties. Commonly used in traditional medicine, sambong leaves are known for their diuretic effects and are often brewed into tea to help treat urinary problems, kidney stones, and hypertension. Additionally, sambong is appreciated for its aromatic qualities and is sometimes used in topical treatments for wounds and skin irritations.",
    treatments: [
      "Kidney stones",
      "Hypertension",
      "Urinary tract infections",
    ],
    remedyList: [
      RemedyInfo(
          rating: 0,
          remedyType: "Herbal Remedy",
          remedyName: "Sambong Tea",
          treatment: "Kidney Stones",
          description:
              "Sambong leaves are prepared as a tea to help dissolve kidney stones and promote the flow of urine, providing relief from urinary tract infections.",
          remedyImages: [
            Application().remedy.sambong_tea,
          ],
          ingredients: [
            "Dried Sambong leaves (5-6 pieces)",
            "2 cups of water",
          ],
          steps: [
            "1. Rinse the dried Sambong leaves.",
            "2. Bring 2 cups of water to a boil.",
            "3. Add the Sambong leaves to the water.",
            "4. Let it boil for 10 minutes, then cool and strain.",
            "5. Drink the tea while warm.",
          ],
          usage: [
            "Adults: 1 cup, 2 times a day until symptoms improve.",
            "Children (7-12 yrs): 1/2 cup, 2 times a day until symptoms improve.",
            "Children (2-6 yrs): 1/4 cup, 1-2 times a day until symptoms improve.",
            "Children (Babies): Consult a pediatrician before use."
          ],
          sideEffects: [
            "1. Allergic Reactions: Some individuals may experience skin rashes, itching, or swelling.",
            "2. Gastrointestinal Issues: High doses might lead to nausea, vomiting, or diarrhea.",
            "3. Dizziness: In some cases, dizziness or lightheadedness may occur.",
            "4. Other Considerations: It's important to consult with a healthcare professional before use, especially for pregnant or lactating women, and individuals with pre-existing health conditions."
          ]),
    ],
  ),
  PlantData(
    plantName: "Akapulko",
    scientificName: "Cassia alata",
    plantImages: [
      Application().plant.PLNTIMG4,
    ],
    description:
        "Akapulko (Cassia alata), commonly known as golden shower or ringworm bush, is a flowering plant native to tropical regions. It is widely recognized for its bright yellow flowers and medicinal properties, particularly in treating skin conditions such as ringworm and fungal infections. Traditionally, the leaves are crushed and applied topically for their antifungal and antiseptic effects, making akapulko a valuable herb in local herbal medicine.",
    treatments: [
      "Fungal infections",
      "Skin irritations",
    ],
    remedyList: [
      RemedyInfo(
          rating: 0,
          remedyType: "Herbal Remedy",
          remedyName: "Akapulko Ointment",
          treatment: "Skin Treatment",
          description:
              "The leaves are crushed to create a poultice or ointment that can be applied to infected skin areas.",
          remedyImages: [
            Application().remedy.PLNTRMDY4,
          ],
          ingredients: [
            "Fresh Akapulko leaves (about 5-6 pieces)",
            "Oil or Vaseline for mixing.",
          ],
          steps: [
            "1. Crush the fresh Akapulko leaves to extract the juice.",
            "2. Mix the juice with oil or Vaseline.",
            "3. Apply the ointment to the affected area.",
          ],
          usage: [
            "Apply as needed to the affected area.",
            "For best results, use 2-3 times daily."
          ],
          sideEffects: [
            "1. Allergic Reactions: Some individuals may experience skin rashes, itching, or swelling.",
            "2. Skin Irritation: Prolonged use may cause irritation or redness on the skin.",
            "3. Gastrointestinal Issues: If ingested accidentally, it can cause nausea or vomiting.",
            "4. Other Considerations: Always consult a healthcare professional before use, especially for pregnant or lactating women, and individuals with pre-existing skin conditions."
          ]),
    ],
  ),
  PlantData(
    plantName: "Niyog-niyogan",
    scientificName: "Quisqualis indica",
    plantImages: [
      Application().plant.PLNTIMG5,
    ],
    description:
        "Niyog-niyogan (Quisqualis indica), also known as Chinese honey suckle, is a climbing plant characterized by its fragrant flowers that can be white, pink, or red. Traditionally used in herbal medicine, the leaves and seeds are known for their medicinal properties, particularly in treating intestinal worms and other digestive issues. Niyog-niyogan is also appreciated for its ornamental value, as it can add beauty to gardens and landscapes.",
    treatments: [
      "Intestinal worms",
      "Digestive health",
    ],
    remedyList: [
      RemedyInfo(
          rating: 0,
          remedyType: "Herbal Remedy",
          remedyName: "Niyog-niyogan Paste",
          treatment: "Skin Rashes and Insect Bites",
          description:
              "A paste made from Niyog-niyogan seeds can be applied to affected areas to relieve itching and irritation from insect bites and mild skin rashes.",
          remedyImages: [
            Application().remedy.niyog_paste,
          ],
          ingredients: [
            "5-10 Niyog-niyogan seeds",
            "A few drops of water",
          ],
          steps: [
            "1. Grind the Niyog-niyogan seeds into a fine powder.",
            "2. Add a few drops of water to make a thick paste.",
            "3. Apply the paste directly to the affected skin area.",
            "4. Leave it on for 10-15 minutes, then rinse off with water.",
          ],
          usage: [
            "Apply as needed, up to 2 times a day."
          ],
          sideEffects: [
            "1. Allergic Reactions: Some individuals may experience skin rashes, itching, or swelling.",
            "2. Skin Irritation: Prolonged use may cause irritation or redness on the skin.",
            "3. Other Considerations: Always consult a healthcare professional before use, especially for pregnant or lactating women, and individuals with pre-existing skin conditions."
          ]),
      RemedyInfo(
          rating: 0,
          remedyType: "Herbal Remedy",
          remedyName: "Niyog-niyogan Seed Oil",
          treatment: "Joint Pain Relief",
          description:
              "An oil infusion made with Niyog-niyogan seeds may help alleviate mild joint pain when massaged onto the area.",
          remedyImages: [
            Application().remedy.niyog_oil,
          ],
          ingredients: [
            "10 Niyog-niyogan seeds",
            "1/2 cup coconut oil or olive oil",
          ],
          steps: [
            "1. Crush the Niyog-niyogan seeds lightly.",
            "2. Add the crushed seeds to the coconut or olive oil in a small pan.",
            "3. Heat the mixture on low for 15-20 minutes, without letting it boil.",
            "4. Strain the seeds out and let the oil cool.",
            "5. Massage the oil onto the affected joint areas as needed.",
          ],
          usage: [
            "Use 1-2 times a day on sore joints as needed."
          ],
          sideEffects: [
            "1. Allergic Reactions: Some individuals may experience skin rashes, itching, or swelling.",
            "2. Skin Irritation: Prolonged use may cause irritation or redness on the skin.",
            "3. Other Considerations: Always consult a healthcare professional before use, especially for pregnant or lactating women, and individuals with pre-existing skin conditions."
          ]),
    ],
  ),
  PlantData(
    plantName: "Yerba Buena",
    scientificName: "Clinopodium douglasii",
    plantImages: [
      Application().plant.PLNTIMG6,
    ],
    description:
        "Yerba Buena (Clinopodium douglasii) is a fragrant herb native to the Americas, recognized for its refreshing minty aroma and culinary versatility. It is commonly used in teas, cocktails, and various dishes, adding a distinctive flavor that enhances many recipes. In traditional medicine, yerba buena is valued for its soothing properties, often used to relieve digestive issues, headaches, and respiratory ailments.",
    treatments: [
      "Headache",
      "Body pain",
      "Cough and colds",
    ],
    remedyList: [
      RemedyInfo(
          rating: 0,
          remedyType: "Herbal Remedy",
          remedyName: "Yerba Buena Mint Juice",
          treatment: "Cooling Refreshment and Digestive Aid",
          description:
              "Yerba Buena mint juice provides a refreshing drink that aids digestion and helps soothe an upset stomach.",
          remedyImages: [
            Application().remedy.yerbaBuena_juice
          ],
          ingredients: [
            "A handful of fresh Yerba Buena leaves",
            "1-2 cups of cold water",
            "Lemon juice (optional, to taste)",
            "Honey or sugar (optional, to taste)",
          ],
          steps: [
            "1. Rinse the Yerba Buena leaves thoroughly.",
            "2. Blend the leaves with 1-2 cups of cold water until smooth.",
            "3. Strain the mixture through a fine sieve or cheesecloth to extract the juice.",
            "4. Add lemon juice and sweetener if desired.",
            "5. Serve chilled over ice for a refreshing drink.",
          ],
          usage: [
            "Drink 1 cup as needed for digestion or to cool down on hot days."
          ],
          sideEffects: [
            "1. Allergic Reactions: Some individuals may experience skin rashes, itching, or swelling.",
            "2. Gastrointestinal Issues: Overconsumption may lead to stomach cramps, nausea, or diarrhea.",
            "3. Other Considerations: Consult a healthcare professional before use, especially for pregnant or lactating women, and individuals with pre-existing health conditions."
          ]),
      RemedyInfo(
          rating: 0,
          remedyType: "Herbal Remedy",
          remedyName: "Yerba Buena Tea",
          treatment: "Pain Relief",
          description:
              "Yerba Buena is used as a tea or applied topically to relieve pain. The leaves can be boiled to make a soothing tea for headaches and body aches.",
          remedyImages: [
            Application().remedy.yerbaBuena_tea,
          ],
          ingredients: [
            "Fresh Yerba Buena leaves (6-8 pieces)",
            "1 cup of water",
          ],
          steps: [
            "1. Rinse the Yerba Buena leaves thoroughly.",
            "2. Boil 1 cup of water in a pot.",
            "3. Add the leaves to the boiling water.",
            "4. Let it simmer for about 10 minutes.",
            "5. Strain and drink warm.",
          ],
          usage: [
            "Adults: 1 cup, as needed for pain relief.",
            "Children: Consult a pediatrician before use."
          ],
          sideEffects: [
            "1. Allergic Reactions: Some individuals may experience skin rashes, itching, or swelling.",
            "2. Gastrointestinal Issues: Overconsumption may lead to stomach cramps, nausea, or diarrhea.",
            "3. Other Considerations: Consult a healthcare professional before use, especially for pregnant or lactating women, and individuals with pre-existing health conditions."
          ]),
    ],
  ),
  PlantData(
    plantName: "Paragis",
    scientificName: "Eleusine indica",
    plantImages: [
      Application().plant.PLNTIMG13,
    ],
    description:
        "Paragis (Eleusine indica) is a resilient grass native to tropical regions and commonly found in lawns and disturbed areas. It is often considered a weed but has significant medicinal value. Traditionally, paragis is known for its anti-inflammatory and diuretic properties, and it is used in various folk remedies to treat infections, fevers, and respiratory issues.",
    treatments: [
      "Fever",
      "Urinary tract infections",
      "Cough and colds",
      "Inflammation",
    ],
    remedyList: [
      RemedyInfo(
          rating: 0,
          remedyType: "Topical Herbal Remedy",
          remedyName: "Paragis Poultice",
          treatment: "Wound Healing and Inflammation",
          description:
              "A poultice made from fresh Paragis leaves can be applied to wounds or inflamed areas. It is believed to help reduce swelling and promote healing.",
          remedyImages: [
            Application().remedy.paragis_poultice
          ], // Replace with the actual image path
          ingredients: [
            "A handful of fresh Paragis leaves",
          ],
          steps: [
            "1. Rinse the Paragis leaves thoroughly.",
            "2. Crush the leaves to release their juices (using a mortar and pestle or by hand).",
            "3. Apply the crushed leaves directly to the affected area.",
            "4. Cover with a clean cloth or bandage.",
          ],
          usage: [
            "Apply as needed to inflamed areas or minor wounds. Change the poultice daily."
          ],
          sideEffects: [
            "1. Allergic Reactions: Some individuals may experience skin rashes, itching, or swelling.",
            "2. Skin Irritation: Prolonged use may cause irritation or redness on the skin.",
            "3. Other Considerations: Always consult a healthcare professional before use, especially for pregnant or lactating women, and individuals with pre-existing skin conditions."
          ]),
      RemedyInfo(
          rating: 0,
          remedyType: "Herbal Remedy",
          remedyName: "Paragis Herbal Tea",
          treatment: "Respiratory Relief",
          description:
              "Paragis can be brewed into a soothing tea that helps alleviate coughs and respiratory discomfort.",
          remedyImages: [
            Application().remedy.paragis_poultice
          ],
          ingredients: [
            "Fresh Paragis leaves (6-8 pieces)",
            "1 cup of water",
            "Honey (optional, to taste)",
          ],
          steps: [
            "1. Rinse the Paragis leaves thoroughly.",
            "2. Boil 1 cup of water in a pot.",
            "3. Add the leaves to the boiling water.",
            "4. Let it steep for about 10 minutes.",
            "5. Strain, sweeten with honey if desired, and drink warm.",
          ],
          usage: [
            "Adults: 1 cup, as needed for respiratory relief.",
            "Children: Consult a pediatrician before use."
          ],
          sideEffects: [
            "1. Allergic Reactions: Some individuals may experience skin rashes, itching, or swelling.",
            "2. Gastrointestinal Issues: Overconsumption may lead to stomach cramps, nausea, or diarrhea.",
            "3. Other Considerations: Consult a healthcare professional before use, especially for pregnant or lactating women, and individuals with pre-existing health conditions."
          ]),
    ],
  ),
  PlantData(
    plantName: "Tsaang Gubat",
    scientificName: "Carmona retusa",
    plantImages: [
      Application().plant.PLNTIMG7,
    ],
    description:
        "Tsaang Gubat, or wild tea (Carmona retusa), is a small evergreen tree native to tropical regions, particularly in the Philippines. Known for its medicinal properties, the leaves are often brewed into tea and are traditionally used to treat various ailments, including digestive issues, skin conditions, and respiratory problems. Tsaang Gubat is appreciated for its soothing effects and is commonly used in herbal medicine.",
    treatments: [
      "Diarrhea",
      "Skin infections",
    ],
    remedyList: [
      RemedyInfo(
          rating: 0,
          remedyType: "Herbal Remedy",
          remedyName: "Tsaang Gubat Tea",
          treatment: "Diarrhea Relief",
          description:
              "The leaves can be brewed into a tea to help alleviate symptoms of diarrhea and to promote digestion.",
          remedyImages: [
            Application().remedy.tsaanGubat_tea,
          ],
          ingredients: [
            "Fresh Tsaang Gubat leaves (5-6 pieces)",
            "2 cups of water",
          ],
          steps: [
            "1. Wash the Tsaang Gubat leaves thoroughly.",
            "2. Boil 2 cups of water.",
            "3. Add the leaves to the boiling water.",
            "4. Let it simmer for 10-15 minutes.",
            "5. Strain and drink warm.",
          ],
          usage: [
            "Adults: 1 cup, 2 times a day.",
            "Children: Consult a pediatrician before use."
          ],
          sideEffects: [
            "1. Allergic Reactions: Some individuals may experience skin rashes, itching, or swelling.",
            "2. Gastrointestinal Issues: Overconsumption may lead to stomach cramps, nausea, or diarrhea.",
            "3. Dizziness: In some cases, dizziness or lightheadedness may occur.",
            "4. Other Considerations: Consult a healthcare professional before use, especially for pregnant or lactating women, and individuals with pre-existing health conditions."
          ]),
    ],
  ),
  PlantData(
    plantName: "Tanlad",
    scientificName: "Cymbopogon citratus",
    plantImages: [
      Application().plant.PLNTIMG8,
    ],
    description:
        "Tanlad, or lemongrass (Cymbopogon citratus), is a tropical plant known for its long, slender stalks and distinct lemony aroma. Commonly used in cooking for flavoring soups, curries, and teas, lemongrass is also valued for its medicinal properties, including anti-inflammatory and antimicrobial effects, making it a popular ingredient in traditional herbal remedies.",
    treatments: [
      "Digestive issues",
      "Anxiety relief",
      "Cold and flu symptoms",
    ],
    remedyList: [
      RemedyInfo(
          rating: 0,
          remedyType: "Herbal Remedy",
          remedyName: "Tanlad Tea",
          treatment: "Digestive Relief",
          description:
              "The leaves can be brewed into a tea to help alleviate digestive issues and promote digestion.",
          remedyImages: [
            Application().remedy.PLNTRMDY8,
          ],
          ingredients: [
            "Fresh Tanlad leaves (5-6 pieces)",
            "2 cups of water",
          ],
          steps: [
            "1. Wash the Tanlad leaves thoroughly.",
            "2. Boil 2 cups of water.",
            "3. Add the leaves to the boiling water.",
            "4. Let it simmer for 10-15 minutes.",
            "5. Strain and drink warm.",
          ],
          usage: [
            "Adults: 1 cup, 2 times a day.",
            "Children: Consult a pediatrician before use."
          ],
          sideEffects: [
            "1. Allergic Reactions: Some individuals may experience skin rashes, itching, or swelling.",
            "2. Gastrointestinal Issues: Overconsumption may lead to stomach cramps, nausea, or diarrhea.",
            "3. Dizziness: In some cases, dizziness or lightheadedness may occur.",
            "4. Other Considerations: Consult a healthcare professional before use, especially for pregnant or lactating women, and individuals with pre-existing health conditions."
          ]),
    ],
  ),
  PlantData(
    plantName: "Sabila",
    scientificName: "Aloe vera",
    plantImages: [
      Application().plant.PLNTIMG9,
    ],
    description:
        "Sabila, commonly known as aloe vera, is a succulent plant valued for its thick, fleshy leaves that contain a clear gel known for its soothing and healing properties. Widely used in skincare and traditional medicine, aloe vera is often applied topically for burns, cuts, and skin irritations, as well as consumed in juices and supplements for its digestive benefits.",
    treatments: [
      "Wound healing",
      "Skin hydration",
      "Digestive health",
    ],
    remedyList: [
      RemedyInfo(
          rating: 0,
          remedyType: "Herbal Remedy",
          remedyName: "Aloe Vera Gel",
          treatment: "Skin Hydration",
          description:
              "The gel extracted from the leaves can be applied to the skin to provide moisture and healing.",
          remedyImages: [
            Application().remedy.PLNTRMDY9,
          ],
          ingredients: [
            "Fresh Aloe vera leaf (1 piece)",
          ],
          steps: [
            "1. Cut an Aloe vera leaf and slice it open.",
            "2. Scoop out the gel from inside the leaf.",
            "3. Apply the gel directly to the skin.",
          ],
          usage: [
            "Apply as needed for skin hydration and healing."
          ],
          sideEffects: [
            "1. Allergic Reactions: Some individuals may experience skin rashes, itching, or swelling.",
            "2. Skin Irritation: In rare cases, prolonged use may cause irritation or redness on the skin.",
            "3. Gastrointestinal Issues: If ingested accidentally, it can cause nausea or stomach cramps.",
            "4. Other Considerations: Always consult a healthcare professional before use, especially for pregnant or lactating women, and individuals with pre-existing skin conditions."
          ]),
    ],
  ),
  PlantData(
    plantName: "Ginger",
    scientificName: "Zingiber officinale",
    plantImages: [
      Application().plant.PLNTIMG10,
    ],
    description:
        "Ginger (Zingiber officinale) is a flowering plant known for its aromatic rhizome, which is widely used as a spice and natural remedy in various cuisines around the world. Renowned for its anti-inflammatory and digestive benefits, ginger is commonly consumed fresh, dried, or powdered and is a popular ingredient in teas and culinary dishes.",
    treatments: [
      "Nausea",
      "Digestive discomfort",
      "Inflammation",
    ],
    remedyList: [
      RemedyInfo(
          rating: 0,
          remedyType: "Herbal Remedy",
          remedyName: "Ginger Tea",
          treatment: "Nausea Relief",
          description:
              "Ginger tea is consumed to relieve nausea, improve digestion, and reduce inflammation.",
          remedyImages: [
            Application().remedy.PLNTRMDY10,
          ],
          ingredients: [
            "Fresh ginger root (1-2 inches)",
            "2 cups of water",
            "Honey (optional)",
          ],
          steps: [
            "1. Peel and slice the ginger root.",
            "2. Boil 2 cups of water in a pot.",
            "3. Add the sliced ginger to the boiling water.",
            "4. Let it simmer for about 10 minutes.",
            "5. Strain, add honey if desired, and enjoy warm.",
          ],
          usage: [
            "Adults: 1-2 cups, as needed for nausea and digestive relief.",
            "Children: Consult a pediatrician before use."
          ],
          sideEffects: [
            "1. Allergic Reactions: Some individuals may experience skin rashes, itching, or swelling.",
            "2. Gastrointestinal Issues: Overconsumption may lead to stomach cramps, heartburn, or diarrhea.",
            "3. Blood Thinning: Ginger has mild blood-thinning properties, so it should be used with caution by individuals taking anticoagulant medications.",
            "4. Other Considerations: Always consult a healthcare professional before use, especially for pregnant or lactating women, and individuals with pre-existing health conditions."
          ]),
    ],
  ),
  PlantData(
    plantName: "luyang-dilaw",
    scientificName: "Curcuma longa",
    plantImages: [
      Application().plant.PLNTIMG11,
    ],
    description:
        "Luyang Dilaw, or turmeric (Curcuma longa), is a flowering plant belonging to the ginger family, renowned for its bright yellow rhizomes, which are used as a spice and natural remedy. Rich in curcumin, it is celebrated for its anti-inflammatory and antioxidant properties, making it a popular ingredient in both culinary dishes and traditional medicine practices.",
    treatments: [
      "Arthritis",
      "Joint pain",
      "Digestive issues",
    ],
    remedyList: [
      RemedyInfo(
          rating: 0,
          remedyType: "Herbal Remedy",
          remedyName: "Turmeric Milk",
          treatment: "Anti-inflammatory",
          description:
              "Turmeric milk is consumed to reduce inflammation and improve overall health.",
          remedyImages: [
            Application().remedy.PLNTRMDY11,
          ],
          ingredients: [
            "1 teaspoon turmeric powder",
            "1 cup milk (or plant-based milk)",
            "Honey (optional)",
          ],
          steps: [
            "1. Boil 1 cup of milk.",
            "2. Add 1 teaspoon of turmeric powder to the milk.",
            "3. Stir well and simmer for 5 minutes.",
            "4. Strain, add honey if desired, and enjoy warm.",
          ],
          usage: [
            "Adults: 1 cup daily for inflammation relief.",
            "Children: Consult a pediatrician before use."
          ],
          sideEffects: [
            "1. Allergic Reactions: Some individuals may experience skin rashes, itching, or swelling.",
            "2. Gastrointestinal Issues: Overconsumption may lead to stomach cramps, nausea, or diarrhea.",
            "3. Blood Thinning: Turmeric has mild blood-thinning properties, so it should be used with caution by individuals taking anticoagulant medications.",
            "4. Other Considerations: Always consult a healthcare professional before use, especially for pregnant or lactating women, and individuals with pre-existing health conditions."
          ]),
    ],
  ),
  PlantData(
    plantName: "Malungay",
    scientificName: "Malungay oleifera",
    plantImages: [
      Application().plant.PLNTIMG12,
    ],
    description:
        "Malunggay, or Moringa oleifera, is a nutrient-rich tree native to the Indian subcontinent, prized for its green leaves that are high in vitamins and minerals. Commonly used in Filipino cuisine and traditional medicine, it is often referred to as the 'miracle tree' for its health benefits and easy cultivation.",
    treatments: [
      "Nutritional support",
      "Blood sugar management",
    ],
    remedyList: [
      RemedyInfo(
          rating: 0,
          remedyType: "Herbal Remedy",
          remedyName: "Malungay Smoothie",
          treatment: "Nutritional Boost",
          description:
              "Malungay leaves can be added to smoothies for a nutrient-rich drink.",
          remedyImages: [
            Application().remedy.PLNTRMDY12,
          ],
          ingredients: [
            "Fresh Malungay leaves (1/2 cup)",
            "1 banana",
            "1 cup of milk (or plant-based milk)",
            "Honey (optional)",
          ],
          steps: [
            "1. Add fresh Malungay leaves, banana, and milk to a blender.",
            "2. Blend until smooth.",
            "3. Add honey if desired, and blend again.",
            "4. Serve immediately.",
          ],
          usage: [
            "Adults: 1 cup daily as a nutritional boost.",
            "Children: Consult a pediatrician before use."
          ],
          sideEffects: [
            "1. Allergic Reactions: Some individuals may experience skin rashes, itching, or swelling.",
            "2. Gastrointestinal Issues: Overconsumption may lead to stomach cramps, nausea, or diarrhea.",
            "3. Hypotension: Excessive consumption of Malungay can lower blood pressure, so it should be used with caution by individuals with low blood pressure or those taking antihypertensive medications.",
            "4. Other Considerations: Always consult a healthcare professional before use, especially for pregnant or lactating women, and individuals with pre-existing health conditions."
          ]),
    ],
  ),
];
