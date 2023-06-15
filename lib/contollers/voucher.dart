import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/contollers/voucher_event.dart';
import 'package:shopping_app/contollers/voucher_state.dart';
import '../firebase/voucher_firebase.dart';

class VoucherBloc extends Bloc<VoucherEvent, VoucherState> {
  final VoucherRepository _voucherRepository;
  StreamSubscription? _voucherSubscription;

  VoucherBloc({required VoucherRepository voucherRepository})
      : _voucherRepository = voucherRepository,
        super(VoucherLoading()) {
    on<LoadVouchers>(_onLoadVouchers);
    on<UpdateVouchers>(_onUpdateVouchers);
    on<SelectVoucher>(_onSelectVoucher);
  }

  void _onLoadVouchers(
      LoadVouchers event,
      Emitter<VoucherState> emit,
      ) {
    _voucherSubscription?.cancel();
    _voucherSubscription = _voucherRepository.getVouchers().listen(
          (vouchers) => add(
        UpdateVouchers(vouchers: vouchers),
      ),
    );
  }

  void _onUpdateVouchers(
      UpdateVouchers event,
      Emitter<VoucherState> emit,
      ) {
    emit(
      VoucherLoaded(vouchers: event.vouchers),
    );
  }

  void _onSelectVoucher(
      SelectVoucher event,
      Emitter<VoucherState> emit,
      ) {
    emit(
      VoucherSelected(voucher: event.voucher),
    );
  }
}
