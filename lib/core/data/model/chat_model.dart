import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:start_jwt/json_web_signature.dart';
import 'package:start_jwt/json_web_token.dart';
import 'package:stream_chat/stream_chat.dart';
import 'package:stream_chat_with_firebase/styles/constants.dart';

class ChatModel extends ChangeNotifier {
  Client _streamClient;
  String _channelName;
  Channel _currentChannel;


  String get channelName => _channelName;

  set channelName(String value) {
    _channelName = value;
    notifyListeners();
  }


  set currentChannel(Channel value) {
    _currentChannel = value;
    streamClient.channel(_currentChannel.id);
    notifyListeners();
  }

  ChatModel() {
    _streamClient = Client(STREAM_API_KEY,
        logLevel: Level.SEVERE, tokenProvider: tokenProvider);
  }

  Client get streamClient => _streamClient;

  /// Use the start_jwt package to create a json web token, by sending the STREAM_API_SECRET and generating a token using that secret, and specify a user id field
  Future<String> tokenProvider(String id) async {
    final JsonWebTokenCodec jwt = JsonWebTokenCodec(secret: STREAM_API_SECRET);

    final payload = {
      'user_id': id,
    };
    return jwt.encode(payload);
  }

//   List<Widget> createListOfChannels(List<Channel> channels, context) {
//
//     final provider = Provider.of<ChatModel>(context);
//
//     return channels.map((chan) => {
//       ListTile(
//         subtitle: Text("Last Message at: ${chan.lastMessageAt}"),
//
//         title: Text(
//           "Channel Title: ${chan.cid.replaceFirstMapped("mobile", (match) => "") }
//         ),
//       ),
//     }).toList();
//
//   }
//
}