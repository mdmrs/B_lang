পুন প্রধান() {
পুন ক = ৫, খ = ১০;
দশমি ফলাফল;

// যোগফল
ফলাফল = ক + খ;
ছাপাও("যোগফল: %দ\ন", ফলাফল);

// বিয়োগ
ফলাফল = খ - ক;
ছাপাও("বিয়োগ: %দ\ন", ফলাফল);

// গুণ
ফলাফল = ক * খ;
ছাপাও("গুণ: %দ\ন", ফলাফল);

// ভাগফল
ফলাফল = (দশমি)খ / ক;
ছাপাও("ভাগফল: %দ\ন", ফলাফল);

// যৌক্তিক অপারেটর
যদি (ক < খ && ক != ০) {
ছাপাও("ক খ থেকে ছোট এবং শূন্য নয়\ন");
} বাযদি (ক > খ || ক == ০) {
ছাপাও("ক খ থেকে বড় বা শূন্য\ন");
} নয়তো {
ছাপাও("শর্ত পূরণ হয়নি\ন");
}

// লুপ
পুন ই = ০;
কর {
ছাপাও("ই = %প\ন", ই);
ই++;
} যখন (ই < ৫);

বারবার (পুন জ = ০; জ < ৩; জ++) {
ছাপাও("জ = %প\ন", জ);
}

ফেরত ০;
}