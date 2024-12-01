import 'package:naturemedix/utils/_initApp.dart';

class UserFeedback {
  final String name;
  final String avatar;
  final double rating;
  final String feedback;
  final DateTime date;

  UserFeedback(this.name, this.avatar, this.rating, this.feedback, this.date);
}

List<UserFeedback> feedbackList = [
  UserFeedback('Alice', Application().image.BG1, 5,
      'This remedy works wonders! Highly recommend it.', DateTime(2023, 6, 18)),
  UserFeedback(
      'Bob',
      Application().image.BG1,
      4,
      'Very effective, but it took some time to see results.',
      DateTime(2023, 7, 5)),
  UserFeedback('Charlie', Application().image.BG1, 3,
      'It was okay, but not as effective as I hoped.', DateTime(2023, 8, 15)),
  UserFeedback(
      'Diana',
      Application().image.BG1,
      1,
      'Not effective for me. I tried it multiple times.',
      DateTime(2023, 9, 10)),
  UserFeedback(
      'Ethan',
      Application().image.BG1,
      2,
      'Mildly helpful, but side effects were an issue.',
      DateTime(2023, 10, 22)),
  UserFeedback('Fiona', Application().image.BG1, 5,
      'Absolutely love it! My go-to remedy now.', DateTime(2023, 11, 3)),
  UserFeedback('George', Application().image.BG1, 3,
      'Works decently, but requires consistent use.', DateTime(2023, 11, 15)),
  UserFeedback('Hannah', Application().image.BG1, 4,
      'Great remedy! Easy to prepare and effective.', DateTime(2023, 11, 28)),
];
