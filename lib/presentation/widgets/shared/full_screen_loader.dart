import 'package:flutter/material.dart';

const defaultLoadingMessagesList = <String>[
  '🔌 Setting up some wires...',
  'Putting the popcorn in the micro 🍿',
  'Those pops sound pretty good, while waiting, want a drink? 🥤',
  '🎬 We\'re almost ready',
];

class FullScreenLoader extends StatelessWidget {
  /// A list of messages to show while loading
  final List<String> loadingMessagesList;

  /// Because the messages use a stream, the first message is shown twice if [ignoreFirstMessage] = false
  final bool ignoreFirstMessage;

  /// Change the order to show the given messages, doesn't modify the original list
  // final bool shuffleMessages;

  const FullScreenLoader({
    super.key,
    this.loadingMessagesList = defaultLoadingMessagesList,
    this.ignoreFirstMessage = true,
  }) : assert(loadingMessagesList.length > 0);

  Stream<String> getLoadingMessagesStream({
    Duration stepDuration = const Duration(milliseconds: 3000),
  }) {
    final bool onlyOneMessage = loadingMessagesList.length == 1;

    if ((ignoreFirstMessage && !onlyOneMessage) || onlyOneMessage) {
      return Stream.periodic(
        stepDuration,
        (index) => loadingMessagesList[index + 1],
      ).take(loadingMessagesList.length - 1);
    } else {
      return Stream.periodic(
        stepDuration,
        (index) => loadingMessagesList[index],
      ).take(loadingMessagesList.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            strokeWidth: 2,
          ),
          const SizedBox(
            height: 12,
          ),
          // Text('Loading...'),
          SizedBox(
            width: 200,
            child: StreamBuilder(
              stream: getLoadingMessagesStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text(
                    loadingMessagesList[0],
                    textAlign: TextAlign.center,
                  );
                }
                return Text(
                  snapshot.data!,
                  textAlign: TextAlign.center,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
