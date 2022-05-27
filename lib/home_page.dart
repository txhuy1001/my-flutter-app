import 'package:flutter/material.dart';
import 'package:my_app/constant/app_color.dart';

import 'constant/data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    return SafeArea(
        child: Container(
      color: AppColor.background,
      child: Column(
        children: [
          const SizedBox(height: 15,),
          getActiveUsersBar(),
          const SizedBox(height: 18),
          getFriendMessageList(),
        ],
      ),
    ));
  }

  Widget getFriendMessageList() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: List.generate(userMessages.length, (index) {
            return getAvatarWidgetWithRecentMessage(
                '${userMessages[index]['firstName']} ${userMessages[index]['lastName']}',
                userMessages[index]['avatarUrl'],
                userMessages[index]['message'],
                1);
          }),
        ),
      ),
    );
  }

  Widget getAvatarWidgetWithRecentMessage(String fullName,
      String avatarImageUrl, String recentMessage, int receivedTime) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16, left: 15, right: 16),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [

        Stack(
          children: [
            getAvatarWidget(avatarImageUrl),
            //Display unread messages on the avatar
            Positioned(
              bottom: 8,
              left: 55,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    color: AppColor.online,
                    shape: BoxShape.circle,
                    border: Border.all(width: 3, color: AppColor.onlineBorder)),
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.0, color: Color(0xFF000000)),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Display full name
                Text(
                  fullName,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 17),
                ),
                const SizedBox(
                  height: 4,
                ),
                //Display recent message
                Text(
                  recentMessage,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 17),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget getActiveUsersBar() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            children: List.generate(activeUsers.length, (index) {
              return getAvatarWidgetWithOnlineStatus(
                  activeUsers[index]['avatarUrl'],
                  activeUsers[index]['firstName']);
            }),
          ),
        ));
  }

  Widget getAvatarWidgetWithOnlineStatus(
      String avatarImageUrl, String userFirstName) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 0, right: 20, bottom: 18),
      child: Column(
        children: [
          //Display avatar with online status
          Stack(
            children: [
              getAvatarWidget(avatarImageUrl),
              //Display online indicator on the avatar
              Positioned(
                bottom: 1,
                left: 40,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: AppColor.online,
                      shape: BoxShape.circle,
                      border:
                          Border.all(width: 3, color: AppColor.onlineBorder)),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 9,
          ),

          //Display online user name
          SizedBox(
            width: 70,
            child: Text(
              userFirstName,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  Widget getAvatarWidget(String avatarImageUrl) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(avatarImageUrl),
            fit: BoxFit.cover,
          )),
    );
  }
}
