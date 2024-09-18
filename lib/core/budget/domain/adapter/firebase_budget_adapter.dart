import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linum/core/budget/domain/adapter/budget_adapter.dart';
import 'package:linum/core/budget/domain/models/budget.dart';
import 'package:linum/core/budget/domain/models/changes.dart';
import 'package:linum/core/budget/domain/models/main_budget.dart';
import 'package:logger/logger.dart';

class FirebaseBudgetAdapter extends IBudgetAdapter {
  final String _userId;

  FirebaseBudgetAdapter(this._userId);

  DocumentReference get _userDocument => FirebaseFirestore.instance.collection('users').doc(_userId);
  CollectionReference get _budgetCollection => _userDocument.collection('budgets');
  CollectionReference get _mainBudgetCollection => _userDocument.collection('main_budgets');

  final infiniteDate = DateTime.utc(9999, 12);

  @override
  Future<List<Budget>> getBudgetsForDate(DateTime date) async {
    final QuerySnapshot snapshot = await getSnapshot(_budgetCollection, date);
    final foundDocuments = snapshot.docs;
    if (foundDocuments.isNotEmpty) {
      final List<Budget> budgets = foundDocuments.map((element) {
        final data = element.data()! as Map<String, dynamic>;
        data['id'] = element.id;
        data['categories'] = (data['categories'] as List<dynamic>).cast<String>();
        return Budget.fromMap(data);
      }).toList();

      return budgets;
    }
    return [];
  }

  @override
  Future<MainBudget?> getMainBudgetForDate(DateTime date) async {
    final QuerySnapshot snapshot = await getSnapshot(_mainBudgetCollection, date);
    final foundDocuments = snapshot.docs;
    if (foundDocuments.isEmpty) {
      Logger().w("No main budget found for the given date ${date.toIso8601String()}");
    } else {
      final data = foundDocuments.first.data()! as Map<String, dynamic>;
      data['id'] = foundDocuments.first.id;
      return MainBudget.fromMap(data);
    }
    return Future.value();
  }

  Future<QuerySnapshot> getSnapshot(CollectionReference collectionReference, DateTime date) async {
    final DateTime trimmedDate = DateTime.utc(date.year, date.month);
    final String formattedDate = trimmedDate.toIso8601String();
    final QuerySnapshot snapshot = await collectionReference
        .where('start', isLessThanOrEqualTo: formattedDate)
        .where('end', isGreaterThanOrEqualTo: formattedDate)
        .get();
    return snapshot;
  }

  Future<bool> checkOverlappingBudget(CollectionReference collectionReference, DateTime start, DateTime? end,
      {String? id,}) async {
    bool result = false;
    final QuerySnapshot overlappingBudgetsSnapshot = await collectionReference
        .where('start', isLessThanOrEqualTo: end?.toIso8601String() ?? infiniteDate.toIso8601String())
        .where('end', isGreaterThanOrEqualTo: start.toIso8601String())
        .get();
    if (id != null) {
      result = overlappingBudgetsSnapshot.docs.any((element) {
          return element.id != id;
      },);
    } else {
      result = overlappingBudgetsSnapshot.docs.isNotEmpty;
    }
    return result;
  }

  @override
  Future<void> executeBudgetChanges(List<ModelChange<Budget>> changes) async {
    for(final change in changes){
      final Budget budget = change.model;
      final budgetDocRef = _budgetCollection.doc(budget.id);
      final budgetSnapshot = await budgetDocRef.get();
      switch(change.type){
        case ChangeType.create:
          if(budgetSnapshot.exists){
            Logger().w("Budget with id ${budget.id} does already exist");
            continue;
          }
          final Map<String, dynamic> budgetMap = budget.toMap();
          if(budget.end == null){
            budgetMap['end'] = infiniteDate.toIso8601String();
          }
          budgetMap.remove("id");
          await budgetDocRef.set(budgetMap);
        case ChangeType.update:
          if(!budgetSnapshot.exists){
            Logger().w("Budget with id ${budget.id} does not exist");
            continue;
          }
          final Map<String, dynamic> budgetMap = budget.toMap();
          if(budget.end == null){
            budgetMap['end'] = infiniteDate.toIso8601String();
          }
          budgetMap.remove("id");
          await budgetDocRef.set(budgetMap);
        case ChangeType.delete:
          if(!budgetSnapshot.exists){
            Logger().w("Budget with id ${budget.id} does not exist");
            continue;
          }
          await budgetDocRef.delete();
      }
    }
  }

  @override
  Future<void> executeMainBudgetChanges(List<ModelChange<MainBudget>> changes) async {
    for(final change in changes){
      final MainBudget mainBudget = change.model;
      final mainBudgetDocRef = _mainBudgetCollection.doc(mainBudget.id);
      final mainBudgetSnapshot = await mainBudgetDocRef.get();
      switch(change.type){
        case ChangeType.create:
          if(mainBudgetSnapshot.exists){
            Logger().w("Main budget with id ${mainBudget.id} does already exist");
            continue;
          }
          final Map<String, dynamic> budgetMap = mainBudget.toMap();
          if(mainBudget.end == null){
            budgetMap['end'] = infiniteDate.toIso8601String();
          }
          if(await checkOverlappingBudget(_mainBudgetCollection, mainBudget.start, mainBudget.end)) {
            Logger().i("Time span overlaps with an existing budget");
            continue;
          }
          budgetMap.remove("id");
          await mainBudgetDocRef.set(budgetMap);
        case ChangeType.update:
          if(!mainBudgetSnapshot.exists){
            Logger().w("Main budget with id ${mainBudget.id} does not exist");
            continue;
          }
          final Map<String, dynamic> budgetMap = mainBudget.toMap();
          if(mainBudget.end == null){
            budgetMap['end'] = infiniteDate.toIso8601String();
          }
          if(await checkOverlappingBudget(_mainBudgetCollection, mainBudget.start, mainBudget.end, id: mainBudget.id)) {
            Logger().i("Time span overlaps with an existing budget");
            continue;
          }
          budgetMap.remove("id");
          await mainBudgetDocRef.set(budgetMap);
        case ChangeType.delete:
          if(!mainBudgetSnapshot.exists){
            Logger().w("Main budget with id ${mainBudget.id} does not exist");
            continue;
          }
          await mainBudgetDocRef.delete();
      }
    }
  }

}
