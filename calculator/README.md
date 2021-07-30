#### The Odin Project Assignment : Make a calculator

Access a live version [here](https://timothy-taylor.github.io/calculator/index.html)

# Plan

### What does the interface of the project look like? Where does the input come from?

Simple calculator layout using HTML, CSS, Javascript. Input comes from web app interface.

### What is the desired output? How do we get there?

Correct mathematical answers through mathematical functions with interactive web experience.

## Pseudo-code:
1. functions for add, subtract, multiply, divide 
2. operate function that takes two numbers and one of the above functions
3. create html interface out of buttons (0-9,+-x/=), clear button, dummy display; style with css
4. a function that populates the display when you click number buttons, 'display value' variable
5. make it work: store first number pressed, operator chosen, second number pressed
6. operate() when = is pressed, update display with 'solution'


##### // watch out for:
* ~~should be able to string together several operators ( 12 + 7 - 5 * 3 ) = 42~~
* ~~round long decimals~~
* ~~pressing = before all things are entered could be an issue~~
* ~~pressing clear should wipe existing stored data~~
* don't let dividing by 0 crash, display a message
* ~~extra credit : add a . button and let users use decimals don't let them use more than 1~~
* extra credit : add a backspace button
* ~~extra credit : add keyboard support~~


