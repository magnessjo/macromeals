
// Check for a Number

function checkForNumber(value) {

  const reg = new RegExp('^[0-9]+$');

  if (reg.test(value) == false) return true;

  return false;

}

// Check for a Letter

function checkForLetter(value) {

  const reg = new RegExp('^[a-zA-Z]+$');

  if (reg.test(value) == false) return true;

  return false;

}

// Check for Zero value

function checkForZeroValue(value) {

  if (value == 0) return true;

  return false;

}

// Check for Length

function checkForLength(value) {

  if (value.length == 0) return true;

  return false;

}

const obj = {
  checkForNumber,
  checkForZeroValue,
  checkForLength,
}

export default obj;
