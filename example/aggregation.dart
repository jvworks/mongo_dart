import 'package:mongo_dart/mongo_dart.dart';

main() async {
  final db = Db('mongodb://127.0.0.1/testdb');
  final pipeline = AggregationPipelineBuilder()
    .addStage(
      Match(where.eq('status', 'A').map['\$query']))
    .addStage(
      Group(
        id: Field('cust_id'),
        fields: {
          'total': Sum(Field('amount'))
        }
      )).build();
  final result =
    await DbCollection(db, 'orders')
      .aggregateToStream(pipeline).toList();
  result.forEach(print);
}