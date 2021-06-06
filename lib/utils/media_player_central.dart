import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:lofi/data/models/lofi.dart';

void updateNotificationMediaPlayer(bool isPlaying, Lofi lofi) {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: lofi.id,
      channelKey: 'media_player',
      title: lofi.title,
      body: lofi.artist,
      summary: isPlaying ? 'Now playing' : '',
      largeIcon: 'asset://' + lofi.imageUrl,
      bigPicture: lofi.getImageUrl,
      autoCancel: false,
      hideLargeIconOnExpand: true,
      notificationLayout: NotificationLayout.MediaPlayer,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'MEDIA_PREV',
        icon: 'resource://drawable/res_ic_prev',
        label: 'Previous',
        autoCancel: false,
        enabled: true,
        buttonType: ActionButtonType.KeepOnTop,
      ),
      isPlaying
          ? NotificationActionButton(
              key: 'MEDIA_PAUSE',
              icon: 'resource://drawable/res_ic_pause',
              label: 'Pause',
              autoCancel: false,
              buttonType: ActionButtonType.KeepOnTop)
          : NotificationActionButton(
              key: 'MEDIA_PLAY',
              icon: 'resource://drawable/res_ic_play',
              label: 'Play',
              autoCancel: false,
              // enabled: MediaPlayerCentral.hasAnyMedia,
              buttonType: ActionButtonType.KeepOnTop),
      NotificationActionButton(
          key: 'MEDIA_NEXT',
          icon: 'resource://drawable/res_ic_next',
          label: 'Next',
          autoCancel: false,
          // enabled: MediaPlayerCentral.hasNextMedia,
          buttonType: ActionButtonType.KeepOnTop),
      NotificationActionButton(
          key: 'MEDIA_CLOSE',
          icon: 'resource://drawable/res_ic_close',
          label: 'Close',
          autoCancel: isPlaying ? false : true,
          buttonType: ActionButtonType.KeepOnTop),
    ],
  );
}

void cancelNotification() {
  AwesomeNotifications().cancelAll();
}
