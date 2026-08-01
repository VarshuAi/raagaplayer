import 'dart:async';
import '../../../music/domain/entities/recommendation.dart';

abstract class RecommendationEvent {}

class RecommendationsUpdatedEvent extends RecommendationEvent {
  final List<Recommendation> recommendations;
  RecommendationsUpdatedEvent(this.recommendations);
}

class RecommendationEvents {
  static final _controller = StreamController<RecommendationEvent>.broadcast();
  static Stream<RecommendationEvent> get stream => _controller.stream;
  static void emit(RecommendationEvent event) => _controller.add(event);
}
