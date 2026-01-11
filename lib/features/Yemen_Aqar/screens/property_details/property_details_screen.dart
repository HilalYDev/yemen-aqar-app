import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appBar/custom_app_bar.dart';
import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../common/widgets/images/rounded_images.dart';
import '../../../../common/widgets/texts/text_styles.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../controller/cart_controller.dart';
import '../../model/PropertyModel.dart';

class PropertyDetailsScreen extends StatelessWidget {
  final PropertyModel property;
  PropertyDetailsScreen({super.key, required this.property});

  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const CustomAppBar(title: "تفاصيل العقار", showBackButton: true),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ قسم الصور الرئيسي
            RoundedImage(
              imageUrl: property.image ?? '',
              isNetworkImage: true,
              fit: BoxFit.cover,
              borderRadius: 0,
            ),
            // ✅ تفاصيل العقار
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ✅ عنوان العقار
                  AppTextStyles(
                    title: property.name ?? 'بدون اسم',
                    height: 1.4,

                    mediumSize: true,
                    bold: true,
                    // color: AppColors.deepNavy,
                  ),

                  const SizedBox(height: 16),

                  // ✅ معلومات السعر والعملة
                  // _buildPriceSection(),
                  AppTextStyles(
                    title: "السعر",
                    smallSize: true,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(height: 4),
                  AppTextStyles(
                    title: "${property.price} ${property.currency}",
                    mediumSize: true,
                    bold: true,
                    color: AppColors.deepNavy,
                  ),
                  const SizedBox(height: 20),

                  // ✅ معلومات الموقع
                  RoundedContainer(
                    padding: const EdgeInsets.all(10),
                    showShadow: true,

                    child: Row(
                      children: [
                        Icon(
                          Iconsax.location,
                          color: AppColors.copperTan,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextStyles(
                                title: "الموقع",
                                smallSize: true,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(height: 4),
                              AppTextStyles(
                                title: property.location ?? 'غير محدد',
                                mediumSize: true,
                                color: AppColors.deepNavy,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Icon(
                        Iconsax.document_text,
                        color: AppColors.copperTan,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      AppTextStyles(
                        title: "وصف العقار",
                        mediumSize: true,
                        bold: true,
                        color: AppColors.deepNavy,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // ✅ وصف العقار
                  RoundedContainer(
                    padding: const EdgeInsets.all(10),
                    showShadow: true,

                    child: AppTextStyles(
                      title: property.description ?? 'لا يوجد وصف',
                      smallSize: true,
                      color: Colors.grey[900],
                      height: 1.6,
                      maxLine: 100,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ✅ تفاصيل إضافية
                  Row(
                    children: [
                      Icon(
                        Iconsax.document_1,
                        color: AppColors.copperTan,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      AppTextStyles(
                        title: "مستندات الملكية",
                        mediumSize: true,
                        bold: true,
                        color: AppColors.deepNavy,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      // عرض صورة الملكية بالحجم الكامل
                      Get.to(
                        () => FullScreenImage(
                          imageUrl: property.ownershipImage ?? '',
                        ),
                      );
                    },
                    child: RoundedImage(
                      borderRadius: 15,
                      imageUrl: property.ownershipImage!,
                      isNetworkImage: true,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: _buildBottomBar(context),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        // color: const Color.fromARGB(255, 139, 67, 67),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.deepNavy, // هنا لون الخلفية
            foregroundColor: Colors.white, // لون النص والأيقونة
          ),
          onPressed: () {
            cartController.addToCart(property.id.toString());
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(FontAwesomeIcons.cartPlus, color: Colors.white),
              SizedBox(width: 8),
              AppTextStyles(
                title: "إضافة إلى السلة",
                mediumSize: true,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ✅ صفحة لعرض الصورة بالحجم الكامل
class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text("صورة الملكية"),
      ),
      body: Center(
        child: InteractiveViewer(
          panEnabled: true,
          minScale: 0.5,
          maxScale: 3.0,
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  value:
                      loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, color: Colors.white, size: 60),
                    const SizedBox(height: 20),
                    Text(
                      "فشل في تحميل الصورة",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
