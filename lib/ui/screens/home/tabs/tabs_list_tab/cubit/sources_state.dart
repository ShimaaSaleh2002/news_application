import 'package:news_app/data/models/source.dart';

abstract class SourcesState{}

class SourceLoadingState extends SourcesState{

}
class SourceErrorState extends SourcesState{
  String errorMessage;
  SourceErrorState({required this.errorMessage});

}
class SourceSuccessState extends SourcesState{
  List<Source> sourcesList;
  SourceSuccessState({required this.sourcesList});
}