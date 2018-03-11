
// Imports

import findParentNode from 'scripts/helpers/findParentNode.js';
import scrollToLocation from 'scripts/helpers/scrollToLocation.js';

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

// Scope Goals

function goalLevel(type, activity) {

  if (type == 'lose') {
    let protein = .50;
    let carbs = .20;
    let fat = .30;

    if (activity == 'sedentary') { carbs = .10; fat = .40; }
    if (activity == 'light') { carbs = .15; fat = .35; }
    if (activity == 'competitive') { carbs = .30; fat = .20; }

    return {
      protein: protein,
      carbs: carbs,
      fat: fat,
    }

  }

  if (type == 'gain') {
    let protein = .45;
    let carbs = .45;
    let fat = .10;

    return {
      protein: protein,
      carbs: carbs,
      fat: fat,
    }

  }

  if (type == 'maintain') {
    let protein = .35;
    let carbs = .35;
    let fat = .30;

    return {
      protein: protein,
      carbs: carbs,
      fat: fat,
    }

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
      const macroMultiplier = goalLevel(selectedGoal, selectedExercise);
      let BMR = ( (10 * convertedWeightValue) + (6.25 * convertedHeightValue) ) - (5 * ageValue);
      BMR = selectedRadio.value == 'male' ? BMR + 5 : BMR - 161;

      const calorieIntake = Math.floor(BMR * activityMultiplier);
      const proteinCalories = calorieIntake * macroMultiplier.protein;
      const carbCalories = calorieIntake * macroMultiplier.carbs;
      const fatCalories = calorieIntake * macroMultiplier.fat;

      const proteinGrams = Math.floor(proteinCalories / 4);
      const carbGrams = Math.floor(carbCalories / 4);
      const fatGrams = Math.floor(fatCalories / 9);

      if (!firstIteration) {
        submitButton.value = 'change';
        firstIteration = true;
        setResultsDisplay();
      }

      caloriesContainer.innerHTML = `${calorieIntake}`;
      carbsContainer.innerHTML = `${proteinGrams}g`;
      proteinContainer.innerHTML = `${carbGrams}g`;
      fatContainer.innerHTML = `${fatGrams}g`;


    });

  });

}
