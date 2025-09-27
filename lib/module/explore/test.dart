// lib/main.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../api/model/animal_info.dart';
import '../../api/model/animal_scan_data.dart';
import '../../api/model/behavior.dart';
import '../../api/model/classification.dart';
import '../../api/model/conservation_status.dart';
import '../../api/model/database_helper.dart';
import '../../api/model/diet.dart';
import '../../api/model/habitat.dart';
import '../../api/model/human_interaction.dart';
import '../../api/model/physical_traits.dart';
import '../../api/model/reproduction.dart';
import '../../shared/resources/resource.dart';
import '../../shared/widgets/bbs_base_controller.dart';
import '../../shared/widgets/widgets.dart';

const List<Map<String, String>> rarestAnimals = [
  {
    'name': 'Amur Leopard',
    'image':
    'https://upload.wikimedia.org/wikipedia/commons/3/32/Amur_leopard.jpg',
  },
  {
    'name': 'Vaquita',
    'image': 'https://upload.wikimedia.org/wikipedia/commons/1/12/Vaquita.jpg',
  },
  {
    'name': 'Box Jellyfish',
    'image':
    'https://upload.wikimedia.org/wikipedia/commons/9/96/Box_jellyfish_Chironex_fleckeri.jpg',
  },
];

const List<Map<String, String>> largestCreatures = [
  {
    'name': 'Blue Whale',
    'image':
    'https://upload.wikimedia.org/wikipedia/commons/5/55/Blue_whale_2.jpg',
  },
  {
    'name': 'African Elephant',
    'image':
    'https://upload.wikimedia.org/wikipedia/commons/3/37/African_Bush_Elephant.jpg',
  },
  {
    'name': 'Whale Shark',
    'image':
    'https://upload.wikimedia.org/wikipedia/commons/5/56/Whale_shark_%28Rhincodon_typus%29.jpg',
  },
];

const List<Map<String, String>> underwaterCreatures = [
  {
    'name': 'Blue Whale',
    'image':
    'https://upload.wikimedia.org/wikipedia/commons/5/55/Blue_whale_2.jpg',
  },
  {
    'name': 'Giant Squid',
    'image':
    'https://upload.wikimedia.org/wikipedia/commons/4/4b/Giant_squid_art.jpg',
  },
  {
    'name': 'Orca (Killer Whale)',
    'image':
    'https://upload.wikimedia.org/wikipedia/commons/0/06/Orca_SanJuanIslands.jpg',
  },
  {
    'name': 'Great White Shark',
    'image':
    'https://upload.wikimedia.org/wikipedia/commons/5/56/White_shark.jpg',
  },
  {
    'name': 'Dumbo Octopus',
    'image':
    'https://upload.wikimedia.org/wikipedia/commons/6/66/Dumbo_octopus.jpg',
  },
  {
    'name': 'Clownfish',
    'image':
    'https://upload.wikimedia.org/wikipedia/commons/6/6d/Clown_fish.jpg',
  },
];

class ExploreScreen2 extends StatelessWidget {
  // key của ListView (để xác định vùng viewport chính xác)
  final GlobalKey _listKey = GlobalKey();

  // key của widget chúng ta muốn theo dõi (ví dụ: nút Scan)
  final GlobalKey _targetKey = GlobalKey();

  // trạng thái:  1 = fully visible, -1 = fully invisible, 0 = partially visible / unknown
  final ValueNotifier<int> _visibilityState = ValueNotifier<int>(0);

  bool _isVisible = true;

