import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

/// Label visibility mode
enum LabelVisibility { selectedOnly, always, never }

/// Configuration for the action button
class ActionButtonConfig {
  final Widget? widget;
  final String? sfSymbol;
  final String? assetPath;
  final bool useTemplateRendering;

  const ActionButtonConfig(this.widget, this.sfSymbol)
      : assetPath = null,
        useTemplateRendering = true;

  const ActionButtonConfig.asset(
    this.assetPath, {
    this.useTemplateRendering = false,
  })  : widget = null,
        sfSymbol = null;
}

/// Tab item configuration for LiquidBottomNavigationBar
class LiquidTabItem {
  final Widget widget;
  final Widget? selectedWidget;
  final String sfSymbol;
  final String? selectedSfSymbol;
  final String label;

  const LiquidTabItem({
    required this.widget,
    this.selectedWidget,
    required this.sfSymbol,
    this.selectedSfSymbol,
    required this.label,
  });
}

/// RouteObserver to handle visibility transitions during push/pop
class LiquidRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  LiquidRouteObserver._();
  static final LiquidRouteObserver instance = LiquidRouteObserver._();
}

/// A pure Flutter, highly polished glassmorphic LiquidBottomNavigationBar.
class LiquidBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final List<LiquidTabItem> items;
  final List<int>? itemCounts;
  final bool showActionButton;
  final ActionButtonConfig? actionButton;
  final VoidCallback? onActionTap;
  final double height;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final ValueChanged<double>? onScroll;
  final LabelVisibility labelVisibility;
  final double minimizeThreshold;
  final double bottomOffset;
  final bool enableMinimize;
  final double collapseStartOffset;
  final Duration animationDuration;

  const LiquidBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.items,
    this.itemCounts,
    this.onTap,
    this.showActionButton = false,
    this.actionButton,
    this.onActionTap,
    this.height = 68,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.onScroll,
    this.labelVisibility = LabelVisibility.always,
    this.minimizeThreshold = 0.1,
    this.bottomOffset = 0,
    this.enableMinimize = true,
    this.collapseStartOffset = 20.0,
    this.animationDuration = const Duration(milliseconds: 250),
  })  : assert(items.length >= 2 && items.length <= 5),
        assert(itemCounts == null || itemCounts.length == items.length);

  static _LiquidBottomNavigationBarState? _customState;

  static void handleScroll(double offset, double delta) {
    if (_customState != null) {
      _customState!.handleScroll(offset, delta);
    }
  }

  @override
  State<LiquidBottomNavigationBar> createState() =>
      _LiquidBottomNavigationBarState();
}

