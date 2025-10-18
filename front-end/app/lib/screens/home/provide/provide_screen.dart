import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/adaptive_layout.dart'; // helper file

class ProvideScreen extends StatelessWidget {
  const ProvideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> aboutData = [
      {
        "imgSrc": "assets/images/provide/marketing.svg",
        "service": "Marketing",
        "paragraph": "Follow a hashtag total posts, videos",
      },
      {
        "imgSrc": "assets/images/provide/graphic.svg",
        "service": "Graphic design",
        "paragraph": "Follow a hashtag total posts, videos",
      },
      {
        "imgSrc": "assets/images/provide/heaking.svg",
        "service": "Heaking",
        "paragraph": "Follow a hashtag total posts, videos",
      },
      {
        "imgSrc": "assets/images/provide/uidesign.svg",
        "service": "UI/UX Design",
        "paragraph": "Follow a hashtag total posts, videos",
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        // -----------------------------
        // MAIN CONTAINER LAYOUT
        // -----------------------------
        final mainLayout = calculateAdaptiveLayout(
          screenWidth,
          650,
          2, // 2 columns (text + cards)
          5,
          0.8,
          600,
        );

        debugPrint(
          "📏 [MAIN LAYOUT] screenWidth=$screenWidth, "
          "itemWidth=${mainLayout.itemWidth}, itemHeight=${mainLayout.itemHeight}, "
          "spacing=${mainLayout.spacing}, crossAxisCount=${mainLayout.crossAxisCount}",
        );

        final container2Width = mainLayout.itemWidth;

        // -----------------------------
        // CONTAINER 2 (CARDS) LAYOUT
        // -----------------------------
        final cardLayout = calculateAdaptiveLayout(
          container2Width,
          400,
          2, // default 2 columns
          40,
          0.8,
          400,
        );

        debugPrint(
          "📏 [CONTAINER 2 LAYOUT] screenWidth=$screenWidth, container2Width=$container2Width "
          "itemWidth=${mainLayout.itemWidth}, itemHeight=${mainLayout.itemHeight}, "
          "spacing=${mainLayout.spacing}, crossAxisCount=${mainLayout.crossAxisCount}",
        );

        // -----------------------------
        // MAIN SCROLLABLE CONTAINER
        // -----------------------------
        return SingleChildScrollView(
          child: Center(
            child: Container(
              color: Colors.white,
              constraints: const BoxConstraints(maxWidth: 1600),
              padding: EdgeInsets.all(mainLayout.spacing),
              child: Wrap(
                spacing: mainLayout.spacing,
                runSpacing: mainLayout.spacing,
                alignment: WrapAlignment.center,
                children: [
                  // -----------------------------
                  // CONTAINER 1: TEXT (center aligned)
                  // -----------------------------
                  Container(
                    width: mainLayout.itemWidth,
                    height: mainLayout.itemHeight,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "We provide that service.",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Our expertise lies in electronic system design, IoT integration, and software development — empowering industries with smart, efficient, and connected solutions tailored to their needs.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blueGrey[600],
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 30),
                          InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Learn more",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF1A73E8),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                SvgPicture.asset(
                                  "assets/images/provide/arrow.svg",
                                  width: 20,
                                  height: 20,
                                  colorFilter: const ColorFilter.mode(
                                    Color(0xFF1A73E8),
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // -----------------------------
                  // CONTAINER 2: CARDS
                  // -----------------------------
                  Container(
                    width: mainLayout.itemWidth,
                    padding: EdgeInsets.all(cardLayout.spacing),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F0FF),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Wrap(
                      spacing: cardLayout.spacing,
                      runSpacing: cardLayout.spacing,
                      alignment: WrapAlignment.start,
                      children: aboutData.map((item) {
                        debugPrint(
                          "🧩 [CARD] '${item['service']}' | width=${cardLayout.itemWidth}, height=${cardLayout.itemHeight}",
                        );
                        return Container(
                          width: cardLayout.itemWidth,
                          padding: EdgeInsets.all(cardLayout.itemWidth * 0.05),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.15),
                                blurRadius: 8,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                item["imgSrc"]!,
                                height: cardLayout.itemHeight * 0.25,
                              ),
                              SizedBox(height: cardLayout.itemHeight * 0.1),
                              Text(
                                item["service"]!,
                                style: TextStyle(
                                  fontSize: cardLayout.itemWidth * 0.07,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: cardLayout.itemHeight * 0.05),
                              Text(
                                item["paragraph"]!,
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: cardLayout.itemWidth * 0.05,
                                  color: Colors.blueGrey[700],
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
