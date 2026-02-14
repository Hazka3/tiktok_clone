import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  @override
  void initState() {
    super.initState();
    _initTabController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: SizedBox(
            height: Sizes.size40,
            child: TextField(
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
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
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
            tabAlignment: TabAlignment.start,
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: Sizes.size10,
                crossAxisSpacing: Sizes.size10,
                childAspectRatio: 9 / 20,
              ),
              itemBuilder: (context, index) => Column(
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
                  const Text(
                    "This is a very long caption for my app that im upload just now currently.",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v5,
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
      ),
    );
  }
}
