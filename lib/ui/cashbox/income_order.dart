import 'package:cash_control/ui/cashbox/widgets/app_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OrderScreen(),
    );
  }
}

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CashboxAppbar(title: "Приходной ордер"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle date filter action
                    },
                    child: Text('дата с по'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Colors.grey[200],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle supplier filter action
                    },
                    child: Text('поставщик'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Colors.grey[200],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Handle create action
                  },
                  child: Text('Создать'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  OrderItem(
                    date: '12.08.2024',
                    supplier: 'ИП Касымова Ж',
                    amount: '80 000',
                  ),
                  OrderItem(
                    date: '12.08.2024',
                    supplier: 'ИП Касымова Ж',
                    amount: '80 000',
                  ),
                  OrderItem(
                    date: '12.08.2024',
                    supplier: 'ИП Касымова Ж',
                    amount: '80 000',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Приходный ордер'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Расходный ордер'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Расчеты с поставщиком'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Отчет по кассе'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Справочник'),
        ],
        currentIndex: 0, // Highlight 'Приходный ордер' as active
        onTap: (index) {
          // Handle navigation tap
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final String date;
  final String supplier;
  final String amount;

  const OrderItem({
    Key? key,
    required this.date,
    required this.supplier,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(date, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(supplier, style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
          ),
          Text(amount, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  // Handle edit action
                },
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // Handle delete action
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
