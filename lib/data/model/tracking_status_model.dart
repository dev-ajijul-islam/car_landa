class TrackingStatusModel {
  final String title;
  final String subtitle;
  final int iconCodePoint;
  final bool isPast;
  final bool isCurrent;
  final bool isUpcoming;
  final bool isFirst;
  final bool isLast;

  TrackingStatusModel({
    required this.title,
    required this.subtitle,
    required this.iconCodePoint,
    this.isPast = false,
    this.isCurrent = false,
    this.isUpcoming = false,
    this.isFirst = false,
    this.isLast = false,
  });

  factory TrackingStatusModel.fromJson(Map<String, dynamic> json) {
    return TrackingStatusModel(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      iconCodePoint: json['iconCodePoint'] ?? 58344,
      isPast: json['isPast'] ?? false,
      isCurrent: json['isCurrent'] ?? false,
      isUpcoming: json['isUpcoming'] ?? false,
      isFirst: json['isFirst'] ?? false,
      isLast: json['isLast'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'iconCodePoint': iconCodePoint,
      'isPast': isPast,
      'isCurrent': isCurrent,
      'isUpcoming': isUpcoming,
      'isFirst': isFirst,
      'isLast': isLast,
    };
  }
}
