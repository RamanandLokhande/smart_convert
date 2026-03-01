class BMIService {
  static double calculateBMI(double heightCm, double weightKg) {
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  static String getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi < 25) {
      return 'Normal';
    } else if (bmi < 30) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  static String getBMIAdvice(double bmi) {
    if (bmi < 18.5) {
      return 'Consider eating more nutritious foods and consulting a doctor.';
    } else if (bmi < 25) {
      return 'Great! You are in a healthy weight range. Keep it up!';
    } else if (bmi < 30) {
      return 'Consider increasing physical activity and a balanced diet.';
    } else {
      return 'Consult with a healthcare professional for guidance.';
    }
  }

  static double getHealthScore(double bmi) {
    if (bmi < 18.5) {
      return 0.6;
    } else if (bmi < 25) {
      return 1.0;
    } else if (bmi < 30) {
      return 0.7;
    } else {
      return 0.4;
    }
  }
}
