// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_achievments/core/enums/message_type.dart';
import 'package:flutter_achievments/features/app/presentation/provider/user_provider.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/message.dart';
import 'package:flutter_achievments/features/task/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:flutter_achievments/features/task/presentation/bloc/chat_bloc/chat_state.dart';
import 'package:flutter_achievments/features/task/presentation/provider/chat_bloc_provider.dart';
import 'package:flutter_achievments/features/task/presentation/provider/chat_messages_provider.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/chat/loading_message_card.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/chat/my_message_card.dart';
import 'package:flutter_achievments/features/task/presentation/widgets/chat/sender_message_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChatMessages extends StatefulWidget {
  const ChatMessages({
    super.key,
    required this.taskId,
  });
  final String taskId;
  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  late final ScrollController messageContoller;
  late ChatBloc _chatBloc;
  StreamSubscription<ChatMessagesLoaded>? messageSubscription;
  
  bool isLoaded = false;
  List<MessageEntity> messages = [];

  @override
  void initState() {
    super.initState();
    messageContoller = ScrollController();
    _chatBloc = Provider.of<ChatBlocProvider>(context, listen: false).chatBloc!;
  }

  @override
  void dispose() {
    messageContoller.dispose();
    messageSubscription?.cancel();
    super.dispose();
  }

  void onMessageSwipe(
    String message,
    bool isMe,
    MessageEnum messageEnum,
  ) {
    //   ref
    //       .read(messageReplyProvider.notifier)
    //       .update((state) => MessageReply(message, isMe, messageEnum));
  }
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      messageContoller.jumpTo(messageContoller.position.maxScrollExtent);
    });
    getMessages();

    if (!isLoaded) {
      messages = generateSampleMessages(context);
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      controller: messageContoller,
      itemCount: messages.length,
      physics: isLoaded
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (!isLoaded) {
          return const LoadingMessageCards();
        }

        final messageContent = messages[index];
        var timeSent = DateFormat.Hm().format(messageContent.timeSent);

        // if (!messageContent.isSeen &&
        //     messageContent.recieverid ==
        //         FirebaseAuth.instance.currentUser!.uid) {
        //   ref.read(chatControllerProvider).setChatMessageSeen(
        //       context, widget.recieverUserId, messageContent.messageId);
        // }
        if (messageContent.senderId ==
            Provider.of<UserProvider>(context).currentUser!.id) {
          return MyMessageCard(
            message: messageContent.text,
            date: timeSent,
            type: messageContent.type,
            repliesText: messageContent.repliedMessage,
            userName: messageContent.repliedTo,
            repliedMessageType: messageContent.repliedMessageType,
            onLeftSwipe: (() =>
                onMessageSwipe(messageContent.text, true, messageContent.type)),
            isSeen: messageContent.isSeen,
          );
        }
        return SenderMessageCard(
          message: messageContent.text,
          date: timeSent,
          type: messageContent.type,
          userName: messageContent.repliedTo,
          repliedMessageType: messageContent.repliedMessageType,
          repliesText: messageContent.repliedMessage,
          onRightSwipe: () =>
              onMessageSwipe(messageContent.text, false, messageContent.type),
        );
      },
    );
  }

  void getMessages() {
    final messagesFromCache =
        Provider.of<ChatMessagesProvider>(context, listen: true)
            .getMessages(widget.taskId);
    if (messagesFromCache == null) {
      _chatBloc.getMessagesSink.add(widget.taskId);
      initSubs();
    } else {
      messages = messagesFromCache;
      if (isLoaded == false) {
        setState(() {
          isLoaded = true;
        });
      }
    }
  }

  void initSubs() {
    

    messageSubscription = _chatBloc.messageLoadedStream.listen((event) {
      Provider.of<ChatMessagesProvider>(context, listen: false)
          .reInitMessage(event.messages, widget.taskId);
      if (event.messages.isNotEmpty) {
        messages = event.messages;
      }
      setState(() {
        isLoaded = true;
      });
    });
  }

  List<MessageEntity> generateSampleMessages(context) {
    final String currentUserId =
        Provider.of<UserProvider>(context).currentUser!.id;
    // return [];
    return [
      for (int i = 0; i < 20; i++)
        MessageEntity(
            senderId: currentUserId,
            recieverId: 'user2',
            text: 'Hello, how are you doing?',
            type: MessageEnum.text,
            timeSent: DateTime.now(),
            messageId: 'msg1',
            repliedMessage: '',
            repliedTo: '',
            repliedMessageType: MessageEnum.text,
            taskStateMessageType: TaskStateMessageType.plain,
            isSeen: false),
    ];
  }
}
