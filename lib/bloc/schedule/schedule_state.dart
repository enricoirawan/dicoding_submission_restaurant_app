part of 'schedule_cubit.dart';

class ScheduleState extends Equatable {
  final bool isScheduled;

  const ScheduleState({
    required this.isScheduled,
  });

  factory ScheduleState.initial() {
    return const ScheduleState(
      isScheduled: false,
    );
  }

  ScheduleState copyWith({
    bool? isScheduled,
  }) {
    return ScheduleState(
      isScheduled: isScheduled ?? this.isScheduled,
    );
  }

  @override
  List<Object> get props => [isScheduled];

  Map<String, dynamic> toMap() {
    return {
      'isScheduled': isScheduled,
    };
  }

  factory ScheduleState.fromMap(Map<String, dynamic> map) {
    return ScheduleState(
      isScheduled: map['isScheduled'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ScheduleState.fromJson(String source) =>
      ScheduleState.fromMap(json.decode(source));

  @override
  String toString() => 'ScheduleState(isScheduled: $isScheduled)';
}
