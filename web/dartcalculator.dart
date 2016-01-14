import 'dart:html';

//4 (b): Add operation type constants and storage variable
const int unknown = -1;
const int OperationTypeAdd = 1;
const int OperationTypeSubtract = 2;
const int OperationTypeMultiply = 3;
const int OperationTypeDivide = 4;

int operationType = unknown;
double number1;

//HTML Elements
DivElement screen;
ElementList<DivElement> numbers;
DivElement decimal;
DivElement clear;
DivElement clearAll;
DivElement add;
DivElement subtract;
DivElement multiply;
DivElement divide;
DivElement equals;

//1: Initialize Elements
//2: Implement click listeners
void main() {
    screen = querySelector("#calculator_screen");
    
    numbers = querySelectorAll(".number");
    for(DivElement number in numbers) {
      number.onClick.listen(numberClicked); 
    }
    decimal = querySelector("#decimal");
    decimal.onClick.listen(decimalClicked);
    
    clear = querySelector("#clear");
    clear.onClick.listen(clearScreen);
    clearAll = querySelector("#clear-everything");
    clearAll.onClick.listen(clearEverything);
    
    
    //4 (a): Add elements and stub out click listeners for operation type
    add = querySelector("#add");
    add.onClick.listen(addClicked);
    subtract = querySelector("#subtract");
    subtract.onClick.listen(subtractClicked);
    multiply = querySelector("#multiply");
    multiply.onClick.listen(multiplyClicked);
    divide = querySelector("#divide");
    divide.onClick.listen(divideClicked);
    
    //8: Add equals button and stub out method
    equals = querySelector("#equals");
    equals.onClick.listen(equalsClicked);
  
    clearEverything(null);
}

//3. Implement click listeners
/**
 * Called when a number button (0-9) is clicked.
 */
void numberClicked(MouseEvent event)  {
    //If the number is currently '0', clear it
    if(screen.text == "0") {
        screen.text = "";
    }
    
    //Add the number clicked to the screen, if the screen number's length is less than 10
    if(screen.text.length < 10) {
        //print(event.toElement.text + " clicked");
        screen.text = screen.text + event.target.text;
    }
}

/**
 * Add a decimal to the current number
 */
void decimalClicked(MouseEvent event) {
    if(!screen.text.contains(".")) {
        screen.text = screen.text + ".";
    }
}

/**
 * Clear the screen of the current number
 */
void clearScreen(MouseEvent event) {
    //Reset the screen number back to 0
    screen.text = "0";   
}

/**
 * Clear the screen and all locally stored variables
 */
void clearEverything(MouseEvent event) {
    clearScreen(event);
    operationType = unknown;
    operationTypeChanged(null);
    number1 = null;
}

//5: Implement click events for operation types
void addClicked(MouseEvent event) {
    operationType = OperationTypeAdd;
    operationTypeChanged(event.target);
}
void subtractClicked(MouseEvent event) {
    operationType = OperationTypeSubtract;
    operationTypeChanged(event.target);
}
void multiplyClicked(MouseEvent event) {
    operationType = OperationTypeMultiply;
    operationTypeChanged(event.target);
}
void divideClicked(MouseEvent event) {
    operationType = OperationTypeDivide;
    operationTypeChanged(event.target);
}
//6: Add global click event for all operations
void operationTypeChanged(Element selected) {
    //Remove the selected class from each operation button (+ - / *)
    List<Element> operationElements = queryAll(".operation");
    for(Element element in operationElements) {
        element.classes.remove("selected");
    }
    
    if(operationType != unknown) {
        //Add the selected class to the operation type that was just selected
        selected.classes.add("selected");
        
        //7: Add 'number1' variable
        if(number1 == null) {
            number1 = double.parse(screen.text);
            screen.text = "0";
        }
    }
}


//9. Implement equals method
void equalsClicked(MouseEvent event) {
    if(number1 != null && operationType != unknown) {
        double result;
        double number2 = double.parse(screen.text);

        switch(operationType) {
            case OperationTypeAdd:
              result = number1 + number2;
              break;
            case OperationTypeSubtract:
              result = number1 - number2;
              break;
            case OperationTypeMultiply:
              result = number1 * number2;
              break;
            case OperationTypeDivide:
              result = number1 / number2;
              break;
        }
        
        clearEverything(null);
        String displayString = result.toString();
        if(displayString.length > 10) {
            displayString = displayString.substring(0, 10);
        }
        screen.text = displayString;
    }
}
