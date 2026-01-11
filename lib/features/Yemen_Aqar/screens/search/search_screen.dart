import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appBar/custom_app_bar.dart';
import '../../../../common/widgets/mybutton/mybutton.dart';
import '../../../../utils/class/handlingdataview.dart';
import '../../../../utils/class/statusrequest.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../controller/search_controller.dart';
import '../../model/PropertyModel.dart';
import '../property_details/property_details_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SearchDataController());

    return Scaffold(
      appBar: const CustomAppBar(
        title: "بحث العقارات", // ✅ تغيير العنوان
        color: AppColors.apparcolor,
      ),
      body: GetBuilder<SearchDataController>(
        builder: (controller) {
          return HandlingDataView(
            statusRequest: controller.statusRequest!,
            widget: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // **مربع البحث**
                    HelalTextBox(
                      ctrl: controller.searchController,
                      hint: 'ابحث عن عقار (اسم، موقع، وصف)...',
                      labeltext: 'بحث',
                      isSearch: true,
                      icon: Icons.search_outlined,
                      onSearchPressed: () {
                        controller.getSearchData();
                      },
                      onChanged: (value) {
                        // إذا كنت تريد تفعيل البحث التلقائي
                        // controller.searchText(value);
                      },
                      onFieldSubmitted: (value) {
                        controller.getSearchData();
                      },
                    ),
                    const SizedBox(height: 10),

                    // **عرض الاقتراحات عند الكتابة** (إذا كنت تريد هذه الخاصية)
                    if (controller.filteredProperties.isNotEmpty &&
                        controller.searchController.text.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.filteredProperties.length,
                        itemBuilder: (context, index) {
                          final property = controller.filteredProperties[index];
                          return ListTile(
                            leading:
                                property.image != null
                                    ? Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: NetworkImage(property.image!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                    : Icon(Icons.home, color: Colors.grey[400]),
                            title: Text(property.name ?? 'بدون اسم'),
                            subtitle: Text(property.location ?? 'بدون موقع'),
                            trailing: Text(
                              '${property.price ?? ''} ${property.currency ?? ''}',
                              style: TextStyle(
                                color: AppColors.copperTan,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              controller.selectSuggestion(property.name ?? '');
                            },
                          );
                        },
                      ),

                    const SizedBox(height: 10),

                    // **عرض نتائج البحث - عقارات**
                    if (controller.searchedProperties.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.searchedProperties.length,
                        itemBuilder: (context, index) {
                          final property = controller.searchedProperties[index];
                          return _buildPropertyCard(property, controller);
                        },
                      ),

                    // **عرض رسالة إذا لم توجد نتائج**
                    if (controller.searchedProperties.isEmpty &&
                        controller.searchController.text.isNotEmpty &&
                        controller.statusRequest == StatusRequest.success)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 60,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'لا توجد عقارات تطابق البحث',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    // **رسالة ترحيبية عند فتح الصفحة**
                    if (controller.searchedProperties.isEmpty &&
                        controller.searchController.text.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.search,
                                size: 60,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'ابحث عن العقارات',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'ابحث باستخدام اسم العقار، الموقع، أو الوصف',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ✅ دالة لبناء بطاقة العقار
  Widget _buildPropertyCard(
    PropertyModel property,
    SearchDataController controller,
  ) {
    return GestureDetector(
      onTap: () {
        // الانتقال لصفحة تفاصيل العقار
        Get.to(() => PropertyDetailsScreen(property: property));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // صورة العقار
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                color: Colors.grey[200],
              ),
              child:
                  property.image != null
                      ? ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                        child: Image.network(
                          property.image!,
                          fit: BoxFit.cover,
                        ),
                      )
                      : Center(
                        child: Icon(
                          Icons.home,
                          size: 40,
                          color: Colors.grey[400],
                        ),
                      ),
            ),

            // معلومات العقار
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      property.name ?? 'بدون اسم',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Iconsax.location,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            property.location ?? 'بدون موقع',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${property.price ?? ''} ${property.currency ?? ''}',
                      style: TextStyle(
                        color: AppColors.copperTan,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
