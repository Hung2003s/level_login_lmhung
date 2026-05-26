import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:level_login_lmhung/core/constants/app_color.dart';
import 'package:level_login_lmhung/feature/home/presentation/widget/fast_feature_card.dart';
import '../../../core/common_widget/base_view/base_view.dart';
import '../../../core/common_widget/navigation_bar/profile_app_bar.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      buildAppBar: ProfileAppBar(username: 'Le Minh Hung'),
      buildBody: CustomScrollView(
        scrollDirection: Axis.vertical,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        controller: controller.contactScrollCtrl,
        slivers: <Widget>[
          _buildOverviewSection(context),
          _buildFastFeatureSection(context),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildOverviewSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverviewHeader(context),
            const SizedBox(height: 16),
            _buildTotalProductCard(context),
            const SizedBox(height: 16),
            _buildSmallInfoCards(context),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('warehouse_overview'.tr, style: context.textTheme.titleLarge),
        Text(
          'updated_at'.tr,
          style: context.textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildTotalProductCard(BuildContext context) {
    return _buildInfoCard(
      icon: Icon(Icons.one_k_outlined),
      iconColor: AppColor.orange,
      hasGrow: true,
      context: context,
    );
  }

  Widget _buildSmallInfoCards(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            icon: Icon(Icons.home),
            iconColor: AppColor.blueLight,
            context: context,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildInfoCard(
            icon: Icon(Icons.home),
            iconColor: AppColor.error,
            context: context,
          ),
        ),
      ],
    );
  }

  SliverToBoxAdapter _buildFastFeatureSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('quick_actions'.tr, context),
            const SizedBox(height: 16),
            _buildFastFeatureActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Text(
      title,
      style: context.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600
      ),
    );
  }

  Widget _buildFastFeatureActions(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildAddProductAction()),
        const SizedBox(width: 16),
        Expanded(child: _buildAddCategoryAction(context)),
      ],
    );
  }

  Widget _buildAddProductAction() {
    return FastFeatureCard(
      rippleColor: Colors.grey,
      filledColor: AppColor.orange,
      borderColor: AppColor.orange,
      icon: Icon(Icons.home),
      title: 'add_product'.tr,
      textColor: Colors.white,
      onTap: () {
        // Get.toNamed(Routes.home);
      },
    );
  }

  Widget _buildAddCategoryAction(BuildContext context) {
    return FastFeatureCard(
      filledColor: context.theme.colorScheme.secondary.withValues(alpha: 0.4),
      borderColor: context.theme.colorScheme.surface.withValues(alpha: 0.2),
      icon: Icon(Icons.home),
      title: 'add_category'.tr,
      textColor: Colors.white,
      onTap: () {},
    );
  }




  Container _buildInfoCard({
    required Widget icon,
    required Color iconColor,
    bool hasGrow = false,
    required BuildContext context,
  }) {
    final isDark = context.theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E1E1E)
            : const Color(0xFFFFFFFF), // gần như trắng, chỉ hơi hơi xám cyan
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : const Color(0xFFB0C4D8).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCardHeader(
            icon: icon,
            iconColor: iconColor,
            hasGrow: hasGrow,
          ),
          const SizedBox(height: 16),
          _buildInfoCardText(context),
        ],
      ),
    );
  }

  Widget _buildInfoCardHeader({
    required Widget icon,
    required Color iconColor,
    required bool hasGrow,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoIcon(icon: icon, iconColor: iconColor),
        if (hasGrow) _buildGrowBadge(),
      ],
    );
  }

  Widget _buildInfoIcon({required Widget icon, required Color iconColor}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: iconColor.withValues(alpha: 0.4), width: 2),
      ),
      child: icon,
    );
  }

  Widget _buildGrowBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColor.greenLight.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColor.greenLight.withValues(alpha: 0.6),
          width: 2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            ' +12%',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColor.greenLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCardText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('total_products'.tr, style: context.textTheme.titleSmall),
        const SizedBox(height: 2),
        Text('1200', style: context.textTheme.headlineSmall),
      ],
    );
  }
}
