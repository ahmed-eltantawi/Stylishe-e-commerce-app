import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/features/settings/presentation/manager/settings_cubit/settings_cubit.dart';
import 'package:stylish/generated/l10n.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.greyBackground,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        elevation: 0,
        title: Text(S.of(context).settingsTitle, style: AppTextStyles.semiBold18),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        children: [
          _AppearanceSection(),
          SizedBox(height: 16.h),
          _LanguageSection(),
          SizedBox(height: 16.h),
          _NotificationsSection(),
          SizedBox(height: 16.h),
          _GeneralSection(),
          SizedBox(height: 16.h),
          _AboutSection(),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  _SectionHeader(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(title, style: AppTextStyles.semiBold14.copyWith(color: AppColors.primary)),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [BoxShadow(color: context.shadowColor, blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: child,
    );
  }
}

class _RadioTile extends StatelessWidget {
  const _RadioTile({
    required this.selected,
    required this.label,
    required this.icon,
    required this.onTap,
    this.showBorder = true,
  });
  final bool selected;
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          border: showBorder ? Border(bottom: BorderSide(color: context.dividerColor)) : null,
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: selected ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, size: 20.r, color: selected ? AppColors.primary : context.textHint),
            ),
            SizedBox(width: 12.w),
            Expanded(child: Text(label, style: AppTextStyles.regular14.copyWith(color: context.textPrimary))),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20.r,
              height: 20.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? AppColors.primary : Colors.transparent,
                border: Border.all(
                  color: selected ? AppColors.primary : context.textHint,
                  width: selected ? 0 : 2,
                ),
              ),
              child: selected ? Icon(Icons.check, size: 12.r, color: Colors.white) : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _AppearanceSection extends StatelessWidget {
  _AppearanceSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(S.of(context).appearance),
        _Card(
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              final modes = ThemeMode.values;
              return Column(
                children: modes.map((mode) {
                  final selected = state.themeMode == mode;
                  final label = switch (mode) {
                    ThemeMode.light => S.of(context).light,
                    ThemeMode.dark => S.of(context).dark,
                    ThemeMode.system => S.of(context).systemDefault,
                  };
                  final icon = switch (mode) {
                    ThemeMode.light => Icons.light_mode_rounded,
                    ThemeMode.dark => Icons.dark_mode_rounded,
                    ThemeMode.system => Icons.settings_brightness_rounded,
                  };
                  return _RadioTile(
                    selected: selected,
                    label: label,
                    icon: icon,
                    showBorder: mode != modes.last,
                    onTap: () => context.read<SettingsCubit>().setThemeMode(mode),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _LanguageSection extends StatelessWidget {
  _LanguageSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(S.of(context).language),
        _Card(
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return Column(
                children: [
                  _buildLangTile(context, state, S.of(context).english, const Locale('en'), true),
                  _buildLangTile(context, state, S.of(context).arabic, const Locale('ar'), false),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLangTile(BuildContext context, SettingsState state, String label, Locale locale, bool showBorder) {
    final selected = state.locale.languageCode == locale.languageCode;
    return InkWell(
      onTap: () => context.read<SettingsCubit>().setLocale(locale),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          border: showBorder ? Border(bottom: BorderSide(color: context.dividerColor)) : null,
        ),
        child: Row(
          children: [
            Text(label, style: AppTextStyles.regular14.copyWith(color: context.textPrimary)),
            const Spacer(),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20.r,
              height: 20.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? AppColors.primary : Colors.transparent,
                border: Border.all(color: selected ? AppColors.primary : context.textHint, width: selected ? 0 : 2),
              ),
              child: selected ? Icon(Icons.check, size: 12.r, color: Colors.white) : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationsSection extends StatelessWidget {
  _NotificationsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(S.of(context).notifications),
        _Card(
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return SwitchListTile(
                value: state.notificationsEnabled,
                onChanged: (val) => context.read<SettingsCubit>().setNotificationsEnabled(val),
                title: Text(S.of(context).enableNotifications, style: AppTextStyles.regular14.copyWith(color: context.textPrimary)),
                subtitle: Text(S.of(context).receiveUpdates, style: AppTextStyles.regular14),
                activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
                activeThumbColor: AppColors.primary,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _GeneralSection extends StatelessWidget {
  _GeneralSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(S.of(context).general),
        _Card(
          child: InkWell(
            onTap: () => _showClearCacheDialog(context),
            borderRadius: BorderRadius.circular(12.r),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              child: Row(
                children: [
                  Icon(Icons.delete_outline_rounded, size: 20.r, color: context.textHint),
                  SizedBox(width: 12.w),
                  Expanded(child: Text(S.of(context).clearCache, style: AppTextStyles.regular14.copyWith(color: context.textPrimary))),
                  Icon(Icons.chevron_right_rounded, size: 20.r, color: context.textHint),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(S.of(context).clearCache, style: AppTextStyles.semiBold18),
        content: Text(
          S.of(context).clearCacheMessage,
          style: AppTextStyles.regular14,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(S.of(context).cancel, style: AppTextStyles.regular14.copyWith(color: context.textHint)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _clearCache(context);
            },
            child: Text(S.of(context).clear, style: AppTextStyles.regular14.copyWith(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  Future<void> _clearCache(BuildContext context) async {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).cacheClearedSuccessfully),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        ),
      );
    }
  }
}

class _AboutSection extends StatelessWidget {
  _AboutSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(S.of(context).about),
        _Card(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.shopping_bag_rounded, color: AppColors.primary, size: 40.r),
                    ),
                    SizedBox(height: 12.h),
                    Text('Stylish', style: AppTextStyles.semiBold18),
                    SizedBox(height: 4.h),
                    Text('Version 1.0.0', style: AppTextStyles.regular14),
                  ],
                ),
              ),
              Divider(height: 1, color: context.dividerColor),
              _AboutTile(icon: Icons.privacy_tip_outlined, label: S.of(context).privacyPolicy),
              Divider(height: 1, color: context.dividerColor),
              _AboutTile(icon: Icons.description_outlined, label: S.of(context).termsAndConditions),
              Divider(height: 1, color: context.dividerColor),
              _AboutTile(
                icon: Icons.article_outlined,
                label: S.of(context).licenses,
                onTap: (ctx) => showLicensePage(
                  context: ctx,
                  applicationName: 'Stylish',
                  applicationVersion: '1.0.0',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AboutTile extends StatelessWidget {
  const _AboutTile({required this.icon, required this.label, this.onTap});
  final IconData icon;
  final String label;
  final void Function(BuildContext)? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null ? () => onTap!(context) : null,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(icon, size: 20.r, color: context.textHint),
            SizedBox(width: 12.w),
            Expanded(child: Text(label, style: AppTextStyles.regular14.copyWith(color: context.textPrimary))),
            Icon(Icons.chevron_right_rounded, size: 20.r, color: context.textHint),
          ],
        ),
      ),
    );
  }
}