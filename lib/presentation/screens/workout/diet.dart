import 'package:flutter/material.dart';
import 'package:ordering_app/constants/colors.dart';
import 'package:ordering_app/presentation/widgets/auth/customtext.dart';

class DietPlansScreen extends StatelessWidget {
  final List<Map<String, String>> dietPlans = [
    {"title": "تخسيس", "subtitle": "1200 سعرة – بروتين عالي"},
    {"title": "زيادة عضل", "subtitle": "2500 سعرة – بروتين + كارب"},
    {"title": "حفاظ على الوزن", "subtitle": "2000 سعرة – متوازن"},
    {"title": "نباتي", "subtitle": "1800 سعرة – بروتين نباتي"},
  ];

  DietPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("الأنظمة الغذائية"), centerTitle: true),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemCount: dietPlans.length,
        itemBuilder: (context, index) {
          final plan = dietPlans[index];
          return _dietPlanCard(
            context,
            plan["title"]!,
            plan["subtitle"]!,
            theme,
          );
        },
      ),
    );
  }

  Widget _dietPlanCard(
    BuildContext context,
    String title,
    String subtitle,
    ThemeData theme,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  DietDetailsScreen(title: title, subtitle: subtitle),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.fastfood, size: 40, color: Colors.green[700]),
              const SizedBox(height: 12),
              CustomText(
                title: title,
                textStyle: theme.textTheme.headlineMedium!.copyWith(
                  color: MyColors.black01,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              CustomText(
                title: subtitle,
                textStyle: theme.textTheme.headlineSmall!.copyWith(
                  color: MyColors.grey,
                  fontSize: 14.0,
                ),
                //const TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DietDetailsScreen extends StatelessWidget {
  final String title;
  final String subtitle;

  const DietDetailsScreen({
    super.key,
    required this.title,
    required this.subtitle,
  });

  // وجبات لكل نظام
  Map<String, Map<String, List<String>>> get dietMeals => {
    "تخسيس": {
      "فطور": ["شوفان بالحليب", "بيضة مسلوقة", "تفاحة"],
      "غداء": ["صدر دجاج مشوي", "أرز بني", "سلطة خضار"],
      "عشاء": ["تونة بالماء", "شريحة خبز أسمر", "خس وخيار"],
      "سناك": ["زبادي لايت", "حفنة مكسرات"],
    },
    "زيادة عضل": {
      "فطور": ["بيض + توست", "شوفان مع زبدة فول سوداني", "موز"],
      "غداء": ["لحم مشوي", "مكرونة كاملة الحبة", "خضار سوتيه"],
      "عشاء": ["صدر ديك رومي", "بطاطس مسلوقة", "خضار مطبوخ"],
      "سناك": ["بروتين شيك", "تمور + لوز"],
    },
    "حفاظ على الوزن": {
      "فطور": ["توست أسمر", "جبنة قريش", "خيار"],
      "غداء": ["سمك مشوي", "أرز أبيض", "سلطة"],
      "عشاء": ["بيض أومليت بالخضار", "سلطة خضراء"],
      "سناك": ["فاكهة موسمية", "مكسرات قليلة"],
    },
    "نباتي": {
      "فطور": ["شوفان مع حليب لوز", "بذور شيا", "فراولة"],
      "غداء": ["عدس مطبوخ", "أرز بني", "سلطة خضار"],
      "عشاء": ["برجر نباتي", "بطاطا مشوية", "سلطة"],
      "سناك": ["حمص بالطحينة", "خضار مقطع"],
    },
  };

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final meals = dietMeals[title];
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: meals == null
          ? Center(child: CustomText(title: "لا توجد وجبات لهذا النظام"))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                CustomText(
                  title: subtitle,
                  textStyle: theme.textTheme.headlineSmall!.copyWith(
                    color: MyColors.grey,
                  ),
                  //const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                ...meals.entries.map(
                  (meal) => _mealCard(meal.key, meal.value, theme),
                ),
              ],
            ),
    );
  }

  Widget _mealCard(String mealTitle, List<String> items, ThemeData theme) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: mealTitle,
              textStyle: theme.textTheme.headlineSmall!.copyWith(
                color: MyColors.green,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 8),
            ...items.map(
              (item) => Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 18),
                  const SizedBox(width: 6),
                  Expanded(child: CustomText(title: item)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
