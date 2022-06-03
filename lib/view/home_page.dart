import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_app/constant/app_assets.dart';
import 'package:my_app/constant/app_color.dart';
import 'package:my_app/constant/app_style.dart';
import 'package:my_app/service/user_service.dart';

import '../entity/chat.dart';
import '../entity/user.dart';

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

  GetIt getIt = GetIt.instance;
  List<User> users = List.empty();
  List<Chat> chats = List.empty();

  @override
  void initState() {
    super.initState();

    getIt.registerSingleton<UserService>(UserService(), signalsReady: true);

    getIt<UserService>().loadData().whenComplete(() {
      setState(() {
        users = getIt<UserService>().users;
        chats = getIt<UserService>().chats;
        debugPrint(chats.length.toString());
      });
    });
  }

  Widget getBody() {
    return SafeArea(
        child: Container(
      color: AppColor.background,
      child: Column(
        children: [
          getTopBarNavigator(),
          getPageTitle(),
          getActiveUsersBar(),
          const SizedBox(height: 18),
          getFriendMessageList(),
          getBottomBar()
        ],
      ),
    ));
  }

  Widget getTopBarNavigator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {},
          child: const Icon(
            Icons.arrow_back,
            color: AppColor.defaultTextColor,
            size: 28,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Icon(
            Icons.add,
            color: AppColor.defaultTextColor,
            size: 38,
          ),
        ),
      ],
    );
  }

  Widget getPageTitle() {
    return Container(
      padding: const EdgeInsets.only(left: 15, bottom: 24),
      child: const Text('Messages',
          textAlign: TextAlign.left, style: AppTextStyle.textPageTitle),
    );
  }

  Widget getFriendMessageList() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 1.0, color: Color(0xFF000000)),
            ),
          ),
          child: Column(
            children: List.generate(chats.length, (index) {
              return getAvatarWidgetWithRecentMessage(
                  chats[index].user!.name!,
                  chats[index].user!.picture!.thumbnail!,
                  chats[index].text!,
                  chats[index].createdAt!,
                  chats[index].unreadCount!);
            }),
          ),
        ),
      ),
    );
  }

  Widget getAvatarWidgetWithRecentMessage(
      String fullName,
      String avatarImageUrl,
      String recentMessage,
      String receivedTime,
      int unreadMessageCount) {
    return Container(
      padding: const EdgeInsets.only(left: 15),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Stack(
          children: [
            getAvatarWidget(avatarImageUrl),
            //Display unread messages on the avatar
            unreadMessageCount > 0
                ? Positioned(
                    bottom: 0,
                    left: 38,
                    child: Container(
                      width: 22,
                      height: 22,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColor.online,
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 1, color: AppColor.onlineBorder)),
                      child: Text(
                        unreadMessageCount.toString(),
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(
            height: 92,
            decoration: const BoxDecoration(
              border: Border(
                // left: BorderSide(width: 1.0, color: Color(0xFF000000)),
                // right: BorderSide(width: 1.0, color: Color(0xFF000000)),
                // top: BorderSide(width: 1.0, color: Color(0xFF000000)),
                bottom: BorderSide(width: 1.0, color: Color(0xFF000000)),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.only(top: 16, bottom: 16, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Display full name and message received time
                  Row(
                    children: [
                      //Display full name
                      Expanded(
                        child: Text(
                          fullName,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.textFriendFullName,
                        ),
                      ),
                      //Display received time
                      Text(
                        AppTextStyle.messageReceivedTime
                            .format(DateTime.parse(receivedTime)),
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.textReceivedTime,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  //Display recent message
                  Text(
                    recentMessage,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.textRecentMessage,
                  ),
                ],
              ),
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
            children: List.generate(users.length, (index) {
              return getAvatarWidgetWithOnlineStatus(
                  users[index].picture!.thumbnail!,
                  users[index].name!.split(" ")[0]);
            }),
          ),
        ));
  }

  Widget getAvatarWidgetWithOnlineStatus(
      String avatarImageUrl, String userFirstName) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 20),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
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
                  width: 18,
                  height: 18,
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
            child: Text(userFirstName,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.textOnlineUser),
          )
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
            image: NetworkImage(avatarImageUrl),
            fit: BoxFit.cover,
          )),
    );
  }

  Widget getAppBar() {
    return AppBar(
      backgroundColor: AppColor.background,
      title: const Text('Messages',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 34,
          )),
    );
  }

  Widget getBottomBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AppAssets.homeIcon)), label: 'Home'),
        BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AppAssets.streamsIcon)),
            label: 'Streams'),
        BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AppAssets.messagesIcon)),
            label: 'Messages'),
        BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AppAssets.notificationsIcon)),
            label: 'Notifications'),
        BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AppAssets.profilesIcon)),
            label: 'Profiles'),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: 2,
      iconSize: 30,
      backgroundColor: AppColor.background,
      unselectedItemColor: AppColor.unfocusedIconColor,
      selectedItemColor: AppColor.focusedIconColor,
    );
  }
}
