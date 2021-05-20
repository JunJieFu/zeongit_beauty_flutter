class CustomRefreshController {
  void Function()? refresh;

  void dispose() {
    refresh = null;
  }
}
