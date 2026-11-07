import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'يقين - Yaqeen Lab',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: 'Cairo',
    ),
    home: YaqeenHomeScreen(),
  ));
}

// 1. الشاشة الرئيسية
class YaqeenHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('معمل يقين للتحاليل الطبية'),
        backgroundColor: Color(0xFF1565C0),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFF1565C0),
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('أهلاً بك،', style: TextStyle(color: Colors.grey[700], fontSize: 14)),
                      Text('مرحباً بك في تطبيق يقين', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1565C0))),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text('الخدمات الرئيسية:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1565C0))),
            SizedBox(height: 12),

            // زر المنتصف البارز لطلب تحليل جديد
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PatientDataScreen()));
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFF1565C0), Color(0xFF42A5F5)]),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.3), spreadRadius: 2, blurRadius: 6, offset: Offset(0, 3))],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_shopping_cart, color: Colors.white, size: 26),
                    SizedBox(width: 10),
                    Text('تسجيل طلب تحليل / سحب عينة جديد', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),

            // الخانات الأربعة الطرفية
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildServiceCard(context, 'سحب عينة منزلية', Icons.home, Colors.orange, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PatientDataScreen()));
                }),
                _buildServiceCard(context, 'الدفع الإلكتروني', Icons.payment, Colors.purple, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(totalAmount: 350)));
                }),
                _buildServiceCard(context, 'نتائجي الطبية (PDF)', Icons.description, Colors.green, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TrackingScreen()));
                }),
                _buildServiceCard(context, 'اتصل بنا وفروعنا', Icons.phone_in_talk, Colors.blue, () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), spreadRadius: 2, blurRadius: 5, offset: Offset(0, 3))],
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 24, backgroundColor: color.withOpacity(0.1), child: Icon(icon, size: 26, color: color)),
            SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}

// 2. خطوة بيانات المريض
class PatientDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('خطوة 1: بيانات المريض'), backgroundColor: Color(0xFF1565C0)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('أدخل بيانات المريض الأساسية:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1565C0))),
            SizedBox(height: 15),
            TextField(decoration: InputDecoration(labelText: 'اسم المريض الثلاثي', border: OutlineInputBorder())),
            SizedBox(height: 12),
            TextField(keyboardType: TextInputType.phone, decoration: InputDecoration(labelText: 'رقم الهاتف', border: OutlineInputBorder())),
            SizedBox(height: 12),
            TextField(maxLines: 2, decoration: InputDecoration(labelText: 'العنوان بالتفصيل', border: OutlineInputBorder())),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1565C0)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TestsSearchScreen()));
                },
                child: Text('التالي: اختيار التحاليل', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 3. خطوة اختيار التحاليل مع البحث
class TestsSearchScreen extends StatefulWidget {
  @override
  _TestsSearchScreenState createState() => _TestsSearchScreenState();
}

class _TestsSearchScreenState extends State<TestsSearchScreen> {
  // تم تبسيط القائمة لتجنب أي مشاكل في الترميز
  final List tests = [
    {'name': 'صورة دم كاملة (CBC)', 'price': 100},
    {'name': 'سكر تراكمي (HbA1c)', 'price': 120},
    {'name': 'وظائف كلى (كرياتينين وبولينا)', 'price': 150},
    {'name': 'وظائف كبد (ALT, AST)', 'price': 140},
    {'name': 'مزرعة بول', 'price': 130},
    {'name': 'دهون ثلاثية وكوليسترول', 'price': 160},
  ];

  List filteredTests = [];
  List selectedTests = [];

  @override
  void initState() {
    super.initState();
    filteredTests = tests;
  }

  void runSearch(String keyword) {
    setState(() {
      if (keyword.isEmpty) {
        filteredTests = tests;
      } else {
        filteredTests = tests.where((t) => t['name'].toLowerCase().contains(keyword.toLowerCase())).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int total = selectedTests.fold(0, (sum, item) => sum + (item['price'] as int));

    return Scaffold(
      appBar: AppBar(title: Text('خطوة 2: اختيار التحاليل'), backgroundColor: Color(0xFF1565C0)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: runSearch,
              decoration: InputDecoration(
                labelText: 'ابحث عن التحليل...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTests.length,
                itemBuilder: (context, index) {
                  final test = filteredTests[index];
                  bool isSelected = selectedTests.contains(test);
                  return Card(
                    child: ListTile(
                      title: Text(test['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('السعر: ${test['price']} EGP'),
                      trailing: Checkbox(
                        value: isSelected,
                        onChanged: (val) {
                          setState(() {
                            if (val == true) {
                              selectedTests.add(test);
                            } else {
                              selectedTests.remove(test);
                            }
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('الإجمالي: $total EGP', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1565C0))),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1565C0)),
                    onPressed: selectedTests.isEmpty
                        ? null
                        : () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(totalAmount: total)));
                          },
                    child: Text('التالي: الدفع', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 4. خطوة الدفع الإلكتروني
class PaymentScreen extends StatelessWidget {
  final int totalAmount;
  PaymentScreen({required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('خطوة 3: الدفع الإلكتروني'), backgroundColor: Color(0xFF1565C0)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('المطلوب سداده:', style: TextStyle(fontSize: 16)),
                  Text('$totalAmount EGP', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1565C0))),
                ],
              ),
            ),
            SizedBox(height: 20),
            Card(child: ListTile(leading: Icon(Icons.account_balance_wallet, color: Colors.purple), title: Text('إنستا باي'), subtitle: Text('yaqeen.lab@instapay'))),
            Card(child: ListTile(leading: Icon(Icons.phone_android, color: Colors.red), title: Text('فودافون كاش'), subtitle: Text('01097330585'))),
            SizedBox(height: 20),
            Text('قم برفع إيصال التحويل:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey[100], border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload, color: Color(0xFF1565C0)),
                  Text('اضغط لرفع صورة الإيصال', style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1565C0)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TrackingScreen()));
                },
                child: Text('تأكيد وإرسال الطلب للمعمل', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 5. خطوة تتبع الطلب والنتيجة PDF
class TrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('خطوة 4: تتبع الطلب والنتيجة'), backgroundColor: Color(0xFF1565C0)),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 70),
            SizedBox(height: 15),
            Text('تم إرسال طلبك بنجاح للمعمل!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[700])),
            SizedBox(height: 20),
            _buildStep('1. استلام الطلب والدفع', true),
            _buildStep('2. فحص العينة بالمعمل', false),
            _buildStep('3. جاهزية النتيجة (PDF)', false),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green[700]),
                onPressed: () {},
                icon: Icon(Icons.picture_as_pdf, color: Colors.white),
                label: Text('تحميل تقرير النتيجة (PDF)', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String title, bool isDone) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(isDone ? Icons.check_circle : Icons.radio_button_unchecked, color: isDone ? Colors.green : Colors.grey),
          SizedBox(width: 15),
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
