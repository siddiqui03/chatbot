// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Home> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];
  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser chatbotUser = ChatUser(
    id: "1",
    firstName: "Zozo",
    profileImage: "assets/images/chatbot.png",
  );

  @override
  void initState() {
    super.initState();
    _sendIntroductionMessage();
  }

  void _sendIntroductionMessage() {
    final introductionMessage = ChatMessage(
      user: chatbotUser,
      createdAt: DateTime.now(),
      text: "Hello! My name is Zozo. How can I assist you today?",
    );
    setState(() {
      messages = [introductionMessage, ...messages];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "ZOZO",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple[400],
        iconTheme: const IconThemeData(
          color: Colors.white, // Back button color
        ),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return DashChat(
      inputOptions: InputOptions(
        trailing: [
          IconButton(
            onPressed: _sendMedia,
            icon: const Icon(
              Icons.image,
              color: Colors.deepPurple, // Image icon color
            ),
          ),
        ],
      ),
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });

    try {
      String question = chatMessage.text.trim();

      if (question.isEmpty ||
          question == "ok" ||
          question == "no" ||
          question == "okay" ||
          question == "okie") {
        ChatMessage message = ChatMessage(
          user: chatbotUser,
          createdAt: DateTime.now(),
          text: "Alright, let me know if you need anything else!",
        );
        setState(() {
          messages = [message, ...messages];
        });
        return;
      }

      List<Uint8List>? images;
      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [
          File(chatMessage.medias!.first.url).readAsBytesSync(),
        ];
      }

      gemini
          .streamGenerateContent(
        question,
        images: images,
      )
          .listen((event) {
        // Combine the response parts into a single string with spaces between them
        String response =
            event.content?.parts?.map((part) => part.text).join(' ') ?? "";

        // Ensure no multiple spaces and add a space after punctuation
        response = response.replaceAll(
            RegExp(r'\s+'), ' '); // Replace multiple spaces with a single space
        response = response.replaceAllMapped(RegExp(r'([.,!?])(\w)'),
            (match) => '${match.group(1)} ${match.group(2)}');

        print("Generated Response: $response");

        // Fallback for invalid or too short responses or if it repeats the question
        if (response.length <= 1 ||
            response.contains(RegExp(r'^\?@W+$')) ||
            response.toLowerCase() == question.toLowerCase()) {
          response = "Could you please clarify that?";
        }

        // Check for repetitive or irrelevant responses
        if (response == question) {
          response = "I'm here to assist. Can you please rephrase that?";
        }

        // Avoid duplicating the previous chatbot message
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == chatbotUser) {
          lastMessage = messages.removeAt(0);
          lastMessage.text += " " + response;
          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          ChatMessage message = ChatMessage(
            user: chatbotUser,
            createdAt: DateTime.now(),
            text: response,
          );
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void _sendMedia() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
        user: currentUser,
        createdAt: DateTime.now(),
        text: "Describe this image",
        medias: [
          ChatMedia(
            url: file.path,
            fileName: "",
            type: MediaType.image,
          )
        ],
      );
      _sendMessage(chatMessage);
    }
  }
}
