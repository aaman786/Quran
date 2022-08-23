import 'package:compass/methods/allsurah_methods.dart';
import 'package:compass/methods/chapter_info_method.dart';
import 'package:compass/models/chapter_model.dart';
import 'package:flutter/material.dart';

class SurahScreen extends StatefulWidget {
  const SurahScreen({Key? key}) : super(key: key);

  @override
  State<SurahScreen> createState() => _SurahScreenState();
}

class _SurahScreenState extends State<SurahScreen> {
  AllSurah allSurah = AllSurah();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Chapters"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 6),
          Expanded(
            child: FutureBuilder(
              future: allSurah.getData(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text("Loading");
                } else {
                  return GridView.builder(
                      itemCount: allSurah.allChapters.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            allSurah.individualSurahInfo =
                                allSurah.allChapters[index].toJson();

                            Navigator.pushNamed(context, 'verse',
                                arguments: allSurah);
                          },
                          splashColor: Colors.white30,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            margin: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 4, right: 4),
                            decoration: BoxDecoration(
                                color: Colors.black38.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.blueAccent,
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Part ${allSurah.getJuz(allSurah.allChapters[index].toJson()['id'])}",
                                    ),
                                    Text("Juz ${allSurah.juzNoAr}"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        allSurah.juzNameEn,
                                        maxLines: 2,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        allSurah.juzNameAr,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  thickness: 1.5,
                                  height: 30,
                                  color: Colors.white30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                        "Chapter ${allSurah.allChapters[index].toJson()['id']}"),
                                    Text(
                                        "Surah  ${allSurah.general.replaceFarsiNumber(allSurah.allChapters[index].toJson()['id'].toString())}"),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      child: Text(
                                          "${allSurah.allChapters[index].toJson()['name_simple']}"),
                                    ),
                                    Flexible(
                                      child: Text(
                                          "${allSurah.allChapters[index].toJson()['name_arabic']}"),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
