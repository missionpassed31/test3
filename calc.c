#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// Function to evaluate expressions using basic operators
double evaluate(const char *expression) {
    // A simple function to handle +, -, *, /, and ^ operators
    // NOTE: This is a very basic implementation.
    // For complex parsing, external libraries or more robust parsing logic is needed.
    double result = 0.0;
    char operator = '+';
    double current = 0.0;
    
    while (*expression) {
        char ch = *expression;

        if (ch >= '0' && ch <= '9') {
            current = current * 10 + (ch - '0');
        } else if (ch == '+' || ch == '-' || ch == '*' || ch == '/' || ch == '^') {
            switch (operator) {
                case '+': result += current; break;
                case '-': result -= current; break;
                case '*': result *= current; break;
                case '/': result /= current; break;
                case '^': result = pow(result, current); break;
            }
            operator = ch;
            current = 0.0;
        }
        expression++;
    }

    // Apply the last operation
    switch (operator) {
        case '+': result += current; break;
        case '-': result -= current; break;
        case '*': result *= current; break;
        case '/': result /= current; break;
        case '^': result = pow(result, current); break;
    }

    return result;
}

int main() {
    char expression[100];

    printf("Simple Calculator (Ctrl+D to exit):\n");

    while (1) {
        printf("> ");
        if (fgets(expression, sizeof(expression), stdin) == NULL) {
            break; // Exit on EOF (Ctrl+D)
        }
        
        // Evaluate the expression
        double result = evaluate(expression);
        printf("Result: %.2f\n", result);
    }

    printf("\nExiting calculator. Goodbye!\n");
    return 0;
}
