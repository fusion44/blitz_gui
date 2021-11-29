import 'package:authentication/authentication.dart';
import 'package:bloc/bloc.dart';
import 'package:common/common.dart';
import 'package:meta/meta.dart';

part 'wallet_locked_checker_event.dart';
part 'wallet_locked_checker_state.dart';

class WalletLockedCheckerBloc
    extends Bloc<WalletLockedCheckerEvent, WalletLockedCheckerState> {
  final AuthRepo _authRepo;

  WalletLockedCheckerBloc(this._authRepo)
      : super(WalletLockedCheckerInitial()) {
    on<CheckWalletLocked>((event, emit) async {
      bool locked = true;
      emit(WalletUnlocked());
      while (locked) {
        final stillLocked = await _checkLocked();
        if (stillLocked) {
          await Future.delayed(const Duration(seconds: 5));
          emit(WalletLocked());
        } else {
          emit(WalletUnlocked());
        }
        locked = stillLocked;
      }
    });
  }

  Future<bool> _checkLocked() async {
    final url = '${_authRepo.baseUrl()}/latest/lightning/get-info';
    try {
      final response = await fetch(Uri.parse(url), _authRepo.token());
      if (response.statusCode == 200) {
        return false;
      } else if (response.statusCode == 401 || response.statusCode == 423) {
        return true;
      } else {
        BlitzLog().w('Received unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      BlitzLog().e(e);
    }
    return true;
  }
}
