extension type SemesterId(int id) implements Comparable {
  bool operator <(SemesterId other) => id < other.id;
  bool operator <=(SemesterId other) => id <= other.id;
  bool operator >(SemesterId other) => id > other.id;
  bool operator >=(SemesterId other) => id >= other.id;
}

extension type StudentId(String id) {}
extension type SessionId(int id) {}
extension type CourseClassId(int id) {}
