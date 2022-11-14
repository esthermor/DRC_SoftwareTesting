/**
 * Type checking utilities for verification
 */

/**
 * Test weather the object provided is a valid string
 * @param {any|string} o Object to test against
 * @param {boolean} allowEmpty consider empty string as a valid string. Default value is false
 *
 * @returns {boolean}
 */
function isString(o, allowEmpty = false) {
  if (typeof o !== "string") {
    return false;
  }
  return allowEmpty || !!o;
}

/**
 * Test weather the provided value is a value integer
 * @param {any|number} o Object to test against
 *
 * @returns {boolean}
 */
function isInteger(o) {
  if (typeof o !== "number") {
    return false;
  }
  return (o | 0) === o;
}
/**
 * @template T
 * Check weather the provided values is inside the enumeration
 * @param {T} o value to test
 * @param {T[]} valid_vals array of valid values to be accepted
 */
function inEnumeration(o, valid_vals) {
  if (!o || typeof o !== typeof valid_vals[0]) {
    return false;
  }
  return valid_vals.includes(o);
}

/**
 * Try to parse the string as date
 * @param {string} o
 * @param {boolean} allowEmpty consider empty string as a valid date. Default value is false
 * @returns {boolean}
 */
function isValidDate(o, allowEmpty = false) {
  return (
    isString(o, allowEmpty) &&
    ((!o && allowEmpty) || new Date(o).toString() !== "Invalid Date")
  );
}

module.exports = { isString, isInteger, inEnumeration, isValidDate };
