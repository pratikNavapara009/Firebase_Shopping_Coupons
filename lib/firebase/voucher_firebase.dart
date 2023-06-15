import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/firebase/voucher_helper.dart';
import '../models/firebase_vouchers.dart';


class VoucherRepository extends BaseVoucherRepository {
  final FirebaseFirestore _firebaseFirestore;

  VoucherRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Voucher>> getVouchers() {
    return FirebaseFirestore.instance
        .collection('vouchers')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Voucher.fromSnapshot(doc)).toList();
    });
  }

  @override
  Future<bool> searchVoucher(String code) async {
    final voucher = await _firebaseFirestore
        .collection('vouchers')
        .where('code', isEqualTo: code)
        .get();

    return voucher.docs.length > 0;
  }
}