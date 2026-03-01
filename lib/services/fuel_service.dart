class FuelService {
  FuelService._();

  static double fuelNeeded({required double distanceKm, required double mileageKmPerL}) {
    if (mileageKmPerL <= 0) return 0;
    return distanceKm / mileageKmPerL;
  }

  static double totalCost({required double distanceKm, required double mileageKmPerL, required double pricePerL}) {
    final fuel = fuelNeeded(distanceKm: distanceKm, mileageKmPerL: mileageKmPerL);
    return fuel * pricePerL;
  }
}
