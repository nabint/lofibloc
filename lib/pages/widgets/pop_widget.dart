import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lofi/bloc/lofi_bloc.dart';
import 'package:lofi/data/models/lofi.dart';
import 'package:lofi/pages/lofi_detail.dart';
import 'package:lofi/utils/media_player_central.dart';

// ignore: must_be_immutable
class PopWidget extends StatelessWidget {
  final Lofi lofi;

  PopWidget({
    Key key,
    this.lofi,
  }) : super(key: key);
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LofiBloc, LofiState>(
      builder: (context, state) {
        if (state is LofiPlaying && state.lofi.id == lofi.id) {
          return build_pop_widget(true, lofi, context);
        } else
          return build_pop_widget(false, lofi, context);
      },
    );
  }

  // ignore: non_constant_identifier_names
  Widget build_pop_widget(bool isPlaying, Lofi lofi, BuildContext context) {
    final lofibloc = BlocProvider.of<LofiBloc>(context);

    void playlofi() {
      updateNotificationMediaPlayer(true, lofi);
      lofibloc.add(
        PlayLofi(lofi.id, lofi),
      );
    }

    return InkWell(
      splashColor: Colors.blue.withAlpha(30),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) {
              return BlocProvider.value(
                value: lofibloc,
                child: LofiDetail(
                  isPlaying: isPlaying,
                  lofi: lofi,
                ),
              );
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          image: DecorationImage(
              image: AssetImage(lofi.getImageUrl), fit: BoxFit.cover),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.15),
              offset: Offset(2, 12.0),
              blurRadius: 4.0,
              spreadRadius: 5.0,
            ),
          ],
        ),
        child: SizedBox(
          height: 230,
          width: 215,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  height: 60,
                  width: 215,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                    ),
                    color: Colors.pink.withOpacity(0.8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lofi.title,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              lofi.artist,
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFededed),
                              ),
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<LofiBloc, LofiState>(
                        // ignore: missing_return
                        builder: (context, state) {
                          if (isPlaying) {
                            return InkWell(
                              onTap: () {
                                lofibloc.add(PauseLofi(lofi));
                              },
                              child: Icon(
                                Icons.stop_circle_outlined,
                                color: Colors.white,
                                size: 44,
                              ),
                            );
                          } else {
                            return InkWell(
                              onTap: () {
                                if (state is LofiPlaying &&
                                    state.lofi != lofi) {
                                  print("Another Lofi Playing");
                                  lofibloc.add(StopLofi());
                                }
                                playlofi();
                              },
                              child: Icon(
                                Icons.play_circle_fill_outlined,
                                color: Colors.white,
                                size: 44,
                              ),
                            );
                          }
                        },
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
