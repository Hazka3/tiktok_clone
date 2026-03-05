import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  final _focusNode = FocusNode();

  final TextEditingController _textEditingController = TextEditingController();
  late final TabController _tabController;

  void _initTabController() {
    _tabController = TabController(
      length: tabs.length,
      vsync: this,
    );

    _tabController.addListener(
      () {
        if (_tabController.indexIsChanging) {
          FocusScope.of(context).unfocus();
        }
      },
    );
  }

  void _onSearchChanged(String value) {
    debugPrint(value);
  }

  void _onSearchSubmitted(String value) {
    debugPrint(value);
  }

  void _onClearTap() {
    _textEditingController.clear();
  }

  @override
  void initState() {
    super.initState();
    _initTabController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _tabController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: SizedBox(
          height: Sizes.size40,
          // controller, focusnode の両方をlistenしたいため、ValueListenableBuilder ではなく AnimatedBuilder を採用
          child: AnimatedBuilder(
            animation: Listenable.merge([_textEditingController, _focusNode]),
            builder: (context, child) {
              final bool showClear =
                  _focusNode.hasFocus && _textEditingController.text.isNotEmpty;
              return ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: Breakpoints.sm),
                child: TextField(
                  focusNode: _focusNode,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  controller: _textEditingController,
                  onChanged: _onSearchChanged,
                  onSubmitted: _onSearchSubmitted,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: Sizes.size8,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    hintText: "Search",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minHeight: 24,
                      minWidth: 24,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(Sizes.size8),
                      child: FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                        size: Sizes.size18,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    suffixIconConstraints: const BoxConstraints(
                      minHeight: 24,
                      minWidth: 24,
                    ),
                    suffixIcon: showClear
                        ? IconButton(
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                            onPressed: _onClearTap,
                            icon: FaIcon(
                              FontAwesomeIcons.solidCircleXmark,
                              color: Colors.grey.shade500,
                              size: Sizes.size20,
                            ),
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        actions: [
          const FaIcon(FontAwesomeIcons.sliders),
        ],
        actionsPadding: const EdgeInsets.only(
          right: Sizes.size16,
        ),
        bottom: TabBar(
          controller: _tabController,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size16,
          ),
          labelPadding: const EdgeInsets.symmetric(
            horizontal: Sizes.size20,
          ),
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Sizes.size18,
          ),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey.shade500,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3,
          indicatorColor: Colors.black,
          isScrollable: true,
          tabAlignment: TabAlignment.center,
          splashFactory: NoSplash.splashFactory,
          tabs: [
            for (var tab in tabs)
              Tab(
                text: tab,
              ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          GridView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(
              Sizes.size10,
            ),
            itemCount: 20,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: width > Breakpoints.lg ? 5 : 2,
              mainAxisSpacing: Sizes.size10,
              crossAxisSpacing: Sizes.size10,
              childAspectRatio: 9 / 20,
            ),
            itemBuilder: (context, index) => LayoutBuilder(
              builder: (context, constraints) => Column(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Sizes.size4),
                    ),
                    child: AspectRatio(
                      aspectRatio: 9 / 16,
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: "assets/images/placeholder.jpg",
                        image:
                            "https://picsum.photos/seed/${index + 1}/200/${350 + (5 * index)}",
                      ),
                    ),
                  ),
                  Gaps.v8,
                  Text(
                    "${constraints.maxWidth}This is a very long caption for my app that im upload just now currently.",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v5,
                  // 大画面用の処理 - プロフィールROWを隠す
                  if (constraints.maxWidth < 200 || constraints.maxWidth > 250)
                    DefaultTextStyle(
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage(
                              "https://avatars.githubusercontent.com/u/94900388",
                            ),
                          ),
                          Gaps.h4,
                          const Expanded(
                            child: Text(
                              "My avatar is going to be very long.",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Gaps.h4,
                          FaIcon(
                            FontAwesomeIcons.heart,
                            size: Sizes.size16,
                            color: Colors.grey.shade600,
                          ),
                          Gaps.h2,
                          const Text(
                            "2.5M",
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          for (var tab in tabs.skip(1))
            Center(
              child: Text(
                tab,
                style: const TextStyle(
                  fontSize: Sizes.size20,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
