import 'package:mcr/logic/date_formatter.dart';

double goalCalculator(
    userGender, userWeight, userHeight, userAge, userActivity, userGoal) {
  double calBMR;
  double tdeeOfUser;
  double userActivityForCalc;
  double userGoalKcal;
  if (userGoal == 'Fat Loss') {
    userGoalKcal = -200;
  } else if (userGoal == 'Weight Gain') {
    userGoalKcal = 200;
  } else {
    userGoalKcal = 0;
  }
  (userGender == 'Woman')
      ? calBMR =
          (10 * userWeight / 2.2) + (6.25 * userHeight) - (5 * userAge) - 161
      : calBMR =
          (10 * userWeight / 2.2) + (6.25 * userHeight) - (5 * userAge) + 5;
  if (userActivity == 'Sedentary') {
    userActivityForCalc = 1.2;
  } else if (userActivity == 'Lightly Active') {
    userActivityForCalc = 1.375;
  } else if (userActivity == 'Moderately Active') {
    userActivityForCalc = 1.55;
  } else if (userActivity == 'Very Active') {
    userActivityForCalc = 1.725;
  } else {
    userActivityForCalc = 1.9;
  }
  tdeeOfUser = (userGender == 'Woman')
      ? calBMR = ((10 * userWeight / 2.2) +
                  (6.25 * userHeight) -
                  (5 * userAge) -
                  161) *
              userActivityForCalc +
          userGoalKcal
      : (calBMR = (10 * userWeight / 2.2) +
                  (6.25 * userHeight) -
                  (5 * userAge) +
                  5) *
              userActivityForCalc +
          userGoalKcal;
  return roundDouble(tdeeOfUser, 2);
}

double bmrCalculator(
    userGender, userWeight, userHeight, userAge, userActivity) {
  double calBMR;
  (userGender == 'Woman')
      ? calBMR =
          (10 * userWeight / 2.2) + (6.25 * userHeight) - (5 * userAge) - 161
      : calBMR =
          (10 * userWeight / 2.2) + (6.25 * userHeight) - (5 * userAge) + 5;
  return roundDouble(calBMR, 2);
}

double tdeeCalculator(
    userGender, userWeight, userHeight, userAge, userActivity) {
  double calBMR;
  double tdeeOfUser;
  double userActivityForCalc;
  (userGender == 'Woman')
      ? calBMR =
          (10 * userWeight / 2.2) + (6.25 * userHeight) - (5 * userAge) - 161
      : calBMR =
          (10 * userWeight / 2.2) + (6.25 * userHeight) - (5 * userAge) + 5;
  if (userActivity == 'Sedentary') {
    userActivityForCalc = 1.2;
  } else if (userActivity == 'Lightly Active') {
    userActivityForCalc = 1.375;
  } else if (userActivity == 'Moderately Active') {
    userActivityForCalc = 1.55;
  } else if (userActivity == 'Very Active') {
    userActivityForCalc = 1.725;
  } else {
    userActivityForCalc = 1.9;
  }
  tdeeOfUser = (userGender == 'Woman')
      ? calBMR = ((10 * userWeight / 2.2) +
              (6.25 * userHeight) -
              (5 * userAge) -
              161) *
          userActivityForCalc
      : (calBMR = (10 * userWeight / 2.2) +
              (6.25 * userHeight) -
              (5 * userAge) +
              5) *
          userActivityForCalc;
  return roundDouble(tdeeOfUser, 2);
}
