extension AppObjectExtensions on Object? {
  T? tryCast<T>({T? defaultValue}) => this is T ? this as T : defaultValue;
}