class _LiquidBottomNavigationBarState extends State<LiquidBottomNavigationBar>
    with RouteAware {
  bool _isCollapsed = false;
  bool _isTopRoute = true;
  DateTime _ignoreScrollUntil = DateTime.fromMillisecondsSinceEpoch(0);
  DateTime _expandedLockUntil = DateTime.fromMillisecondsSinceEpoch(0);

  @override
  void initState() {
    super.initState();
    LiquidBottomNavigationBar._customState = this;
  }

  @override
  void didUpdateWidget(covariant LiquidBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.enableMinimize && _isCollapsed) {
      setState(() {
        _isCollapsed = false;
      });
    }
  }

  @override
  void dispose() {
    if (LiquidBottomNavigationBar._customState == this) {
      LiquidBottomNavigationBar._customState = null;
    }
    LiquidRouteObserver.instance.unsubscribe(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      LiquidRouteObserver.instance.subscribe(this, route);
    }
  }

  @override
  void didPush() => _setTopRoute(true);

  @override
  void didPopNext() => _setTopRoute(true);

  @override
  void didPushNext() => _setTopRoute(false);

  @override
  void didPop() => _setTopRoute(false);

  void _setTopRoute(bool value) {
    if (_isTopRoute != value) {
      setState(() => _isTopRoute = value);
    }
  }

  void _pauseScrollHandling(Duration duration) {
    _ignoreScrollUntil = DateTime.now().add(duration);
  }

  void _lockExpanded(Duration duration) {
    _expandedLockUntil = DateTime.now().add(duration);
  }

  void handleScroll(double offset, double delta) {
    if (!widget.enableMinimize) return;
    if (DateTime.now().isBefore(_ignoreScrollUntil)) return;
    if (!_isCollapsed && DateTime.now().isBefore(_expandedLockUntil)) return;

    final double topSnapOffset = widget.collapseStartOffset.clamp(0, double.infinity);
    final double pixelThreshold = topSnapOffset;

    if (delta.abs() > 120) return;

    if (!_isCollapsed && delta > 4 && offset > pixelThreshold) {
      setState(() {
        _isCollapsed = true;
      });
      return;
    }

    if (_isCollapsed && offset <= topSnapOffset) {
      setState(() {
        _isCollapsed = false;
      });
    }
  }

  bool _shouldShowLabel(bool isSelected) {
    switch (widget.labelVisibility) {
      case LabelVisibility.selectedOnly:
        return isSelected;
      case LabelVisibility.always:
        return true;
      case LabelVisibility.never:
        return false;
    }
  }

  Widget _buildActionButtonContent(Color tintColor) {
    if (widget.actionButton?.widget != null) {
      return widget.actionButton!.widget!;
    }
    return Icon(Icons.search, color: tintColor);
  }

  Widget _buildTabItemWidget(
    int index,
    LiquidTabItem item,
    Color tintColor, {
    bool isSelected = false,
  }) {
    return isSelected ? (item.selectedWidget ?? item.widget) : item.widget;
  }

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    final primaryAnim = route?.animation ?? kAlwaysCompleteAnimation;
    final secondaryAnim = route?.secondaryAnimation ?? kAlwaysDismissedAnimation;

    return AnimatedBuilder(
      animation: Listenable.merge([primaryAnim, secondaryAnim]),
      builder: (context, child) {
        final shouldHide = _shouldHideForRoute(route);
        return Visibility(
          visible: !shouldHide,
          maintainState: true,
          maintainAnimation: true,
          maintainSize: false,
          child: _buildBar(context),
        );
      },
    );
  }

  bool _shouldHideForRoute(ModalRoute<dynamic>? route) {
    if (route == null) return false;
    if (!_isTopRoute) return true;
    if (!route.isCurrent) return true;
    if ((route.animation?.value ?? 1) < 1) return true;
    if ((route.secondaryAnimation?.value ?? 0) > 0.01) return true;
    return false;
  }

  Widget _buildBar(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final selectedColor = widget.selectedItemColor ?? theme.colorScheme.primary;
    final unselectedColor = widget.unselectedItemColor ??
        (isDark
            ? Colors.white.withValues(alpha: 0.6)
            : Colors.black.withValues(alpha: 0.5));
    final isActionSelected =
        widget.showActionButton && widget.currentIndex >= widget.items.length;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    final double actionSpacing = widget.showActionButton ? 8.0 : 0.0;
    final double fullWidth = MediaQuery.of(context).size.width;
    final double barWidth = widget.showActionButton
        ? fullWidth - 32 - widget.height - actionSpacing
        : fullWidth - 32;
    final double barWidthClamped = math.max(barWidth, widget.height);
    final double bottomGap = widget.bottomOffset + 16;

    return SizedBox(
      height: widget.height + bottomGap,
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: bottomGap),
        child: Stack(
          alignment: isRtl ? Alignment.bottomLeft : Alignment.bottomRight,
          children: [
            Align(
              alignment: isRtl ? Alignment.bottomRight : Alignment.bottomLeft,
              child: AnimatedContainer(
                duration: widget.animationDuration,
                curve: Curves.easeInOut,
                width: _isCollapsed ? widget.height : barWidthClamped,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(36),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: Container(
                      height: widget.height,
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.black.withValues(alpha: 0.08)
                            : Colors.white.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(36),
                      ),
                      child: _isCollapsed
                          ? _buildCollapsedTab(
                              widget.currentIndex,
                              selectedColor,
                              unselectedColor,
                              isDark,
                            )
                          : _buildExpandedTabBar(
                              isDark,
                              selectedColor,
                              unselectedColor,
                            ),
                    ),
                  ),
                ),
              ),
            ),
            if (widget.showActionButton)
              Align(
                alignment: isRtl ? Alignment.bottomLeft : Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    _pauseScrollHandling(const Duration(milliseconds: 1200));
                    _lockExpanded(const Duration(milliseconds: 1200));
                    widget.onActionTap?.call();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(36),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                      child: Container(
                        width: widget.height,
                        height: widget.height,
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.black.withValues(alpha: 0.18)
                              : Colors.white.withValues(alpha: 0.35),
                          borderRadius: BorderRadius.circular(36),
                        ),
                        child: Center(
                          child: AnimatedScale(
                            scale: isActionSelected ? 1.05 : 1.0,
                            duration: widget.animationDuration,
                            curve: Curves.easeInOut,
                            child: IconTheme(
                              data: IconThemeData(
                                size: 30,
                                color: isActionSelected
                                    ? selectedColor
                                    : unselectedColor,
                              ),
                              child: _buildActionButtonContent(
                                isActionSelected
                                    ? selectedColor
                                    : unselectedColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedTabBar(
    bool isDark,
    Color selectedColor,
    Color unselectedColor,
  ) {
    List<int> flexValues = [];
    for (int i = 0; i < widget.items.length; i++) {
      final item = widget.items[i];
      final isSelected = widget.currentIndex == i;
      final showLabel = _shouldShowLabel(isSelected);
      final int labelLength = item.label.length;
      final int extraFlex = showLabel ? (labelLength > 6 ? 2 : 1) : 0;
      flexValues.add(10 + (isSelected ? extraFlex : 0));
    }

    final totalFlex = flexValues.reduce((a, b) => a + b);
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = constraints.maxWidth;

          double selectedLeft = 0;
          double selectedWidth = 0;

          for (int i = 0; i < widget.items.length; i++) {
            final itemWidth = (availableWidth * flexValues[i]) / totalFlex;
            if (i < widget.currentIndex) {
              selectedLeft += itemWidth;
            }
            if (i == widget.currentIndex) {
              selectedWidth = itemWidth;
            }
          }

          final double pillLeft = isRtl
              ? availableWidth - selectedLeft - selectedWidth + 2
              : selectedLeft + 2;

          return Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                left: pillLeft,
                top: 0,
                bottom: 0,
                width: selectedWidth - 4,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: isDark
                          ? [
                              Colors.white.withValues(alpha: 0.18),
                              Colors.white.withValues(alpha: 0.12),
                            ]
                          : [
                              Colors.black.withValues(alpha: 0.12),
                              Colors.black.withValues(alpha: 0.08),
                            ],
                    ),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.3)
                          : Colors.black.withValues(alpha: 0.15),
                      width: 0.5,
                    ),
                  ),
                ),
              ),
              Directionality(
                textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                child: Row(
                  children: List.generate(widget.items.length, (index) {
                    final item = widget.items[index];
                    final isSelected = widget.currentIndex == index;
                    final showLabel = _shouldShowLabel(isSelected);

                    return Expanded(
                      flex: flexValues[index],
                      child: GestureDetector(
                        onTap: () {
                          _pauseScrollHandling(const Duration(milliseconds: 1200));
                          _lockExpanded(const Duration(milliseconds: 1200));
                          widget.onTap?.call(index);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 4,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedScale(
                                scale: isSelected ? 1.1 : 1.0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOutCubic,
                                child: IconTheme(
                                  data: IconThemeData(
                                    size: 22,
                                    color: isSelected
                                        ? selectedColor
                                        : unselectedColor,
                                  ),
                                  child: _buildTabItemWidget(
                                    index,
                                    item,
                                    isSelected
                                        ? selectedColor
                                        : unselectedColor,
                                    isSelected: isSelected,
                                  ),
                                ),
                              ),
                              if (showLabel) ...[
                                const SizedBox(height: 2),
                                AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOutCubic,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? selectedColor
                                        : unselectedColor,
                                    letterSpacing: 0.1,
                                  ),
                                  child: Text(
                                    item.label,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCollapsedTab(
    int currentIndex,
    Color selectedColor,
    Color unselectedColor,
    bool isDark,
  ) {
    final item = widget.items[currentIndex];
    return GestureDetector(
      onTap: () => setState(() => _isCollapsed = false),
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.black.withValues(alpha: 0.18)
              : Colors.white.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(26),
        ),
        child: Center(
          child: IconTheme(
            data: IconThemeData(size: 26, color: selectedColor),
            child: _buildTabItemWidget(
              widget.currentIndex,
              item,
              selectedColor,
              isSelected: true,
            ),
          ),
        ),
      ),
    );
  }
}
