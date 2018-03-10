
// Imports

import findParentNode from 'scripts/helpers/findParentNode.js';
import scrollToLocation from 'scripts/helpers/scrollToLocation.js';

// Variables

const form = document.querySelector('#macro-calculator');
const genderContainer = document.querySelector('div[data-field="gender"]');

const ageContainer = document.querySelector('div[data-field="age"]');
const ageInput = ageContainer.querySelector('input[type="text"]');

const heightContainer = document.querySelector('div[data-field="height"]');
const heightInputs = Array.from(heightContainer.querySelectorAll('input[type="text"]'));

const exerciseContainer = document.querySelector('div[data-field="exercise"]');
const exerciseButtons = Array.from(exerciseContainer.querySelectorAll('button'));
let selectedExercise;

const goalContainer = document.querySelector('div[data-field="goal"]');
const goalButtons = Array.from(goalContainer.querySelectorAll('button'));
let selectedGoal;

const errorAttribute = 'data-error';

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

// Validate Form Fields

function validateForm() {

  return new Promise( (resolve, reject) => {

    const isGenderValid = validateRadioButtons();
    const isAgeValid = validateAge();
    const isHeightValid = validateHeightInputs();

    const isExerciseValid = selectedExercise == undefined;
    const isGoalValid = selectedGoal == undefined;

    if (isExerciseValid) exerciseContainer.setAttribute(errorAttribute, true);
    if (isGoalValid) goalContainer.setAttribute(errorAttribute, true);

    if (!isGenderValid)  scrollToLocation(genderContainer, 80);
    if (isGenderValid && !isAgeValid)  scrollToLocation(ageContainer, 80);
    if (isGenderValid && isAgeValid && !isHeightValid)  scrollToLocation(heightContainer, 80);
    if (isGenderValid && isAgeValid && isHeightValid && !isExerciseValid)  scrollToLocation(exerciseContainer, 80);
    if (isGenderValid && isAgeValid && isHeightValid && isExerciseValid && !isGoalValid)  scrollToLocation(goalContainer, 80);

    resolve(true);

  });

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

  form.addEventListener('submit', e => {

    e.preventDefault();

    validateForm().then(() => {

    });

  });

}
