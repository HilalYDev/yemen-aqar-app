import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yemen_aqar/common/widgets/shimmer/custom_shimmer_widget.dart';

class RoundedImage extends StatelessWidget {
  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  const RoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.cover,
    this.padding,
    this.margin,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: border,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius:
              applyImageRadius
                  ? BorderRadius.circular(borderRadius)
                  : BorderRadius.zero,
          child:
              isNetworkImage
                  ? CachedNetworkImage(
                    fit: fit,
                    imageUrl: imageUrl,
                    // حذف TShimmerEffect هنا
                    errorWidget:
                        (context, url, error) => const Icon(Icons.error),
                  )
                  : Image(fit: fit, image: AssetImage(imageUrl)),
        ),
      ),
    );
  }
}

class RoundedImage1 extends StatelessWidget {
  final double? width, height;
  final String? imageUrl; // جعلها nullable
  final File? imageFile; // إضافة متغير جديد لملف الصورة
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final dynamic borderRadius;
  final double borderWidth;

  const RoundedImage1({
    super.key,
    this.width,
    this.height,
    this.imageUrl,
    this.imageFile, // إضافة الباراميتر الجديد
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.cover,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = 10.0,
    this.borderWidth = 1.0,
  }) : assert(
         imageUrl != null || imageFile != null,
         'يجب توفير imageUrl أو imageFile',
       );

  @override
  Widget build(BuildContext context) {
    final BorderRadius effectiveBorderRadius =
        borderRadius is BorderRadius
            ? borderRadius
            : BorderRadius.circular(
              borderRadius is double ? borderRadius : 10.0,
            );

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: border,
          borderRadius: effectiveBorderRadius,
        ),
        child: ClipRRect(
          borderRadius:
              applyImageRadius
                  ? effectiveBorderRadius - BorderRadius.circular(borderWidth)
                  : BorderRadius.zero,
          child: _buildImageWidget(),
        ),
      ),
    );
  }

  Widget _buildImageWidget() {
    // الأولوية لملف الصورة إذا كان موجوداً
    if (imageFile != null) {
      return Image.file(
        imageFile!,
        fit: fit,
        errorBuilder:
            (context, error, stackTrace) => _buildDefaultErrorWidget(),
      );
    }

    // ثم التحقق من الصور الأخرى
    if (isNetworkImage && imageUrl != null) {
      return CachedNetworkImage(
        fit: fit,
        imageUrl: imageUrl!,
        placeholder: (context, url) => _buildDefaultPlaceholder(),
        errorWidget: (context, url, error) => _buildDefaultErrorWidget(),
      );
    } else if (imageUrl != null) {
      try {
        return Image(
          fit: fit,
          image: AssetImage(imageUrl!),

          errorBuilder:
              (context, error, stackTrace) => _buildDefaultErrorWidget(),
        );
      } catch (e) {
        return _buildDefaultErrorWidget();
      }
    }

    return _buildDefaultErrorWidget();
  }

  Widget _buildDefaultPlaceholder() {
    return CustomShimmerWidget();
    // return Container(
    //   color: Colors.grey[200],
    //   child: const Center(
    //     child: CircularProgressIndicator(strokeWidth: 2, color: Colors.grey),
    //   ),
    // );
  }

  Widget _buildDefaultErrorWidget() {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: Icon(Icons.broken_image, color: Colors.grey, size: 40),
      ),
    );
  }
}
