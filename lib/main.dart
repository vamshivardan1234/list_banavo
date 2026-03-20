import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const ListBanavo());
}

// ============ Models ============
class Product {
  final String id;
  final String name;
  final double mrp;
  final int dailyLimit;
  final String category;
  final String unit;
  final String? imageUrl;
  final String? imageAsset;

  Product({
    required this.id,
    required this.name,
    required this.mrp,
    required this.dailyLimit,
    required this.category,
    required this.unit,
    this.imageUrl,
    this.imageAsset,
  });
}

class ShoppingListItem {
  final String productId;
  final String productName;
  final int dailyLimit;
  final double mrp;
  final String unit;
  int currentStock;
  int quantityNeeded;
  final String? imageUrl;
  final String? imageAsset;

  ShoppingListItem({
    required this.productId,
    required this.productName,
    required this.dailyLimit,
    required this.mrp,
    required this.unit,
    required this.currentStock,
    this.quantityNeeded = 0,
    this.imageUrl,
    this.imageAsset,
  });

  double get totalCost => quantityNeeded * mrp;
}

class ShoppingList {
  final String id;
  final DateTime createdDate;
  final List<ShoppingListItem> items;
  final String notes;

  ShoppingList({
    required this.id,
    required this.createdDate,
    required this.items,
    this.notes = '',
  });

  double get grandTotal => items.fold(0, (sum, item) => sum + item.totalCost);
  int get totalItems => items.fold(0, (sum, item) => sum + item.quantityNeeded);
}

class DailyReport {
  final DateTime date;
  final List<ShoppingList> lists;

  DailyReport({
    required this.date,
    required this.lists,
  });

  double get totalSpent => lists.fold(0, (sum, list) => sum + list.grandTotal);
  int get totalLists => lists.length;
  int get totalItems => lists.fold(0, (sum, list) => sum + list.totalItems);

  String get csvFormat {
    StringBuffer csv = StringBuffer();
    csv.writeln('Date,${DateFormat('dd/MM/yyyy').format(date)}');
    csv.writeln('');
    csv.writeln('Summary');
    csv.writeln('Total Lists,Total Items,Total Spent');
    csv.writeln('$totalLists,$totalItems,₹${totalSpent.toStringAsFixed(2)}');
    csv.writeln('');
    csv.writeln('Daily Details');
    csv.writeln('List #,Item,Quantity,Unit Price,Total Cost');

    for (int i = 0; i < lists.length; i++) {
      for (int j = 0; j < lists[i].items.length; j++) {
        final item = lists[i].items[j];
        csv.writeln(
          '${i + 1},${item.productName},${item.quantityNeeded},${item.mrp},${item.totalCost.toStringAsFixed(2)}',
        );
      }
    }

    return csv.toString();
  }

  String get textFormat {
    StringBuffer text = StringBuffer();
    text.writeln('═' * 50);
    text.writeln('DAILY INVENTORY REPORT');
    text.writeln('Date: ${DateFormat('dd MMM yyyy').format(date)}');
    text.writeln('═' * 50);
    text.writeln('');
    text.writeln('SUMMARY');
    text.writeln('─' * 50);
    text.writeln('Total Shopping Lists:    $totalLists');
    text.writeln('Total Items Purchased:   $totalItems units');
    text.writeln('Total Amount Spent:      ₹${totalSpent.toStringAsFixed(2)}');
    if (totalLists > 0) {
      text.writeln('Average per List:        ₹${(totalSpent / totalLists).toStringAsFixed(2)}');
    }
    text.writeln('');
    text.writeln('DETAILED BREAKDOWN');
    text.writeln('─' * 50);

    for (int i = 0; i < lists.length; i++) {
      text.writeln('');
      text.writeln('List #${i + 1} (${DateFormat('hh:mm a').format(lists[i].createdDate)})');
      text.writeln('Items: ${lists[i].items.length} | Total: ₹${lists[i].grandTotal.toStringAsFixed(2)}');
      text.writeln('');

      for (final item in lists[i].items) {
        text.writeln(
          '  • ${item.productName}: ${item.quantityNeeded} × ₹${item.mrp} = ₹${item.totalCost.toStringAsFixed(2)}',
        );
      }
    }

    text.writeln('');
    text.writeln('═' * 50);
    text.writeln('END OF REPORT');
    text.writeln('═' * 50);

    return text.toString();
  }
}

