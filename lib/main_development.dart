// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:price_tracker/app/app.dart';
import 'package:price_tracker/bootstrap.dart';
import 'package:price_tracker/data/repository/tracker_repository_impl.dart';

void main() {
  bootstrap(
    () => App(
      trackerRepository: TrackerRepositoryImpl(),
    ),
  );
}