  void _checkVisibility(BuildContext context) {
    try {
      final RenderBox? listBox =
      _listKey.currentContext?.findRenderObject() as RenderBox?;
      final RenderBox? targetBox =
      _targetKey.currentContext?.findRenderObject() as RenderBox?;

      if (listBox == null || targetBox == null) return;

      // tọa độ viewport (ListView) trên màn hình
      final Offset listTopLeft = listBox.localToGlobal(Offset.zero);
      final double viewportTop = listTopLeft.dy;
      final double viewportBottom = viewportTop + listBox.size.height;

      // tọa độ widget trên màn hình
      final Offset targetTopLeft = targetBox.localToGlobal(Offset.zero);
      final double targetTop = targetTopLeft.dy;
      final double targetBottom = targetTop + targetBox.size.height;

      // fully visible: toàn bộ widget nằm trong [viewportTop, viewportBottom]
      final bool fullyVisible =
          (targetTop >= viewportTop) && (targetBottom <= viewportBottom);

      // fully invisible: hoàn toàn trên hoặc hoàn toàn dưới viewport
      final bool fullyInvisible =
          (targetBottom <= viewportTop) || (targetTop >= viewportBottom);

      if (fullyVisible && _visibilityState.value != 1 && !_isVisible) {
        _visibilityState.value = 1;
        _isVisible = true;
        debugPrint("✅ Widget đã **hiển thị hoàn toàn** trong viewport");
      } else if (fullyInvisible && _visibilityState.value != -1 && _isVisible) {
        _visibilityState.value = -1;
        _isVisible = false;
        debugPrint("❌ Widget đã **biến mất hoàn toàn** khỏi viewport");
      } else if (!fullyVisible &&
          !fullyInvisible &&
          _visibilityState.value != 0) {
        // partial visibility (không in)
        _visibilityState.value = 0;
      }
    } catch (e) {
      // an toàn: nếu có lỗi ignore
    }
  }

  ExploreScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    ExploreController2 exploreController2 = ExploreController2();

