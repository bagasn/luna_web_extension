enum NavigationPaths {
  home(path: '/app', navigationPath: '/app');

  final String path;
  final String navigationPath;

  const NavigationPaths({required this.path, required this.navigationPath});
}
