
// Imports

import findParentNode from 'scripts/helpers/findParentNode.js';
import scrollToLocation from 'scripts/helpers/scrollToLocation.js';
import pieChart from 'scripts/components/pieChart.js';

// Variables

const form = document.querySelector('#macro-calculator');
const submitButton = form.querySelector('input[type="submit"]');

const genderContainer = document.querySelector('div[data-field="gender"]');

const ageContainer = document.querySelector('div[data-field="age"]');
const ageInput = ageContainer.querySelector('input[type="text"]');

const heightContainer = document.querySelector('div[data-field="height"]');
const heightInputs = Array.from(heightContainer.querySelectorAll('input[type="text"]'));

const weightContainer = document.querySelector('div[data-field="weight"]');
const weightInput = weightContainer.querySelector('input[type="text"]');

const exerciseContainer = document.querySelector('div[data-field="exercise"]');
const exerciseButtons = Array.from(exerciseContainer.querySelectorAll('button'));
let selectedExercise;

const goalContainer = document.querySelector('div[data-field="goal"]');
const goalButtons = Array.from(goalContainer.querySelectorAll('button'));
let selectedGoal;

const errorAttribute = 'data-error';

const resultContainer = document.querySelector('#results');
const caloriesContainer = resultContainer.querySelector('[data-type="calories"] span');
const carbsContainer = resultContainer.querySelector('[data-type="carbs"] span');
const proteinContainer = resultContainer.querySelector('[data-type="protein"] span');
const fatContainer = resultContainer.querySelector('[data-type="fat"] span');
const pieChartContainer = resultContainer.querySelector('.pie-chart');

let firstIteration = false;

// Validate Radio Buttons

function validateRadioButtons() {

  const inputs = Array.from(genderContainer.querySelectorAll('input[type="radio"]'));
  let isValid = false;

  inputs.forEach( (input) => {
    if (input.checked) isValid = true;
    input.addEventListener('change', e => { genderContainer.removeAttribute(errorAttribute) });
  });

  if (isValid) {
    return true;
  } else {
    genderContainer.setAttribute(errorAttribute, true);
    return false;
  }

}

// Validate Age

function validateAge() {

  if (ageInput.value != '') {
    return true;
  } else {
    ageContainer.setAttribute(errorAttribute, true);
    return false;
  }

}

// Validate Height

function validateHeightInputs() {

  let isValid = false;

  heightInputs.forEach( (input) => {
    if (input.value.length > 0 && !isNaN(input.value)) isValid = true;
  });

  if (isValid) {
    return true;
  } else {
    heightContainer.setAttribute(errorAttribute, true);
    return false;
  }

}

// Validate Weight

function validateAge() {

  if (ageInput.value != '') {
    return true;
  } else {
    ageContainer.setAttribute(errorAttribute, true);
    return false;
  }

}


// Validate Form Fields

function validateForm() {

  return new Promise( (resolve, reject) => {

    const isGenderValid = validateRadioButtons();
    const isAgeValid = validateAge();
    const isHeightValid = validateHeightInputs();
    const isWeightValid = validateAge();

    const isExerciseValid = selectedExercise != undefined;
    const isGoalValid = selectedGoal != undefined;

    if (!isExerciseValid) exerciseContainer.setAttribute(errorAttribute, true);
    if (!isGoalValid) goalContainer.setAttribute(errorAttribute, true);

    var scroll = function(container) {
      scrollToLocation(container, 80);
    }

    if (!isGenderValid) scroll(genderContainer);
    if (isGenderValid && !isAgeValid) scroll(ageContainer);
    if (isGenderValid && isAgeValid && !isHeightValid) scroll(heightContainer);
    if (isGenderValid && isAgeValid && isHeightValid && !isWeightValid) scroll(weightContainer);
    if (isGenderValid && isAgeValid && isHeightValid && isWeightValid && !isExerciseValid) scroll(exerciseContainer);
    if (isGenderValid && isAgeValid && isHeightValid && isWeightValid &&  isExerciseValid && !isGoalValid) scroll(goalContainer);

    if (isGenderValid && isAgeValid && isHeightValid && isWeightValid && isExerciseValid && isGoalValid) resolve();

  });

}

// Scope Goals

function goalLevel(type) {

  if (type == 'lose') {

    return {
      protein: .50,
      carbs: .20,
      fat: .30,
    }

  }

  if (type == 'gain') {

    return {
      protein: .45,
      carbs: .45,
      fat: .10,
    }

  }

  if (type == 'maintain') {

    return {
      protein: .35,
      carbs: .35,
      fat: .30,
    }

  }

}

// Scope Activity Level

