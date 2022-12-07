import 'package:equatable/equatable.dart';

const String _keyAmount = 'amount';
const String _keyAvg = 'avg';

class RatingEntity extends Equatable {
  final int amount;
  final double avg;

  RatingEntity(Map<String, dynamic> map)
      : amount = map[_keyAmount] as int,
        avg = map[_keyAvg] as double;

  const RatingEntity.create({
    required this.amount,
    required this.avg,
  });

  Map<String, dynamic> toMap() => {
        _keyAmount: amount,
        _keyAvg: avg,
      };

  @override
  List<Object> get props => [
        amount,
        avg,
      ];
}
