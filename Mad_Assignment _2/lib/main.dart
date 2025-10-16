import 'package:flutter/material.dart';

void main() {
  runApp(const TravelGuideApp());
}

class TravelGuideApp extends StatelessWidget {
  const TravelGuideApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Guide',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const MainScaffold(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({Key? key}) : super(key: key);

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ListScreen(),
    AboutScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // If a drawer is open, close it.
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Travel Guide')),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              const DrawerHeader(
                child: Center(
                    child:
                        Text('Travel Guide', style: TextStyle(fontSize: 24))),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () => _onItemTapped(0),
              ),
              ListTile(
                leading: const Icon(Icons.list),
                title: const Text('List'),
                onTap: () => _onItemTapped(1),
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('About'),
                onTap: () => _onItemTapped(2),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(child: _screens[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Travel image
          Image.network(
            'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
            height: 200,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return SizedBox(
                height: 200,
                child: Center(
                    child: CircularProgressIndicator(
                        value: progress.expectedTotalBytes != null
                            ? progress.cumulativeBytesLoaded /
                                (progress.expectedTotalBytes ?? 1)
                            : null)),
              );
            },
          ),

          const SizedBox(height: 12),

          // Welcome container
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(8)),
            child: const Text(
              'Welcome to Travel Guide — your companion for exploring beautiful destinations around the world.',
              style: TextStyle(fontSize: 16),
            ),
          ),

          const SizedBox(height: 12),

          // RichText slogan
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                      text: 'Explore ',
                      style: TextStyle(fontSize: 22, color: Colors.black)),
                  TextSpan(
                      text: 'the World',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal)),
                  TextSpan(
                      text: ' with Us',
                      style: TextStyle(fontSize: 22, color: Colors.orange)),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // TextField
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                  labelText: 'Enter destination', border: OutlineInputBorder()),
            ),
          ),

          const SizedBox(height: 12),

          // Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final text = _controller.text.trim();
                      final message = text.isEmpty
                          ? 'Explore button pressed'
                          : 'Explore: $text';
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(message)));
                      // Also print to console
                      // ignore: avoid_print
                      print(message);
                    },
                    child: const Text('Explore'),
                  ),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: () {
                    // Simple action: clear the field and show message
                    _controller.clear();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Cleared')));
                    // ignore: avoid_print
                    print('Clear button pressed');
                  },
                  child: const Text('Clear'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  static final List<Map<String, String>> destinations = List.generate(
    10,
    (i) => {
      'name': [
        'Paris',
        'Tokyo',
        'New York',
        'Rome',
        'Sydney',
        'Cairo',
        'Barcelona',
        'Rio de Janeiro',
        'Cape Town',
        'Bangkok'
      ][i],
      'desc': [
        'City of lights',
        'Land of the rising sun',
        'The Big Apple',
        'Ancient ruins & gelato',
        'Harbour city',
        'Pyramids and Nile',
        'Gaudí and beaches',
        'Carnival & beaches',
        'Table Mountain',
        'Temples and markets'
      ][i],
    },
  );

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemBuilder: (context, index) {
        final dest = destinations[index];
        return ListTile(
          leading: CircleAvatar(child: Text(dest['name']![0])),
          title: Text(dest['name']!),
          subtitle: Text(dest['desc']!),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Selected ${dest['name']}')));
            // ignore: avoid_print
            print('Tapped ${dest['name']}');
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: destinations.length,
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  static final List<Map<String, String>> landmarks = [
    {
      'title': 'Eiffel Tower',
      'image': 'https://images.unsplash.com/photo-1528291151370-2064f57c3b1a'
    },
    {
      'title': 'Great Wall',
      'image': 'https://images.unsplash.com/photo-1549880338-65ddcdfd017b'
    },
    {
      'title': 'Statue of Liberty',
      'image': 'https://images.unsplash.com/photo-1505685296765-3a2736de412f'
    },
    {
      'title': 'Colosseum',
      'image': 'https://images.unsplash.com/photo-1505761671935-60b3a7427bad'
    },
    {
      'title': 'Sydney Opera',
      'image': 'https://images.unsplash.com/photo-1506973035872-a4ec16b8e8d9'
    },
    {
      'title': 'Christ the Redeemer',
      'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        itemCount: landmarks.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.95,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8),
        itemBuilder: (context, index) {
          final item = landmarks[index];
          return Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(8)),
                    child: Image.network(
                      item['image']!,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item['title']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
