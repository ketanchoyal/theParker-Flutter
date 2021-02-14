import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'locator.config.dart';

final locator = GetIt.instance;

///[Run this to generate locator Code][Run everytime a new service is registered (using lazy or singleton or whatever)] flutter pub run build_runner build --delete-conflicting-outputs
@injectableInit
void setupLocator() => $initGetIt(locator);
