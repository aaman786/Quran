import 'package:compass/methods/allsurah_methods.dart';
import 'package:compass/methods/chapter_info_method.dart';
import 'package:compass/methods/general_methods.dart';
import 'package:compass/methods/verse_method.dart';
import 'package:compass/provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VerseScreen extends StatelessWidget {
  const VerseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllSurah allSurah =
        ModalRoute.of(context)!.settings.arguments as AllSurah;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Verses"),
          actions: [
            CupertinoSwitch(
                activeColor: Colors.green,
                value: context.watch<VerseProvider>().isHn,
                onChanged: (value) {
                  context.read<VerseProvider>().switchChange(value);
                }),
            IconButton(
                onPressed: context.read<VerseProvider>().surahInfo,
                icon: context.watch<VerseProvider>().viewInfo
                    ? Icon(
                        Icons.info,
                        color: Colors.green.shade800,
                      )
                    : const Icon(Icons.info_outline))
          ],
        ),
        body: Column(
          children: [
            context.watch<VerseProvider>().viewInfo
                ? SurahInfo(allSurah: allSurah)
                : Container(),
            context.watch<VerseProvider>().viewInfo
                ? Container(
                    padding: const EdgeInsets.all(08),
                    margin: const EdgeInsets.all(08),
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    color: Colors.black38.withOpacity(0.5),
                    child: Image.asset(
                      "assets/bismillah.png",
                      color: Colors.amber,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(),
            VerseList(allSurah: allSurah),
          ],
        ));
  }
}

class VerseList extends StatelessWidget {
  final AllSurah allSurah;
  const VerseList({
    required this.allSurah,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Verse verse = Verse();
    General general = General();

    return Expanded(
      child: FutureBuilder(
          future: verse.getDataVerse(allSurah.individualSurahInfo["id"]),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text("Loading");
            } else {
              return ListView.builder(
                itemCount: verse.verses.length,
                itemBuilder: (context, index) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  margin: const EdgeInsets.only(
                      top: 3, bottom: 3, left: 5, right: 5),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.black38.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.blueAccent,
                      )),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                child: Image.asset("assets/verseend.png"),
                              ),
                              Text(
                                verse.verses[index].toJson()["verse_key"],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Expanded(
                            child: RichText(
                              textAlign: TextAlign.end,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      style: const TextStyle(
                                          fontSize: 40, color: Colors.white),
                                      text: verse.verses[index]
                                          .toJson()['text_uthmani']),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      kSizedBoxOfSurahInfo,
                      Row(
                        children: [
                          Flexible(
                              child: Html(
                            data: verse.versesEng[index].toJson()["text"],
                            style: {
                              "body": Style(
                                fontSize: FontSize(20),
                                color: Colors.white,
                              ),
                            },
                          )
                              //  Text(
                              //   general.removeAllHtmlTags(
                              //       verse.versesEng[index].toJson()["text"]),
                              //   style: const TextStyle(
                              //       fontSize: 20, color: Colors.white),
                              // ),
                              ),
                        ],
                      ),
                      kSizedBoxOfSurahInfo,
                      context.watch<VerseProvider>().isHn
                          ? Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    general.removeAllHtmlTags(verse
                                        .versesHin[index]
                                        .toJson()["text"]),
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ],
                            )
                          : Row()
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}

class SurahInfo extends StatelessWidget {
  final AllSurah allSurah;
  const SurahInfo({
    required this.allSurah,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color surahInfoTitle = Colors.green;

    SurahInfoDetails surahInfoDetails = SurahInfoDetails();

    return Container(
      padding: const EdgeInsets.all(08),
      margin: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.black38.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.blueAccent,
          )),
      child: FutureBuilder(
        future:
            surahInfoDetails.getSurahInfo(allSurah.individualSurahInfo["id"]),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text("No Data");
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                                style: TextStyle(
                                    fontSize: 16, color: surahInfoTitle),
                                text: "Part: "),
                            TextSpan(
                                style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                text:
                                    "${allSurah.getJuz(allSurah.individualSurahInfo["id"])} ${allSurah.juzNameEn}"),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      " ${allSurah.juzNoAr} ${allSurah.juzNameAr}",
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                kSizedBoxOfSurahInfo,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              style: TextStyle(
                                  fontSize: 16, color: surahInfoTitle),
                              text: "Chapter: "),
                          TextSpan(
                              style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                              text:
                                  "${allSurah.individualSurahInfo["name_simple"]} ${allSurah.individualSurahInfo["id"]}"),
                        ],
                      ),
                    ),
                    Text(
                      "${General().replaceFarsiNumber(allSurah.individualSurahInfo["id"].toString())} ${allSurah.individualSurahInfo["name_arabic"]}",
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                kDividerOfSurahInfo,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              style:
                                  TextStyle(fontSize: 14, color: Colors.green),
                              text: "Revelation place: "),
                          TextSpan(
                              style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              )),
                              text: allSurah
                                  .individualSurahInfo["revelation_place"]),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              style: TextStyle(
                                  fontSize: 14, color: surahInfoTitle),
                              text: "Revelation Order: "),
                          TextSpan(
                              style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              )),
                              text: allSurah
                                  .individualSurahInfo["revelation_order"]
                                  .toString()),
                        ],
                      ),
                    ),
                  ],
                ),
                kSizedBoxOfSurahInfo,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              style: TextStyle(
                                  fontSize: 14, color: surahInfoTitle),
                              text: "Total verses: "),
                          TextSpan(
                              style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              )),
                              text: allSurah.individualSurahInfo["verses_count"]
                                  .toString()),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              style: TextStyle(
                                  fontSize: 14, color: surahInfoTitle),
                              text: "Sajdas: "),
                          TextSpan(
                              style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              )),
                              text: "5"),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              style: TextStyle(
                                  fontSize: 14, color: surahInfoTitle),
                              text: "Rukus: "),
                          TextSpan(
                              style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              )),
                              text: "5"),
                        ],
                      ),
                    ),
                  ],
                ),
                kDividerOfSurahInfo,
                const Text("Decription About The Chapter",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    )),
                Text(allSurah.individualSurahInfo["translated_name"]["name"],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    )),
                kSizedBoxOfSurahInfo,
                Row(
                  children: [
                    Flexible(
                      child: InkWell(
                        splashColor: Colors.lightGreen,
                        onTap: () {
                          descriptionCard(context, "Short Description",
                              surahInfoDetails.surahDescription["short_text"]);
                        },
                        child: RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.green),
                                  text: "Short Description:- "),
                              TextSpan(
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  text: surahInfoDetails
                                      .surahDescription["short_text"]),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Flexible(
                      child: InkWell(
                        splashColor: Colors.lightGreen,
                        onTap: () {
                          descriptionCard(context, "Detailed Description",
                              surahInfoDetails.surahDescription["text"]);
                        },
                        child: RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.green),
                                  text: "Detailed Description:- "),
                              TextSpan(
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                                text: surahInfoDetails.surahDescription["text"],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          }
        },
      ),
    );
  }

  Future<dynamic> descriptionCard(
      BuildContext context, String description, String content) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(description),
              content: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Html(
                    data: content,
                  )),
            ));
  }
}

const kDividerOfSurahInfo = Divider(
  color: Colors.white10,
  height: 15,
);
const kSizedBoxOfSurahInfo = SizedBox(
  height: 6,
);
