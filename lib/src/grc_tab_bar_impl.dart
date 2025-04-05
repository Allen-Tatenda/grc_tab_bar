import 'package:flutter/material.dart';
import 'package:grc_tab_bar/grc_tab_bar.dart';

class GrcTabBar extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> content;
  final Color? activeTabBackground;
  final Color? tabBackground;
  final Style? style;
  final TabBarAlignment? tabBarAlignment;
  final TabBarPosition? tabBarPosition;
  const GrcTabBar(
      {super.key,
      required this.tabs,
      required this.content,
      this.style,
      this.activeTabBackground,
      this.tabBackground,
      this.tabBarAlignment,
      this.tabBarPosition});

  @override
  State<GrcTabBar> createState() => _GrcTabBarState();
}

class _GrcTabBarState extends State<GrcTabBar> with SingleTickerProviderStateMixin {
  int activeTab = 0;
  MainAxisAlignment tabAlignment = MainAxisAlignment.start;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _changeTab(int index) {
    setState(() {
      _controller.forward(from: 0.0);
      activeTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tabBarAlignment == TabBarAlignment.right) {
      tabAlignment = MainAxisAlignment.end;
    }
    if (widget.tabBarAlignment == TabBarAlignment.left) {
      tabAlignment = MainAxisAlignment.start;
    }
    if (widget.tabBarAlignment == TabBarAlignment.center) {
      tabAlignment = MainAxisAlignment.center;
    }
    
    return Material(
      child: Column(
        children: [
          if (widget.tabBarPosition == TabBarPosition.top || widget.tabBarPosition == null)
            Row(
              mainAxisAlignment: tabAlignment,
              children: [
                for (int i = 0; i < widget.tabs.length; i++) ...[
                  (widget.tabBarAlignment == TabBarAlignment.full)
                      ? expandedTab(i)
                      : tabBasic(i),
                  const Divider(
                    height: 20,
                    thickness: 20,
                    color: Colors.black,
                    indent: 0.23,
                  )
                ]
              ],
            ),
          
          Row(
            children: [
              (widget.tabBarPosition == TabBarPosition.left)?SizedBox(
                width: 200,
                height: 300,
                child: Column(
                  children: [
                    for (int i = 0; i < widget.tabs.length; i++) ...[
                      tabBasic(i)
                    ]
                  ],
                ),
              ):const SizedBox.shrink(),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.1, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: KeyedSubtree(
                    key: ValueKey<int>(activeTab),
                    child: widget.content[activeTab],
                  ),
                ),
              ),
               (widget.tabBarPosition == TabBarPosition.right)?SizedBox(
                width: 200,
                height: 300,
                child: Column(
                  children: [
                    for (int i = 0; i < widget.tabs.length; i++) ...[
                      tabBasic(i)
                    ]
                  ],
                ),
              ):const SizedBox.shrink(),
            ],
          ),
          
          if (widget.tabBarPosition == TabBarPosition.bottom)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: tabAlignment,
                children: [
                  for (int i = 0; i < widget.tabs.length; i++) ...[
                    (widget.tabBarAlignment == TabBarAlignment.full)
                        ? expandedTab(i)
                        : tabBasic(i),
                    const Divider(
                      height: 20,
                      thickness: 20,
                      color: Colors.black,
                      indent: 0.23,
                    )
                  ]
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget tabBasic(int i) {
    return InkWell(
      onTap: () => _changeTab(i),
      splashColor: Colors.blue.shade100,
      highlightColor: Colors.blue.shade100,
      borderRadius: (widget.style == Style.rounded)
          ? (i == 0)
              ? const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4))
              : (i == widget.tabs.length - 1)
                  ? const BorderRadius.only(
                      topRight: Radius.circular(4),
                      bottomRight: Radius.circular(4))
                  : BorderRadius.circular(0)
          : BorderRadius.circular(0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        height: 30,
        decoration: BoxDecoration(
          color: (activeTab == i)
              ? (widget.activeTabBackground != null)
                  ? widget.activeTabBackground
                  : Colors.white
              : (widget.tabBackground != null)
                  ? widget.tabBackground
                  : Colors.black38,
          borderRadius: (widget.style == Style.rounded)
              ? (i == 0)
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      bottomLeft: Radius.circular(4))
                  : (i == widget.tabs.length - 1)
                      ? const BorderRadius.only(
                          topRight: Radius.circular(4),
                          bottomRight: Radius.circular(4))
                      : BorderRadius.circular(0)
              : BorderRadius.circular(0),
          gradient: (activeTab == i)
              ? const LinearGradient(colors: [
                  Color.fromARGB(255, 2, 1, 26),
                  Colors.blue,
                  Color.fromARGB(255, 2, 1, 26)
                ])
              : const LinearGradient(colors: [
                  Color.fromARGB(255, 204, 204, 205),
                    Colors.white,
                    Color.fromARGB(255, 204, 204, 205),
                ]),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              child: Text(
                widget.tabs[i],
                key: ValueKey<int>(activeTab == i ? 1 : 0),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: activeTab == i ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget expandedTab(int i) {
    return Expanded(
      child: InkWell(
        onTap: () => _changeTab(i),
        splashColor: Colors.blue.shade300,
        highlightColor: Colors.blue.shade100,
        borderRadius: (widget.style == Style.rounded)
            ? (i == 0)
                ? const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4))
                : (i == widget.tabs.length - 1)
                    ? const BorderRadius.only(
                        topRight: Radius.circular(4),
                        bottomRight: Radius.circular(4))
                    : BorderRadius.circular(0)
            : BorderRadius.circular(0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          height: 30,
          decoration: BoxDecoration(
            color: (activeTab == i)
                ? (widget.activeTabBackground != null)
                    ? widget.activeTabBackground
                    : Colors.white
                : (widget.tabBackground != null)
                    ? widget.tabBackground
                    : Colors.black38,
            borderRadius: (widget.style == Style.rounded)
                ? (i == 0)
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        bottomLeft: Radius.circular(4))
                    : (i == widget.tabs.length - 1)
                        ? const BorderRadius.only(
                            topRight: Radius.circular(4),
                            bottomRight: Radius.circular(4))
                        : BorderRadius.circular(0)
                : BorderRadius.circular(0),
            gradient: (activeTab == i)
                ? const LinearGradient(colors: [
                    Color.fromARGB(255, 2, 1, 26),
                    Colors.blue,
                    Color.fromARGB(255, 2, 1, 26)
                  ])
                : const LinearGradient(colors: [
                  Color.fromARGB(255, 204, 204, 205),
                    Colors.white,
                    Color.fromARGB(255, 204, 204, 205),
                    
                  ]),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: Text(
                  widget.tabs[i],
                  key: ValueKey<int>(activeTab == i ? 1 : 0),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: activeTab == i ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}