    return BBSBaseScaffold<ExploreController2>(
      controller: exploreController2,
      backgroundColor: AppColors.white,
      initState: (controller) async {
        await controller.initData();
      },
      builder: (controller) {
        return NotificationListener(
          onNotification: (scrollNotification) {
            // gọi check mỗi lần scroll, nhưng chỉ in khi trạng thái thay đổi
            _checkVisibility(context);
            return false; // không chặn notification
          },
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const BBSText(
                    margin:
                    EdgeInsets.only(right: 8, top: 12, bottom: 6),
                    content: 'Animal Identifier',
                    color: Colors.black,
                    textAlign: TextAlign.center,
                    fontSize: 16,
                    fontFamily: 'lato_bold',
                  ),
                  BBSGesture(
                    padding: const EdgeInsets.only(right: 12, top: 12, bottom: 6),
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFCD534),
                            Color(0xFFFD9800),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const BBSText(
                        margin:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        content: 'Go Premium',
                        color: Colors.black,
                        textAlign: TextAlign.center,
                        fontSize: 15,
                        fontFamily: 'lato_bold',
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  key: _listKey,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 6),
                    // Big scan button
                    ElevatedButton(
                      key: _targetKey,
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 84),
                        backgroundColor: AppColors.colorFF34C759, // green
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BBSImage(
                            Constants.icScanAnimal,
                            height: 30,
                            width: 30,
                            color: AppColors.white,
                            fit: BoxFit.scaleDown,
                          ),
                          BBSText(
                            margin:
                            EdgeInsets.only(top: 6),
                            content: 'Scan Animal',
                            color: Colors.white,
                            textAlign: TextAlign.center,
                            fontSize: 16,
                            fontFamily: 'dmsans_bold',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Rarest Animals (horizontal list)
                    sectionTitle('Rarest Animals on Earth'),
                    const SizedBox(height: 4),
                    SizedBox(
                      height: 200,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.rarestAnimalsOnEarth.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final item = controller.rarestAnimalsOnEarth[index];
                          return WideAnimalCard(
                            animalScanData: item,
                            width: 231,
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // World's Largest Creatures (horizontal list)
                    sectionTitle('World’s Largest Creatures'),
                    const SizedBox(height: 4),
                    SizedBox(
                      height: 200,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.worldLargestCreatures.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final item = controller.worldLargestCreatures[index];
                          return WideAnimalCard(
                            animalScanData: item,
                            width: 231,
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // World's Largest Creatures (horizontal list)
                    sectionTitle('Fastest Animals Alive'),
                    const SizedBox(height: 4),
                    SizedBox(
                      height: 200,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.fastestAnimalAlive.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final item = controller.fastestAnimalAlive[index];
                          return WideAnimalCard(
                            animalScanData: item,
                            width: 231,
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // World's Largest Creatures (horizontal list)
                    sectionTitle('The Smartest Species'),
                    const SizedBox(height: 4),
                    SizedBox(
                      height: 200,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.smartestSpecies.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final item = controller.smartestSpecies[index];
                          return WideAnimalCard(
                            animalScanData: item,
                            width: 231,
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // World's Largest Creatures (horizontal list)
                    sectionTitle('Most Dangerous Animals'),
                    const SizedBox(height: 4),
                    SizedBox(
                      height: 200,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.mostDangerousAnimals.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final item = controller.mostDangerousAnimals[index];
                          return WideAnimalCard(
                            animalScanData: item,
                            width: 231,
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Underwater Creatures as horizontal grid with 2 rows
                    sectionTitle('Underwater Creatures'),
                    const SizedBox(height: 4),

                    // Height should be enough to fit 2 rows of cards
                    SizedBox(
                      height: 450,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.underwaterCreatures.length,
                        padding: EdgeInsets.zero,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 rows
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1.75, // width / height of each tile
                        ),
                        itemBuilder: (context, index) {
                          final item = controller.underwaterCreatures[index];
                          return TallAnimalCard(
                            animalScanData: item,
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Underwater Creatures as horizontal grid with 2 rows
                    sectionTitle('Forest Inhabitants'),
                    const SizedBox(height: 4),

                    // Height should be enough to fit 2 rows of cards
                    SizedBox(
                      height: 450,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.forestInhabitants.length,
                        padding: EdgeInsets.zero,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 rows
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1.75, // width / height of each tile
                        ),
                        itemBuilder: (context, index) {
                          final item = controller.forestInhabitants[index];
                          return TallAnimalCard(
                            animalScanData: item,
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Underwater Creatures as horizontal grid with 2 rows
                    sectionTitle('Arctic Wildlife'),
                    const SizedBox(height: 4),

                    // Height should be enough to fit 2 rows of cards
                    SizedBox(
                      height: 450,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.arcticWildlife.length,
                        padding: EdgeInsets.zero,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 rows
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1.75, // width / height of each tile
                        ),
                        itemBuilder: (context, index) {
                          final item = controller.arcticWildlife[index];
                          return TallAnimalCard(
                            animalScanData: item,
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Underwater Creatures as horizontal grid with 2 rows
                    sectionTitle('Desert Dwellers'),
                    const SizedBox(height: 4),

                    // Height should be enough to fit 2 rows of cards
                    SizedBox(
                      height: 450,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.desertDwellers.length,
                        padding: EdgeInsets.zero,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 rows
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1.75, // width / height of each tile
                        ),
                        itemBuilder: (context, index) {
                          final item = controller.desertDwellers[index];
                          return TallAnimalCard(
                            animalScanData: item,
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Underwater Creatures as horizontal grid with 2 rows
                    sectionTitle('High-Altitude Species'),
                    const SizedBox(height: 4),

                    // Height should be enough to fit 2 rows of cards
                    SizedBox(
                      height: 450,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.highAltitudeSpecies.length,
                        padding: EdgeInsets.zero,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 rows
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1.75, // width / height of each tile
                        ),
                        itemBuilder: (context, index) {
                          final item = controller.highAltitudeSpecies[index];
                          return TallAnimalCard(
                            animalScanData: item,
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Underwater Creatures as horizontal grid with 2 rows
                    sectionTitle('Extinct Animals'),
                    const SizedBox(height: 4),

                    // Height should be enough to fit 2 rows of cards
                    SizedBox(
                      height: 450,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.extinctAnimals.length,
                        padding: EdgeInsets.zero,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 rows
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1.75, // width / height of each tile
                        ),
                        itemBuilder: (context, index) {
                          final item = controller.extinctAnimals[index];
                          return TallAnimalCard(
                            animalScanData: item,
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4),
      child: BBSText(
        content: text,
        fontSize: 16,
        color: Colors.black,
        fontFamily: 'dmsans_bold',),
    );
  }
}

class ExploreController2 extends BBSBaseController {
  List<AnimalScanData> rarestAnimalsOnEarth = [];

  List<AnimalScanData> worldLargestCreatures = [];

  List<AnimalScanData> fastestAnimalAlive = [];

  List<AnimalScanData> smartestSpecies = [];

  List<AnimalScanData> mostDangerousAnimals = [];

  List<AnimalScanData> underwaterCreatures = [];

  List<AnimalScanData> forestInhabitants = [];

  List<AnimalScanData> arcticWildlife = [];

  List<AnimalScanData> desertDwellers = [];

  List<AnimalScanData> highAltitudeSpecies = [];

  List<AnimalScanData> extinctAnimals = [];

  Future<void> initData() async {
    // Ví dụ: đọc file rarest_animals.json
    final jsonRarestAnimalStr = await rootBundle.loadString('assets/jsons/rarest_animals.json');
    final jsonLargestAnimalStr = await rootBundle.loadString('assets/jsons/largest_animals.json');
    final jsonFastestAnimalStr = await rootBundle.loadString('assets/jsons/fastest_animals.json');
    final jsonSmartestAnimalStr = await rootBundle.loadString('assets/jsons/smartest_animals.json');
    final jsonDangerousAnimalStr = await rootBundle.loadString('assets/jsons/dangerous_animals.json');
    final jsonUnderWaterAnimalStr = await rootBundle.loadString('assets/jsons/underwater_animals.json');
    final jsonForestAnimalStr = await rootBundle.loadString('assets/jsons/forest_animals.json');
    final jsonArcticAnimalStr = await rootBundle.loadString('assets/jsons/arctic_animals.json');
    final jsonDesertAnimalStr = await rootBundle.loadString('assets/jsons/desert_animals.json');
    final jsonHighAltitudeAnimalStr = await rootBundle.loadString('assets/jsons/high_altitude_animals.json');
    final jsonExtinctAnimalStr = await rootBundle.loadString('assets/jsons/extinct_animals.json');

    final rarestAnimals = parseAnimalScanDataList(jsonRarestAnimalStr);
    final largestAnimals = parseAnimalScanDataList(jsonLargestAnimalStr);
    final fastestAnimals = parseAnimalScanDataList(jsonFastestAnimalStr);
    final smartestAnimals = parseAnimalScanDataList(jsonSmartestAnimalStr);
    final dangerousAnimals = parseAnimalScanDataList(jsonDangerousAnimalStr);
    final underWaterAnimalStr = parseAnimalScanDataList(jsonUnderWaterAnimalStr);
    final forestAnimalStr = parseAnimalScanDataList(jsonForestAnimalStr);
    final arcticAnimalStr = parseAnimalScanDataList(jsonArcticAnimalStr);
    final desertAnimalStr = parseAnimalScanDataList(jsonDesertAnimalStr);
    final highAltitudeAnimalStr = parseAnimalScanDataList(jsonHighAltitudeAnimalStr);
    final extinctAnimalStr = parseAnimalScanDataList(jsonExtinctAnimalStr);

    rarestAnimalsOnEarth.addAll(rarestAnimals);
    worldLargestCreatures.addAll(largestAnimals);
    fastestAnimalAlive.addAll(fastestAnimals);
    smartestSpecies.addAll(smartestAnimals);
    mostDangerousAnimals.addAll(dangerousAnimals);
    underwaterCreatures.addAll(underWaterAnimalStr);
    forestInhabitants.addAll(forestAnimalStr);
    arcticWildlife.addAll(arcticAnimalStr);
    desertDwellers.addAll(desertAnimalStr);
    highAltitudeSpecies.addAll(highAltitudeAnimalStr);
    extinctAnimals.addAll(extinctAnimalStr);


    // final animal = AnimalScanData(imageHome: 'assets/images/img_amur_leopard.jpg', imagePath: null, animalInfo: AnimalInfo(commonName: 'Amur Leopard', scientificName: 'Panthera pardus orientalis', otherNames: ['Far Eastern Leopard', 'Manchurian Leopard'], classification: Classification(kingdom: 'Animalia', phylum: 'Chordata', clazz: 'Mammalia', order: 'Carnivora', family: 'Felidae', genus: 'Panthera', species: 'pardus orientalis'), habitat: Habitat(environment: 'Temperate forests', distribution: 'Russian Far East and Northeast China', countries: ['Russia', 'China']), physicalTraits: PhysicalTraits(size: '90–110 cm', weight: '32–48 kg', color: 'Cream with black rosettes', lifespan: '10–15 years', specialTraits: ['Thick fur', 'Excellent climber']), diet: Diet(type: 'Carnivore', foods: ['Deer', 'Hares', 'Wild boar']), behavior: Behavior(activityTime: 'Nocturnal', socialType: 'Solitary', intelligenceLevel: 'High', communication: 'Vocal and scent markings'), reproduction: Reproduction(maturityAge: '2–3 years', gestationPeriod: '90–105 days', offspringPerBirth: '1–4', reproductionCycle: 'Biennial'), conservationStatus: ConservationStatus(iUCNStatus: 'Critically Endangered', populationTrend: 'Decreasing', threats: ['Poaching', 'Habitat loss', 'Inbreeding']), humanInteraction: HumanInteraction(dangerLevel: 'Low', petFriendly: false, legalStatus: 'Protected', notes: 'Extremely rare and shy'), funFacts: ['Can leap over 10 feet vertically', 'Less than 100 individuals remain']), dateTime: '2025-09-24', animalActionType: AnimalActionType.explore, isHistory: false, isFavorite: false);
    // await DatabaseHelper.instance.create(animal);

    final data = await DatabaseHelper.instance.readAllAnimalScanData();
    print('dataaaa: ${data.length}');
    notifyListeners();
  }
}

List<AnimalScanData> parseAnimalScanDataList(String jsonStr) {
  final List<dynamic> data = jsonDecode(jsonStr);

  return List<AnimalScanData>.generate(data.length, (index) {
    final item = data[index];
    final info = item['animalInfo'];

    // Tạo imageHome từ commonName
    String commonName = (info['CommonName'] ?? '').toString();
    String imageHome = "assets/images/img_${commonName.toLowerCase().replaceAll(' ', '_')}.jpg";

    return AnimalScanData(
      id: index,
      imageHome: imageHome,
      imagePath: null,
      dateTime: '',
      isHistory: false,
      isFavorite: false,
      animalActionType: AnimalActionType.explore, // từ actionType, bạn có thể map enum khác nếu cần
      animalInfo: AnimalInfo(
        commonName: info['CommonName'],
        scientificName: info['ScientificName'],
        otherNames: List<String>.from(info['OtherNames'] ?? []),
        classification: Classification(
          kingdom: info['Classification']?['Kingdom'],
          phylum: info['Classification']?['Phylum'],
          clazz: info['Classification']?['Class'],
          order: info['Classification']?['Order'],
          family: info['Classification']?['Family'],
          genus: info['Classification']?['Genus'],
          species: info['Classification']?['Species'],
        ),
        habitat: Habitat(
          environment: info['Habitat']?['Environment'],
          distribution: info['Habitat']?['Distribution'],
          countries: List<String>.from(info['Habitat']?['Countries'] ?? []),
        ),
        physicalTraits: PhysicalTraits(
          size: info['PhysicalTraits']?['Size'],
          weight: info['PhysicalTraits']?['Weight'],
          color: info['PhysicalTraits']?['Color'],
          lifespan: info['PhysicalTraits']?['Lifespan'],
          specialTraits: List<String>.from(info['PhysicalTraits']?['SpecialTraits'] ?? []),
        ),
        diet: Diet(
          type: info['Diet']?['Type'],
          foods: List<String>.from(info['Diet']?['Foods'] ?? []),
        ),
        behavior: Behavior(
          activityTime: info['Behavior']?['ActivityTime'],
          socialType: info['Behavior']?['SocialType'],
          intelligenceLevel: info['Behavior']?['IntelligenceLevel'],
          communication: info['Behavior']?['Communication'],
        ),
        reproduction: Reproduction(
          maturityAge: info['Reproduction']?['MaturityAge'],
          gestationPeriod: info['Reproduction']?['GestationPeriod'],
          offspringPerBirth: info['Reproduction']?['OffspringPerBirth'],
          reproductionCycle: info['Reproduction']?['ReproductionCycle'],
        ),
        conservationStatus: ConservationStatus(
          iUCNStatus: info['ConservationStatus']?['IUCNStatus'],
          populationTrend: info['ConservationStatus']?['PopulationTrend'],
          threats: List<String>.from(info['ConservationStatus']?['Threats'] ?? []),
        ),
        humanInteraction: HumanInteraction(
          dangerLevel: info['HumanInteraction']?['DangerLevel'],
          petFriendly: info['HumanInteraction']?['PetFriendly'] ?? false,
          legalStatus: info['HumanInteraction']?['LegalStatus'],
          notes: info['HumanInteraction']?['Notes'],
        ),
        funFacts: List<String>.from(info['FunFacts'] ?? []),
      ),
    );
  });
}

List<AnimalScanData> parseAnimalScanDataListFromInfoJson(String jsonStr) {
  final List<dynamic> data = jsonDecode(jsonStr);

  return List<AnimalScanData>.generate(data.length, (index) {
    final info = data[index];

    // Tạo imageHome từ CommonName
    String commonName = (info['CommonName'] ?? '').toString();
    String imageHome = "img_${commonName.toLowerCase()
        .replaceAll(' ', '_')
        .replaceAll('-', '_')}.jpg";

    return AnimalScanData(
      id: index,
      imageHome: imageHome,
      imagePath: null,
      dateTime: '',
      isHistory: false,
      isFavorite: false,
      animalActionType: AnimalActionType.explore, // mặc định explore
      animalInfo: AnimalInfo(
        commonName: info['CommonName'],
        scientificName: info['ScientificName'],
        otherNames: List<String>.from(info['OtherNames'] ?? []),
        classification: Classification(
          kingdom: info['Classification']?['Kingdom'],
          phylum: info['Classification']?['Phylum'],
          clazz: info['Classification']?['Class'],
          order: info['Classification']?['Order'],
          family: info['Classification']?['Family'],
          genus: info['Classification']?['Genus'],
          species: info['Classification']?['Species'],
        ),
        habitat: Habitat(
          environment: info['Habitat']?['Environment'],
          distribution: info['Habitat']?['Distribution'],
          countries: List<String>.from(info['Habitat']?['Countries'] ?? []),
        ),
        physicalTraits: PhysicalTraits(
          size: info['PhysicalTraits']?['Size'],
          weight: info['PhysicalTraits']?['Weight'],
          color: info['PhysicalTraits']?['Color'],
          lifespan: info['PhysicalTraits']?['Lifespan'],
          specialTraits: List<String>.from(info['PhysicalTraits']?['SpecialTraits'] ?? []),
        ),
        diet: Diet(
          type: info['Diet']?['Type'],
          foods: List<String>.from(info['Diet']?['Foods'] ?? []),
        ),
        behavior: Behavior(
          activityTime: info['Behavior']?['ActivityTime'],
          socialType: info['Behavior']?['SocialType'],
          intelligenceLevel: info['Behavior']?['IntelligenceLevel'],
          communication: info['Behavior']?['Communication'],
        ),
        reproduction: Reproduction(
          maturityAge: info['Reproduction']?['MaturityAge'],
          gestationPeriod: info['Reproduction']?['GestationPeriod'],
          offspringPerBirth: info['Reproduction']?['OffspringPerBirth'],
          reproductionCycle: info['Reproduction']?['ReproductionCycle'],
        ),
        conservationStatus: ConservationStatus(
          iUCNStatus: info['ConservationStatus']?['IUCNStatus'],
          populationTrend: info['ConservationStatus']?['PopulationTrend'],
          threats: List<String>.from(info['ConservationStatus']?['Threats'] ?? []),
        ),
        humanInteraction: HumanInteraction(
          dangerLevel: info['HumanInteraction']?['DangerLevel'],
          petFriendly: info['HumanInteraction']?['PetFriendly'] ?? false,
          legalStatus: info['HumanInteraction']?['LegalStatus'],
          notes: info['HumanInteraction']?['Notes'],
        ),
        funFacts: List<String>.from(info['FunFacts'] ?? []),
      ),
    );
  });
}

/// Wide card used by horizontal lists (Rarest, Largest)
class WideAnimalCard extends StatelessWidget {
  final AnimalScanData animalScanData;
  final double width;

  const WideAnimalCard({
    super.key,
    required this.animalScanData,
    this.width = 280,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200, width: 1.2),
          ),
          child: Material(
            color: Colors.white,
            elevation: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image area
                Expanded(
                  child: BBSImage(
                    animalScanData.imageHome,
                    radius: 0,
                    fit: BoxFit.cover,
                    onTap: () { },
                  ),
                ),

                // label area
                Container(
                  height: 34,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade200, width: 1.2),
                    ),
                  ),
                  child: BBSText(
                    content: animalScanData.animalInfo.commonName,
                    textAlign: TextAlign.center,
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'lato_bold',),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Tall card used in underwater grid (two rows)
class TallAnimalCard extends StatelessWidget {
  final AnimalScanData animalScanData;

  const TallAnimalCard({
    super.key,
    required this.animalScanData
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: BBSImage(
              animalScanData.imageHome,
              width: 85,
              fit: BoxFit.cover,
            ),
          ),
        ),
        BBSText(
          content: animalScanData.animalInfo.commonName,
          textAlign: TextAlign.left,
          margin: const EdgeInsets.only(top: 8.0),
          fontSize: 12,
          color: Colors.black,
          fontFamily: 'lato_bold',),
      ],
    );
  }
}