function activityLevel(type) {

  switch(type) {
      case 'sedentary':
        return 1.1
        break;
      case 'light':
        return 1.3
        break;
      case 'moderate':
        return 1.5
        break;
      case 'very':
        return 1.7
        break;
      case 'competitive':
        return 1.9
        break;

  }

}

// Calorie Multiplier

function caloriesGoal(calories, type) {

  switch(type) {
      case 'lose':
        return parseFloat(calories - 500);
        break;
      case 'gain':
        return parseFloat(calories + 250);
        break;
      case 'maintain':
        return calories;
        break;
  }

}

// Export

export default function() {

  ageInput.addEventListener('blur', e => {
    if (ageInput.value.length > 0 && !isNaN(ageInput.value)) ageContainer.removeAttribute(errorAttribute)
  });

  heightInputs.forEach( (input) => {
    input.addEventListener('blur', e => {
      if (heightInputs[0].value.length > 0 && !isNaN(heightInputs[0].value) && heightInputs[1].value.length > 0 && !isNaN(heightInputs[1].value) ){
        heightContainer.removeAttribute(errorAttribute);
      }
    });
  });

  exerciseButtons.forEach( (button) => {

    button.addEventListener('click', e => {

      e.preventDefault();
      exerciseButtons.forEach( (btn) => {

        if (btn == button) {
          btn.setAttribute('data-active', true);
          selectedExercise = btn.getAttribute('data-type');
          exerciseContainer.removeAttribute(errorAttribute);
        }
        if (btn != button) btn.removeAttribute('data-active');


      });

    });

  });

  goalButtons.forEach( (button) => {

    button.addEventListener('click', e => {

      e.preventDefault();
      goalButtons.forEach( (btn) => {

        if (btn == button) {
          btn.setAttribute('data-active', true);
          selectedGoal = btn.getAttribute('data-type');
          goalContainer.removeAttribute(errorAttribute);
        }

        if (btn != button) btn.removeAttribute('data-active');

      });

    });

  });

  function setResultsDisplay() {

    const resultLock = resultContainer.querySelector('.lock');

    function resize(transform = true) {

      const size = resultLock.offsetHeight;
      resultContainer.style.height = `${size}px`;
      if (transform) resultContainer.style.transition = `height 1s`;

    }

    window.addEventListener('resize', resize);
    resize(false);

  }

  form.addEventListener('submit', e => {

    e.preventDefault();

    validateForm().then(() => {

      const selectedRadio = form.querySelector('input[type="radio"]:checked');
      const ageValue = ageInput.value;
      const weightValue = weightInput.value;
      const convertedWeightValue = 0.45359237 * weightValue;
      const feetValue = parseFloat(heightInputs[0].value);
      const inchValue = parseInt(heightInputs[1].value);
      const convertedHeightValue = (( feetValue * 12) + inchValue) * 2.54;
      const activityMultiplier = activityLevel(selectedExercise);
      const macroMultiplier = goalLevel(selectedGoal);
      let BMR = ( (10 * convertedWeightValue) + (6.25 * convertedHeightValue) ) - (5 * ageValue);
      BMR = selectedRadio.value == 'male' ? BMR + 5 : BMR - 161;
      const caloriteMultipler = Math.floor(BMR * activityMultiplier);
      const calorieIntake = caloriesGoal(caloriteMultipler, selectedGoal);

      const proteinCalories = calorieIntake * macroMultiplier.protein;
      const carbCalories = calorieIntake * macroMultiplier.carbs;
      const fatCalories = calorieIntake * macroMultiplier.fat;

      const proteinGrams = Math.floor(proteinCalories / 4);
      const carbGrams = Math.floor(carbCalories / 4);
      const fatGrams = Math.floor(fatCalories / 9);

      caloriesContainer.innerHTML = `${calorieIntake}`;
      carbsContainer.innerHTML = `${carbGrams}g`;
      proteinContainer.innerHTML = `${proteinGrams}g`;
      fatContainer.innerHTML = `${fatGrams}g`;

      pieChartContainer.innerHTML = '';
      const canvas = document.createElement('canvas');
      canvas.setAttribute('width', 200);
      canvas.setAttribute('height', 200);
      canvas.setAttribute('data-pie', `${macroMultiplier.protein * 100}%,${macroMultiplier.carbs * 100}%,${macroMultiplier.fat * 100}%`);
      pieChartContainer.appendChild(canvas);

      pieChart();
      scrollToLocation(resultContainer, 80);

      if (!firstIteration) {
        submitButton.value = 'change';
        firstIteration = true;
        setResultsDisplay();
      }

    });

  });

}
