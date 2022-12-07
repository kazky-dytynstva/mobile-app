import 'package:equatable/equatable.dart';
import 'package:mobile_app/domain/model/rating/rating_type.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';

const minNumberOfRatingsToShow = 5;

class RatingData extends Equatable {
  final RatingType type;
  final IntPositive numberOfRatings;
  final double avg;

  const RatingData(
    this.type,
    this.numberOfRatings,
    this.avg,
  ) : assert(avg > 0 && avg <= 5);

  @override
  List<Object> get props => [
        type,
        numberOfRatings,
        avg,
      ];

  int get roundedNumber {
    final number = numberOfRatings.get();
    if (number < 10) {
      return 5;
    } else if (number < 25) {
      return 10;
    } else if (number < 50) {
      return 25;
    } else if (number < 100) {
      return 50;
    } else if (number < 300) {
      return 100;
    } else {
      return 300;
    }
  }
}
