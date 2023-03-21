import 'package:news_app/models/CategoryModel.dart';

List<CategoryModel> getCategories(){
  List<CategoryModel> list = [];
  for(int i=0;i<7;i++) {
    list.add(CategoryModel(names[i],urls[i]));
  }
  return list;
}