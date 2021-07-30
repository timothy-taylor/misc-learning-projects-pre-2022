var operateWithoutEvaluate;
var newWorkingNumber;
var workingNumber;
var activeResult;
var op;
var includeDecimal;

function logEverything() {
    console.log("includeDecimal = " + includeDecimal);
    console.log("workingNumber = " + workingNumber);
    console.log("activeResult = " + activeResult);
    console.log("op = " + op);
}

// MATH & LOGICAL FUNCTIONS
const addition = (a,b) => (a+b);
const subtraction = (a,b) => (a-b);
const multiplication = (a,b) => (a*b);
const division = (a,b) => (a/b);

const operate = (operator,a,b) => {
    console.log("Operating with " + operator + " on a and b " + a + " " + b);

    if (operator === "add") {
        result = addition(a,b);
    } else if (operator === "subtract") {
        result = subtraction(a,b);
    } else if (operator === "multiply") {
        result = multiplication(a,b);
    } else if (operator === "divide") {
        result = division(a,b);
    }
    return result;
}

const init = () => {
    operateWithoutEvaluate = false;
    includeDecimal = false;
    workingNumber = 0;
    activeResult = 0;
    op = "add";
}
init();

const newOperator = (opPressed, runEvaluate) => {
    if (runEvaluate) {
        evaluate();
    }
    op = opPressed;
}

const evaluate = () => {
    let result = Number(operate(op, activeResult, workingNumber));
    if (!Number.isInteger(result)) {
        result = result.toFixed(2);
    }
    activeResult = result;
}

const numberPressed = (inputNumber) => {
    let workingNumberString;
    if ((workingNumber === 0) || (newWorkingNumber)) {
        workingNumberString = ""; // We are inputting a new number 
    } else {
        workingNumberString = workingNumber.toString(); // We are concatenating to the existing 
    }
    if (includeDecimal) {
        workingNumber = Number(workingNumberString + '.' + inputNumber);
        includeDecimal = false;
    } else {
        workingNumber = Number(workingNumberString + inputNumber);
    }
    newWorkingNumber = false;
    updateDisplay(workingNumber);
}

const decimalPressed = () => {
    if (!includeDecimal && Number.isInteger(workingNumber)) {
        workingNumber = workingNumber + 0.00;
        newWorkingNumber = false;
        includeDecimal = true;
        updateDisplay(workingNumber.toFixed(2));
    } else {
        return;
    }
}

const nonNumberParser = (elementId) => {
    newWorkingNumber = true;
    if (elementId === 'equals') {
        operateWithoutEvaluate = true;
        evaluate();
        updateDisplay(activeResult);
    } else if (elementId === 'clear') {
        init();
        updateDisplay(activeResult);
        colorChooser('clear');
    } else if (elementId === 'random') {
        const randomNumber = Math.random() * 1000;
        workingNumber = randomNumber.toFixed(2);
        updateDisplay(workingNumber);
    } else if (elementId === 'absolute') {
        if (workingNumber<=0) {
            workingNumber = Math.abs(workingNumber);
        } else {
            workingNumber = -Math.abs(workingNumber);
        }
        updateDisplay(workingNumber);
    } else if (elementId === 'decimal') {
        decimalPressed();
    } else {
        newOperator(elementId, !operateWithoutEvaluate);
        updateDisplay(activeResult);
        operateWithoutEvaluate = false;
    }
}

const keyPressParser = (keyValue) => {
  const index = keyValue;
  const library = [ {key:'a', value:10}, {key:'b', value:11}, 
    {key:'c', value:12}, {key:'d', value:13}, {key:'e', value:14}, 
    {key:'f', value:15}, {key:'g', value:16}, {key:'h', value:17}, 
    {key:'i', value:18}, {key:'j', value:19}, {key:'k', value:20}, 
    {key:'l', value:21}, {key:'m', value:22}, {key:'n', value:23}, 
    {key:'o', value:24}, {key:'p', value:25}, {key:'q', value:26}, 
    {key:'r', value:27}, {key:'s', value:28}, {key:'t', value:29}, 
    {key:'u', value:30}, {key:'v', value:31}, {key:'w', value:32}, 
    {key:'x', value:33}, {key:'y', value:34}, {key:'z', value:35},
    {key:',', value:'clear'}, {key:'Enter', value:'equals'},
    {key:'=', value:'add'}, {key:'-', value:'subtract'},
    {key:'/', value:'divide'}, {key:'*', value:'multiply'},
    {key:'`', value:'random'}, {key:'.', value:'decimal'} ];
  const foundChar = library.find(element => element.key == index );
  const foundNum = Number(index);
  if(foundChar) {
    if( typeof(foundChar.value) === 'string' ) {
      nonNumberParser(foundChar.value);
    } else {
      numberPressed(foundChar.value);
    }
  } else {
    numberPressed(foundNum);
  } 
}
