import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProvideScreen extends StatelessWidget {
  const ProvideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> aboutData = [
      {
        "imgSrc": "assets/images/provide/marketing.svg",
        "country": "Marketing",
        "paragraph": "Follow a hashtag total posts, videos"
      },
      {
        "imgSrc": "assets/images/provide/graphic.svg",
        "country": "Graphic design",
        "paragraph": "Follow a hashtag total posts, videos"
      },
      {
        "imgSrc": "assets/images/provide/heaking.svg",
        "country": "Heaking",
        "paragraph": "Follow a hashtag total posts, videos"
      },
      {
        "imgSrc": "assets/images/provide/uidesign.svg",
        "country": "UI/UX Design",
        "paragraph": "Follow a hashtag total posts, videos"
      },
    ];

    return Container(
      key: const Key("services"),
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 800;

          return Column(
            children: [
              Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 🟦 COLUMN 1
                  Expanded(
                    flex: isMobile ? 0 : 1,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: isMobile
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            "We provide that service.",
                            textAlign:
                                isMobile ? TextAlign.center : TextAlign.start,
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
                            textAlign:
                                isMobile ? TextAlign.center : TextAlign.start,
                            style: TextStyle(
                              fontSize: isMobile ? 16 : 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.blueGrey[600],
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 30),
                          InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: isMobile
                                  ? MainAxisAlignment.center
                                  : MainAxisAlignment.start,
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

                  if (!isMobile)
                    const SizedBox(
                        width:
                            60), // spacing between columns for larger screens

                  // 🟩 COLUMN 2
                  Expanded(
                    flex: isMobile ? 0 : 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6F0FF),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 40,
                        horizontal: 20,
                      ),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isMobile ? 1 : 2,
                          crossAxisSpacing: 30,
                          mainAxisSpacing: 30,
                          childAspectRatio: 1,
                        ),
                        itemCount: aboutData.length,
                        itemBuilder: (context, index) {
                          final item = aboutData[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.15),
                                  blurRadius: 10,
                                  offset: const Offset(2, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  item["imgSrc"]!,
                                  width: 64,
                                  height: 64,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  item["country"]!,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item["paragraph"]!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blueGrey[700],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
