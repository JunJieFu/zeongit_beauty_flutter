class StringUtil {
  static String enumToString(object) {
    return object
        .toString()
        .split('.')
        .last;
  }

  static bool equalsEnum(String enumValue, object) {
    return StringUtil.enumToString(object) == enumValue;
  }
}