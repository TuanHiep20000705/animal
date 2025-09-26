class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HistoryController historyController = HistoryController();

    return BBSBaseScaffold<HistoryController>(
      controller: historyController,
      appBar: AppBar(
        title: const Text(
          "History",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      builder: (controller) {
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final item = controller.items[index];
            return Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF6F6FA),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    children: [
                      // số thứ tự
                      Text(
                        "${index + 1}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // ảnh
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          item['image']!,
                          width: 80,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // tên + tag
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "#analyze",
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // giờ
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      item['time']!,
                      style: const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class HistoryController extends BBSBaseController {
  final List<Map<String, String>> items = const [
    {
      'name': 'Meerkat',
      'time': '03:31 PM',
      'image':
      'https://upload.wikimedia.org/wikipedia/commons/4/49/Koala_climbing_tree.jpg',
    },
    {
      'name': 'Koala',
      'time': '03:30 PM',
      'image':
      'https://upload.wikimedia.org/wikipedia/commons/4/49/Koala_climbing_tree.jpg',
    },
    {
      'name': 'Fennec Fox',
      'time': '03:29 PM',
      'image':
      'https://upload.wikimedia.org/wikipedia/commons/4/49/Koala_climbing_tree.jpg',
    },
  ];
}

class FavoritesScreen extends StatelessWidget {

  FavoritesScreen({super.key});

  final List<Map<String, dynamic>> favorites = [
    {
      "image": "https://upload.wikimedia.org/wikipedia/commons/9/9b/Fennec_Fox.jpg",
      "title": "Fennec Fox",
      "tag": "#analyze",
      "tagColor": Colors.orange,
    },
    {
      "image": "https://upload.wikimedia.org/wikipedia/commons/9/9e/Poison_dart_frog.jpg",
      "title": "Poison Dart Frog",
      "tag": "#explore",
      "tagColor": Colors.green,
    },
    {
      "image": "https://upload.wikimedia.org/wikipedia/commons/2/2e/Psittacus_erithacus_-perching_on_tray-8a.jpg",
      "title": "African Grey Parrot",
      "tag": "#explore",
      "tagColor": Colors.green,
    },
    {
      "image": "https://upload.wikimedia.org/wikipedia/commons/0/07/Leafy_Sea_Dragon.jpg",
      "title": "Leafy Sea Dragon",
      "tag": "#explore",
      "tagColor": Colors.green,
    },
    {
      "image": "https://upload.wikimedia.org/wikipedia/commons/5/5e/Pangolin.jpg",
      "title": "Pangolin",
      "tag": "#explore",
      "tagColor": Colors.green,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorites",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: ListView.separated(
        itemCount: favorites.length,
        separatorBuilder: (_, __) => Divider(height: 1, color: Colors.grey.shade300),
        itemBuilder: (context, index) {
          final item = favorites[index];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item["image"],
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              item["title"],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              item["tag"],
              style: TextStyle(color: item["tagColor"]),
            ),
            trailing: Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              // TODO: xử lý khi click vào item
            },
          );
        },
      ),
    );
  }
}