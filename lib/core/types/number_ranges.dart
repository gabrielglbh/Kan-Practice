enum Ranges { from0to1K, from1Kto10K, from10Kto100K, from100Kto1M }

extension RangesExt on Ranges {
  String get label {
    switch (this) {
      case Ranges.from0to1K:
        return "0 - 1.000";
      case Ranges.from1Kto10K:
        return "1.000 - 10.000";
      case Ranges.from10Kto100K:
        return "10.000 - 100.000";
      case Ranges.from100Kto1M:
        return "100.000 - 1.000.000";
    }
  }

  int get min {
    switch (this) {
      case Ranges.from0to1K:
        return 0;
      case Ranges.from1Kto10K:
        return 1000;
      case Ranges.from10Kto100K:
        return 10000;
      case Ranges.from100Kto1M:
        return 100000;
    }
  }

  int get max {
    switch (this) {
      case Ranges.from0to1K:
        return 1000;
      case Ranges.from1Kto10K:
        return 10000;
      case Ranges.from10Kto100K:
        return 100000;
      case Ranges.from100Kto1M:
        return 1000000;
    }
  }
}