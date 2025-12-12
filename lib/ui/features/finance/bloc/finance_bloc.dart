import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/models/financial_record.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../domain/usecases/finance/get_financial_data_usecase.dart';
import '../../../../domain/usecases/finance/add_financial_record_usecase.dart';
import '../../../../domain/usecases/finance/delete_financial_record_usecase.dart';

part 'finance_event.dart';
part 'finance_state.dart';

class FinanceBloc extends Bloc<FinanceEvent, FinanceState> {
  final GetFinancialDataUseCase getFinancialDataUseCase;
  final AddFinancialRecordUseCase addFinancialRecordUseCase;
  final DeleteFinancialRecordUseCase deleteFinancialRecordUseCase;

  FinanceBloc({
    GetFinancialDataUseCase? getFinancialDataUseCase,
    AddFinancialRecordUseCase? addFinancialRecordUseCase,
    DeleteFinancialRecordUseCase? deleteFinancialRecordUseCase,
  })  : getFinancialDataUseCase = getFinancialDataUseCase ?? getIt<GetFinancialDataUseCase>(),
        addFinancialRecordUseCase = addFinancialRecordUseCase ?? getIt<AddFinancialRecordUseCase>(),
        deleteFinancialRecordUseCase = deleteFinancialRecordUseCase ?? getIt<DeleteFinancialRecordUseCase>(),
        super(FinanceInitial()) {
    on<LoadFinanceData>(_onLoadFinanceData);
    on<ChangePeriod>(_onChangePeriod);
    on<AddFinancialRecord>(_onAddFinancialRecord);
    on<DeleteFinancialRecord>(_onDeleteFinancialRecord);
  }

  void _onLoadFinanceData(LoadFinanceData event, Emitter<FinanceState> emit) async {
    emit(FinanceLoading());
    
    final result = await getFinancialDataUseCase();
    
    result.fold(
      (failure) => emit(FinanceError(failure.message)),
      (financialData) => emit(FinanceLoaded(
        financialData: financialData,
        selectedPeriod: 'month',
      )),
    );
  }

  void _onChangePeriod(ChangePeriod event, Emitter<FinanceState> emit) {
    if (state is FinanceLoaded) {
      final currentState = state as FinanceLoaded;
      emit(FinanceLoaded(
        financialData: currentState.financialData,
        selectedPeriod: event.period,
      ));
    }
  }

  void _onAddFinancialRecord(AddFinancialRecord event, Emitter<FinanceState> emit) async {
    final result = await addFinancialRecordUseCase(event.record);
    
    result.fold(
      (failure) => emit(FinanceError(failure.message)),
      (_) => add(LoadFinanceData()),
    );
  }

  void _onDeleteFinancialRecord(DeleteFinancialRecord event, Emitter<FinanceState> emit) async {
    final result = await deleteFinancialRecordUseCase(event.recordId);
    
    result.fold(
      (failure) => emit(FinanceError(failure.message)),
      (_) => add(LoadFinanceData()),
    );
  }
}





