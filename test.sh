#!/bin/sh

flutter test --coverage
flutter pub run remove_from_coverage -f coverage/lcov.info -r '.gr|.g\.dart$'