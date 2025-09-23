// lib/main.dart
import 'package:base_project/shared/resources/resource.dart';
import 'package:base_project/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      // AppBar giống ảnh (title + Go Premium button)
      body: NotificationListener(
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

                  const SizedBox(height: 20),

                  // Rarest Animals (horizontal list)
                  sectionTitle('Rarest Animals on Earth'),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: rarestAnimals.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final item = rarestAnimals[index];
                        return WideAnimalCard(
                          imageUrl: item['image']!,
                          name: item['name']!,
                          width: 300,
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // World's Largest Creatures (horizontal list)
                  sectionTitle('World’s Largest Creatures'),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: largestCreatures.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final item = largestCreatures[index];
                        return WideAnimalCard(
                          imageUrl: item['image']!,
                          name: item['name']!,
                          width: 300,
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Underwater Creatures as horizontal grid with 2 rows
                  sectionTitle('Underwater Creatures'),
                  const SizedBox(height: 8),

                  // Height should be enough to fit 2 rows of cards
                  SizedBox(
                    height: 360,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: underwaterCreatures.length,
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 rows
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.7, // width / height of each tile
                      ),
                      itemBuilder: (context, index) {
                        final item = underwaterCreatures[index];
                        return TallAnimalCard(
                          imageUrl: item['image']!,
                          name: item['name']!,
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4),
      child: Text(text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}

/// Wide card used by horizontal lists (Rarest, Largest)
class WideAnimalCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double width;

  const WideAnimalCard({
    super.key,
    required this.imageUrl,
    required this.name,
    this.width = 280,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.white,
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image area
              Expanded(
                child: Container(
                  color: Colors.grey.shade200,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            value: progress.expectedTotalBytes != null
                                ? progress.cumulativeBytesLoaded /
                                    progress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (_, __, ___) =>
                        const Center(child: Icon(Icons.broken_image)),
                  ),
                ),
              ),

              // label area
              Container(
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade200, width: 1.2),
                  ),
                ),
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Tall card used in underwater grid (two rows)
class TallAnimalCard extends StatelessWidget {
  final String imageUrl;
  final String name;

  const TallAnimalCard({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Material(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                color: Colors.grey.shade200,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Center(
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          value: progress.expectedTotalBytes != null
                              ? progress.cumulativeBytesLoaded /
                                  progress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (_, __, ___) =>
                      const Center(child: Icon(Icons.broken_image)),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6),
              child: Text(
                name,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
