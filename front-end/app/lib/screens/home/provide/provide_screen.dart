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
        "country": "Marketing",
        "paragraph": "Follow a hashtag total posts, videos",
      },
      {
        "imgSrc": "assets/images/provide/graphic.svg",
        "country": "Graphic design",
        "paragraph": "Follow a hashtag total posts, videos",
      },
      {
        "imgSrc": "assets/images/provide/heaking.svg",
        "country": "Heaking",
        "paragraph": "Follow a hashtag total posts, videos",
      },
      {
        "imgSrc": "assets/images/provide/uidesign.svg",
        "country": "UI/UX Design",
        "paragraph": "Follow a hashtag total posts, videos",
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        //final screenHight = constraints.maxHeight;
        final isMobile = screenWidth < 800;

        // -----------------------------
        // MAIN CONTAINER LAYOUT
        // -----------------------------
        final mainLayout = calculateAdaptiveLayout(
          screenWidth,
          550,
          2, // 2 columns (text + cards)
          5,
          0.8,
          500,
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
          350,
          2, // default 2 columns
          20,
          0.8,
          350,
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
                  // CONTAINER 1: TEXT
                  // -----------------------------
                  Container(
                    width: mainLayout.itemWidth,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FBFF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: isMobile
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          "We provide that service.",
                          textAlign: isMobile
                              ? TextAlign.center
                              : TextAlign.start,
                          style: TextStyle(
                            fontSize: isMobile ? 32 : 48,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem "
                          "accusantium doloremque laudantium, totam rem aperiam, eaque ipsa "
                          "quae ab illo inventore veritatis et quasi architecto beatae vitae "
                          "dicta sunt explicabo.",
                          textAlign: isMobile
                              ? TextAlign.center
                              : TextAlign.start,
                          style: TextStyle(
                            fontSize: isMobile ? 16 : 18,
                            color: Colors.blueGrey[600],
                            height: 1.5,
                          ),
                        ),
                      ],
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
                          "🧩 [CARD] '${item['country']}' | width=${cardLayout.itemWidth}, height=${cardLayout.itemHeight}",
                        );
                        return Container(
                          width: cardLayout.itemWidth,
                          height: cardLayout.itemHeight,
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
                                item["country"]!,
                                style: TextStyle(
                                  fontSize: cardLayout.itemWidth * 0.07,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: cardLayout.itemHeight * 0.05),
                              Flexible(
                                child: Text(
                                  item["paragraph"]!,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontSize: cardLayout.itemWidth * 0.05,
                                    color: Colors.blueGrey[700],
                                    height: 1.3,
                                  ),
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