// ============ Sample Products ============
final List<Product> sampleProducts = [
  // Pan Masala
  Product(
    id: '1',
    name: 'Sikar (1pkt)',
    mrp: 160,
    dailyLimit: 2,
    category: 'Pan Masala',
    unit: 'pkt',
  ),
  Product(
    id: '2',
    name: 'Raj Nivas (1pkt)',
    mrp: 150,
    dailyLimit: 2,
    category: 'Pan Masala',
    unit: 'pkt',
  ),
  Product(
    id: '3',
    name: 'Kamala Pasand (1pkt)',
    mrp: 200,
    dailyLimit: 1,
    category: 'Pan Masala',
    unit: 'pkt',
  ),
  Product(
    id: '4',
    name: '20/3 Vimal (1pkt)',
    mrp: 150,
    dailyLimit: 2,
    category: 'Pan Masala',
    unit: 'pkt',
  ),
  Product(
    id: '5',
    name: '20 Vimal (1pkt)',
    mrp: 190,
    dailyLimit: 2,
    category: 'Pan Masala',
    unit: 'pkt',
  ),
  Product(
    id: '6',
    name: 'Sagar (1pkt)',
    mrp: 220,
    dailyLimit: 1,
    category: 'Pan Masala',
    unit: 'pkt',
  ),
  Product(
    id: '7',
    name: 'RR (1pkt)',
    mrp: 220,
    dailyLimit: 1,
    category: 'Pan Masala',
    unit: 'pkt',
  ),
  Product(
    id: '8',
    name: 'Miraj (1pkt)',
    mrp: 240,
    dailyLimit: 1,
    category: 'Pan Masala',
    unit: 'pkt',
  ),
  Product(
    id: '9',
    name: 'RR Miraj (1pkt)',
    mrp: 230,
    dailyLimit: 1,
    category: 'Pan Masala',
    unit: 'pkt',
  ),
  Product(
    id: '10',
    name: 'Amber (1pkt)',
    mrp: 320,
    dailyLimit: 1,
    category: 'Pan Masala',
    unit: 'pkt',
  ),
  Product(
    id: '11',
    name: 'Swagth (1pkt)',
    mrp: 180,
    dailyLimit: 1,
    category: 'Pan Masala',
    unit: 'pkt',
  ),
  Product(
    id: '12',
    name: 'Chaina Kaini (1pkt)',
    mrp: 340,
    dailyLimit: 1,
    category: 'Pan Masala',
    unit: 'pkt',
  ),
  Product(
    id: '13',
    name: 'Navratan (1pkt)',
    mrp: 300,
    dailyLimit: 1,
    category: 'Pan Masala',
    unit: 'pkt',        
  ),
  Product(
    id: '14',
    name: '24 (1pkt)',
    mrp: 270,
    dailyLimit: 1,
    category: 'Pan Masala',
    unit: 'pkt',
  ),
  Product(
    id: '15',
    name: 'Pan Bahar (1pkt)',
    mrp: 270,
    dailyLimit: 1,
    category: 'Pan Masala',
    unit: 'pkt',
  ),
  Product(
    id: '16',
    name: 'Signature (1pkt)',
    mrp: 450,
    dailyLimit: 1,
    category: 'Pan Masala',
    unit: 'pkt',
  ),
  // Cigarettes
  Product(
    id: '17',
    name: 'Kings (1piece)',
    mrp: 205,
    dailyLimit: 1,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  
  Product(
    id: '18',
    name: 'Lights (1piece)',
    mrp: 205,
    dailyLimit: 1,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  Product(
    id: '19',
    name: 'American Club (1piece)',
    mrp: 165,
    dailyLimit: 2,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  Product(
    id: '20',
    name: 'Gold Flake Small (1piece)',
    mrp: 105,
    dailyLimit: 5,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  Product(
    id: '21',
    name: 'Connect (1piece)',
    mrp: 360,
    dailyLimit: 1,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  Product(
    id: '22',
    name: 'Shift (1piece)',
    mrp: 340,
    dailyLimit: 1,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  Product(
    id: '23',
    name: 'Edition (1piece)',
    mrp: 135,
    dailyLimit: 1,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  Product(
    id: '24',
    name: 'Active Mint (1piece)',
    mrp: 135,
    dailyLimit: 1,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  Product(
    id: '25',
    name: 'Indemint (1piece)',
    mrp: 105,
    dailyLimit: 1,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  Product(
    id: '26',
    name: 'Red Wills (1piece)',
    mrp: 105,
    dailyLimit: 1,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  Product(
    id: '27',
    name: 'Mini Advance (1piece)',
    mrp: 105,
    dailyLimit: 1,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  Product(
    id: '28',
    name: 'Charms (1piece)',
    mrp: 80,
    dailyLimit: 2,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  Product(
    id: '29',
    name: 'Bristol (1piece)',
    mrp: 80,
    dailyLimit: 2,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  Product(
    id: '30',
    name: 'Total (1piece)',
    mrp: 80,
    dailyLimit: 2,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  Product(
    id: '31',
    name: 'Players Red (1piece)',
    mrp: 80,
    dailyLimit: 1,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  Product(
    id: '32',
    name: 'Wave (1piece)',
    mrp: 82,
    dailyLimit: 1,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  Product(
    id: '33',
    name: 'Stellar (1piece)',
    mrp: 70,
    dailyLimit: 1,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  Product(
    id: '34',
    name: 'Classic Miles (1piece)',
    mrp: 400,
    dailyLimit: 1,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  Product(
    id: '35',
    name: 'Classic Ice Burst (1piece)',
    mrp: 400,
    dailyLimit: 1,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  Product(
    id: '36',
    name: 'Classic Menthol (1piece)',
    mrp: 400,
    dailyLimit: 1,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  Product(
    id: '37',
    name: 'Malboro Advance (1piece)',
    mrp: 450,
    dailyLimit: 1,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  Product(
    id: '38',
    name: 'Malboro Switch (1piece)',
    mrp: 450,
    dailyLimit: 1,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  Product(
    id: '39',
    name: 'Silk (1piece)',
    mrp: 242,
    dailyLimit: 1,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  Product(
    id: '40',
    name: 'Black Filter (1piece)',
    mrp: 185,
    dailyLimit: 1,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  Product(
    id: '41',
    name: 'American Smash (1piece)',
    mrp: 150,
    dailyLimit: 1,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  Product(
    id: '42',
    name: 'American Garam (1piece)',
    mrp: 170,
    dailyLimit: 1,
    category: 'Cigarettes',
    unit: 'piece',
  ),
  // Beverages
  Product(
    id: '43',
    name: 'Sony (1pkt)',
    mrp: 25,
    dailyLimit: 2,
    category: 'Beverages',
    unit: 'pkt',
  ),
  Product(
    id: '44',
    name: 'Sweety (1pkt)',
    mrp: 55,
    dailyLimit: 1,
    category: 'Beverages',
    unit: 'pkt',
  ),
  Product(
    id: '45',
    name: 'Red Pass Pass (1pkt)',
    mrp: 85,
    dailyLimit: 1,
    category: 'Beverages',
    unit: 'pkt',
  ),
  Product(
    id: '46',
    name: 'Green Pass Pass (1pkt)',
    mrp: 85,
    dailyLimit: 1,
    category: 'Beverages',
    unit: 'pkt',
  ),
  Product(
    id: '47',
    name: 'Silver Pearls (1pkt)',
    mrp: 135,
    dailyLimit: 1,
    category: 'Beverages',
    unit: 'pkt',
  ),
  Product(
    id: '48',
    name: 'Sweet Crane (1pkt)',
    mrp: 120,
    dailyLimit: 1,
    category: 'Beverages',
    unit: 'pkt',
  ),
  Product(
    id: '49',
    name: 'Hot Crane (1pkt)',
    mrp: 120,
    dailyLimit: 1,
    category: 'Beverages',
    unit: 'pkt',
  ),
  Product(
    id: '50',
    name: 'Google (1pkt)',
    mrp: 40,
    dailyLimit: 1,
    category: 'Beverages',
    unit: 'pkt',
  ),
  Product(
    id: '51',
    name: 'Happident (1 box)',
    mrp: 170,
    dailyLimit: 1,
    category: 'Beverages',
    unit: 'box',
  ),
  Product(
    id: '52',
    name: 'Center Fresh (1box)',
    mrp: 180,
    dailyLimit: 1,
    category: 'Beverages',
    unit: 'box',
  ),
  Product(
    id: '53',
    name: 'Vicks (1box)',
    mrp: 200,
    dailyLimit: 1,
    category: 'Beverages',
    unit: 'box',
  ),
  Product(
    id: '54',
    name: 'Kopiko (1box)',
    mrp: 200,
    dailyLimit: 1,
    category: 'Beverages',
    unit: 'box',
  ),
  Product(
    id: '55',
    name: 'Boomer (1box)',
    mrp: 170,
    dailyLimit: 0,
    category: 'Beverages',
    unit: 'box',
  ),
  Product(
    id: '56',
    name: 'Eclaries (1box)',
    mrp: 180,
    dailyLimit: 1,
    category: 'Beverages',
    unit: 'box',
  ),
// Snacks
  Product(
    id: '57',
    name: 'Haldirams (1 ladi)',
    mrp: 51,
    dailyLimit: 5,
    category: 'Snacks',
    unit: 'pkt',
  ),
  Product(
    id: '58',
    name: 'GoodDay (1pkt)',
    mrp: 54,
    dailyLimit: 2,
    category: 'Snacks',
    unit: 'pkt',
  ),
  Product(
    id: '59',
    name: 'Parle-G (1pkt)',
    mrp: 108,
    dailyLimit: 1,
    category: 'Snacks',
    unit: 'pkt',
  ),
  Product(
    id: '60',
    name: 'Krack Jack (1pkt)',
    mrp: 108,
    dailyLimit: 1,
    category: 'Snacks',
    unit: 'pkt',
  ),
  Product(
    id: '61',
    name: 'Happy Happy (1pkt)',
    mrp: 108,
    dailyLimit: 1,
    category: 'Snacks',
    unit: 'pkt',
  ),
  Product(
    id: '62',
    name: 'Monaco (1pkt)',
    mrp: 135,
    dailyLimit: 1,
    category: 'Snacks',
    unit: 'pkt',
  ),
  Product(
    id: '63',
    name: 'Moms Magic (1pkt)',
    mrp: 54,
    dailyLimit: 1,
    category: 'Snacks',
    unit: 'pkt',
  ),
  // Beedis
  Product(
    id: '64',
    name: 'Sai Baba (1/2 Pack)',
    mrp: 145,
    dailyLimit: 1,
    category: 'Beedis',
    unit: 'pkt',
  ),
   Product(
    id: '65',
    name: 'Ustadd (1/2 Pack)',
    mrp: 145,
    dailyLimit: 1,
    category: 'Beedis',
    unit: 'pkt',
  ),
   Product(
    id: '66',
    name: 'Ganesh (1/2 Pack)',
    mrp: 255,
    dailyLimit: 1,
    category: 'Beedis',
    unit: 'pkt',
  ),
   Product(
    id: '67',
    name: 'Vani (1/2 Pack)',
    mrp: 255,
    dailyLimit: 1,
    category: 'Beedis',
    unit: 'pkt',
  ),
   Product(
    id: '68',
    name: 'Ball Beedi (1 Pack)',
    mrp: 150,
    dailyLimit: 1,
    category: 'Beedis',
    unit: 'pkt',
  ),
//Groceries
  Product (
    id: '69',
    name: 'Brush (1 Pack)',
    mrp: 140,
    dailyLimit: 1,
    category: 'Groceries',
    unit: 'pkt',
   ),
  Product (
    id: '70',
    name: 'Colgate Paste (1 Pack)',
    mrp: 110,
    dailyLimit: 1,
    category: 'Groceries',
    unit: 'pkt',
   ),
  Product (
    id: '71',
    name: 'CloseUp Paste (1 Pack)',
    mrp: 110,
    dailyLimit: 1,
    category: 'Groceries',
    unit: 'pkt',
   ),
  Product (
    id: '72',
    name: 'Lifebuoy Soap (1 Pack)',
    mrp: 110,
    dailyLimit: 1,
    category: 'Groceries',
    unit: 'pkt',
   ),
  Product (
    id: '73',
    name: 'Santoor Soap (1 Pack)',
    mrp: 110,
    dailyLimit: 1,
    category: 'Groceries',
    unit: 'pkt',
   ),
  Product (
    id: '74',
    name: 'Cinthol Soap (1 Pack)',
    mrp: 110,
    dailyLimit: 1,
    category: 'Groceries',
    unit: 'pkt',
   ),
  
  Product (
    id: '75',
    name: 'SurfExcel Soap (1 Pack)',
    mrp: 110,
    dailyLimit: 1,
    category: 'Groceries',
    unit: 'pkt',
   ),

];

// ============ Main App ============
class ListBanavo extends StatelessWidget {
  const ListBanavo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List Banavo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

// ============ Home Screen ============
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ShoppingList> shoppingLists = [];
  int selectedTabIndex = 0;

  void _createNewList() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateListScreen(),
      ),
    ).then((newList) {
      if (newList != null) {
        setState(() {
          shoppingLists.insert(0, newList);
        });
      }
    });
  }

  DailyReport get todayReport {
    final today = DateTime.now();
    final todayLists = shoppingLists.where((list) {
      return list.createdDate.day == today.day &&
          list.createdDate.month == today.month &&
          list.createdDate.year == today.year;
    }).toList();
    return DailyReport(date: today, lists: todayLists);
  }

  void _showExportOptions(DailyReport report) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Export Report',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('View Text Report'),
              subtitle: const Text('View formatted report'),
              onTap: () {
                Navigator.pop(context);
                _showTextReport(report);
              },
            ),
            ListTile(
              leading: const Icon(Icons.table_chart),
              title: const Text('Copy CSV Data'),
              subtitle: const Text('For Excel/Spreadsheet'),
              onTap: () {
                Navigator.pop(context);
                _copyCSVToClipboard(report);
              },
            ),
            ListTile(
              leading: const Icon(Icons.print),
              title: const Text('Print Ready Format'),
              subtitle: const Text('Format for printing'),
              onTap: () {
                Navigator.pop(context);
                _showPrintFormat(report);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showTextReport(DailyReport report) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Daily Report'),
        content: SingleChildScrollView(
          child: SelectableText(
            report.textFormat,
            style: const TextStyle(fontFamily: 'Courier', fontSize: 12),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _copyCSVToClipboard(DailyReport report) {
    final csv = report.csvFormat;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('CSV data ready! (${(csv.length / 1024).toStringAsFixed(2)} KB)'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showPrintFormat(DailyReport report) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Print Format'),
        content: SingleChildScrollView(
          child: SelectableText(
            report.textFormat,
            style: const TextStyle(fontFamily: 'Courier', fontSize: 11),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Banavo'),
        elevation: 0,
        actions: [
          if (todayReport.totalLists > 0)
            IconButton(
              icon: const Icon(Icons.analytics),
              tooltip: 'Daily Report',
              onPressed: () => _showExportOptions(todayReport),
            ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: SegmentedButton<int>(
              segments: const [
                ButtonSegment(label: Text('Lists'), value: 0),
                ButtonSegment(label: Text('Today Report'), value: 1),
              ],
              selected: {selectedTabIndex},
              onSelectionChanged: (Set<int> newSelection) {
                setState(() {
                  selectedTabIndex = newSelection.first;
                });
              },
            ),
          ),
          Expanded(
            child: selectedTabIndex == 0
                ? _buildListsView()
                : _buildReportView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createNewList,
        icon: const Icon(Icons.add),
        label: const Text('New List'),
      ),
    );
  }

  Widget _buildListsView() {
    if (shoppingLists.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.list_alt,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 20),
            Text(
              'No Shopping Lists Yet',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text(
              'Create your first list to get started',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: shoppingLists.length,
      itemBuilder: (context, index) {
        final list = shoppingLists[index];
        return ShoppingListCard(
          list: list,
          onDelete: () {
            setState(() {
              shoppingLists.removeAt(index);
            });
          },
          onView: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListDetailsScreen(list: list),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildReportView() {
    final report = todayReport;

    if (report.totalLists == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 20),
            Text(
              'No Lists Today',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text(
              'Create lists to see daily report',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today\'s Summary',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Lists:',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          '${report.totalLists}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Items:',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          '${report.totalItems}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Spent:',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          '₹${report.totalSpent.toStringAsFixed(0)}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: () => _showExportOptions(report),
          icon: const Icon(Icons.download),
          label: const Text('Export Report'),
        ),
        const SizedBox(height: 20),
        Text(
          'Items Breakdown',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...report.lists.asMap().entries.map((entry) {
          int idx = entry.key;
          ShoppingList list = entry.value;
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'List #${idx + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        DateFormat('hh:mm a').format(list.createdDate),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const Divider(),
                  ...list.items.map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.productName,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                        Text(
                          '${item.quantityNeeded} × ₹${item.mrp}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          '₹${item.totalCost.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Subtotal:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '₹${list.grandTotal.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

// ============ Create List Screen ============
class CreateListScreen extends StatefulWidget {
  const CreateListScreen({Key? key}) : super(key: key);

  @override
  State<CreateListScreen> createState() => _CreateListScreenState();
}

class _CreateListScreenState extends State<CreateListScreen> {
  List<ShoppingListItem> items = [];
  String selectedMethod = 'stock';
  String searchQuery = '';

  void _addItemFromStock(Product product) {
    showDialog(
      context: context,
      builder: (context) => StockInputDialog(
        product: product,
        onSubmit: (currentStock) {
          setState(() {
            final existingIndex =
                items.indexWhere((i) => i.productId == product.id);
            if (existingIndex >= 0) {
              items[existingIndex].currentStock = currentStock;
              items[existingIndex].quantityNeeded =
                  (product.dailyLimit - currentStock).clamp(0, 999);
            } else {
              items.add(
                ShoppingListItem(
                  productId: product.id,
                  productName: product.name,
                  dailyLimit: product.dailyLimit,
                  mrp: product.mrp,
                  unit: product.unit,
                  currentStock: currentStock,
                  quantityNeeded:
                      (product.dailyLimit - currentStock).clamp(0, 999),
                  imageAsset: product.imageAsset,
                ),
              );
            }
          });
        },
      ),
    );
  }

  void _quickAddItem(Product product) {
    setState(() {
      final existingIndex =
          items.indexWhere((i) => i.productId == product.id);
      if (existingIndex >= 0) {
        items[existingIndex].quantityNeeded++;
      } else {
        items.add(
          ShoppingListItem(
            productId: product.id,
            productName: product.name,
            dailyLimit: product.dailyLimit,
            mrp: product.mrp,
            unit: product.unit,
            currentStock: 0,
            quantityNeeded: product.dailyLimit,
            imageAsset: product.imageAsset,
          ),
        );
      }
    });
  }

  void _saveList() {
    if (items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add at least one item')),
      );
      return;
    }

    final newList = ShoppingList(
      id: DateTime.now().toString(),
      createdDate: DateTime.now(),
      items: items,
    );

    Navigator.pop(context, newList);
  }

  List<Product> get filteredProducts {
    if (searchQuery.isEmpty) {
      return sampleProducts;
    }
    return sampleProducts
        .where((p) => p.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Shopping List'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(label: Text('From Stock'), value: 'stock'),
                      ButtonSegment(label: Text('Quick Add'), value: 'quick'),
                    ],
                    selected: {selectedMethod},
                    onSelectionChanged: (Set<String> newSelection) {
                      setState(() {
                        selectedMethod = newSelection.first;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: selectedMethod == 'stock'
                ? _buildStockMethod()
                : _buildQuickAddMethod(),
          ),
          if (items.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border(top: BorderSide(color: Colors.grey[300]!)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${items.length} items • ${items.fold(0, (sum, item) => sum + item.quantityNeeded)} units',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Total: ₹${items.fold(0.0, (sum, item) => sum + item.totalCost).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  FilledButton.icon(
                    onPressed: _saveList,
                    icon: const Icon(Icons.check),
                    label: const Text('Save List'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStockMethod() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TextField(
            onChanged: (value) => setState(() => searchQuery = value),
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => setState(() => searchQuery = ''),
                    )
                  : null,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              final isAdded =
                  items.any((i) => i.productId == product.id);
              return ProductCard(
                product: product,
                isAdded: isAdded,
                onTap: () => _addItemFromStock(product),
              );
            },
          ),
        ),
        if (items.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(12),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Added Items',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...items.map((item) => ListTile(
                      dense: true,
                      title: Text(item.productName),
                      subtitle: Text('Need: ${item.quantityNeeded}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => setState(() {
                          items.remove(item);
                        }),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildQuickAddMethod() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TextField(
            onChanged: (value) => setState(() => searchQuery = value),
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => setState(() => searchQuery = ''),
                    )
                  : null,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              
              // FIXED: Find added item without null errors
              ShoppingListItem? addedItem;
              try {
                addedItem = items.firstWhere(
                  (i) => i.productId == product.id,
                );
              } catch (e) {
                addedItem = null;
              }

              return Card(
                child: ListTile(
                  title: Text(product.name),
                  subtitle: Text('MRP: ₹${product.mrp}'),
                  trailing: addedItem != null
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                iconSize: 18,
                                onPressed: () => setState(() {
                                  if (addedItem!.quantityNeeded > 1) {
                                    addedItem.quantityNeeded--;
                                  } else {
                                    items.remove(addedItem);
                                  }
                                }),
                              ),
                              Text(
                                '${addedItem.quantityNeeded}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                iconSize: 18,
                                onPressed: () => setState(() {
                                  addedItem!.quantityNeeded++;
                                }),
                              ),
                            ],
                          ),
                        )
                      : FloatingActionButton.small(
                          onPressed: () => _quickAddItem(product),
                          child: const Icon(Icons.add),
                        ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ============ Dialogs ============
class StockInputDialog extends StatefulWidget {
  final Product product;
  final Function(int) onSubmit;

  const StockInputDialog({
    Key? key,
    required this.product,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<StockInputDialog> createState() => _StockInputDialogState();
}

class _StockInputDialogState extends State<StockInputDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.product.name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Daily Limit: ${widget.product.dailyLimit} ${widget.product.unit}'),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Current Stock (Remaining)',
              border: OutlineInputBorder(),
              hintText: 'e.g., 3',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              final stock = int.tryParse(_controller.text) ?? 0;
              widget.onSubmit(stock);
              Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

// ============ Cards & Widgets ============
class ProductCard extends StatelessWidget {
  final Product product;
  final bool isAdded;
  final VoidCallback onTap;

  const ProductCard({
    Key? key,
    required this.product,
    required this.isAdded,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(product.name),
        subtitle: Text(
          'MRP: ₹${product.mrp} | Daily: ${product.dailyLimit}',
        ),
        trailing: isAdded
            ? const Icon(Icons.check_circle, color: Colors.green)
            : const Icon(Icons.add_circle_outline),
        onTap: onTap,
      ),
    );
  }
}

class ShoppingListCard extends StatelessWidget {
  final ShoppingList list;
  final VoidCallback onDelete;
  final VoidCallback onView;

  const ShoppingListCard({
    Key? key,
    required this.list,
    required this.onDelete,
    required this.onView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onView,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('dd MMM yyyy hh:mm a').format(list.createdDate),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: onDelete,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${list.items.length} items • ${list.totalItems} units',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              Text(
                'Total: ₹${list.grandTotal.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============ List Details Screen ============
class ListDetailsScreen extends StatelessWidget {
  final ShoppingList list;

  const ListDetailsScreen({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat('dd MMM yyyy hh:mm a').format(list.createdDate)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Summary',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Total Items:'),
                          Text(
                            list.items.length.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Total Units:'),
                          Text(
                            list.totalItems.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Grand Total:'),
                          Text(
                            '₹${list.grandTotal.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Items to Buy',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          ...list.items.map((item) => Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Quantity: ${item.quantityNeeded} ${item.unit}'),
                      Text('₹${item.mrp} each'),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal: ₹${item.totalCost.toStringAsFixed(2)}'),
                      Text('In stock: ${item.currentStock}'),
                    ],
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}