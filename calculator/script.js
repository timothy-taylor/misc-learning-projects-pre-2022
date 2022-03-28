// DOM FUNCTIONS
const updateDisplay = function(number) {
  document.getElementById('display').innerHTML = number;
  logEverything();
}
updateDisplay(activeResult);

const colorChooser = (id) => {
  if (id === 'number') {
    const numberColors = ["yellow", "gold", "orange", "orangeRed", "tomato", "coral",
      "gold", "pink", "pink", "yellow"];
    const chosenNumColor = numberColors[ Math.floor( Math.random()*10 ) ];
    document.getElementById('stateIcon').style.backgroundColor = chosenNumColor;
  } else if (id === 'clear') {
    document.getElementById('stateIcon').style.backgroundColor = "#EFEFEF";
  } else {
    const operatorColors = ["aqua", "fuschia", "green", "lime", "blue", "olive",
      "purple", "silver", "teal", "cyan"];
    const chosenOpColor = operatorColors[ Math.floor( Math.random()*10 ) ];
    document.getElementById('stateIcon').style.backgroundColor = chosenOpColor;
  }
}

const buttons = Array.from(document.querySelectorAll('.calcbutton'));
buttons.forEach(number => number.addEventListener('click', function (event) {
  if (event.target.id === 'number') {
    const numericalValue = event.target.innerHTML;
    numberPressed(numericalValue);
  } else {
    nonNumberParser(event.target.id);
  }
  colorChooser(event.target.id);
}));

window.addEventListener('keypress', function (event) {
  keyPressParser(event.key);
  colorChooser(event.key);
});
