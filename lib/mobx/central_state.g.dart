// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'central_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$CentralState on CentralStateBase, Store {
  final _$flagAtom = Atom(name: 'CentralStateBase.flag');

  @override
  bool get flag {
    _$flagAtom.context.enforceReadPolicy(_$flagAtom);
    _$flagAtom.reportObserved();
    return super.flag;
  }

  @override
  set flag(bool value) {
    _$flagAtom.context.conditionallyRunInAction(() {
      super.flag = value;
      _$flagAtom.reportChanged();
    }, _$flagAtom, name: '${_$flagAtom.name}_set');
  }
}
