#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_RULES 10
#define MAX_SYMBOLS 100

typedef struct {
    char lhs;
    char rhs[MAX_SYMBOLS][MAX_SYMBOLS];
    int count;
} Production;

void eliminateLeftRecursion(Production *rules, int *num_rules) {
    for (int i = 0; i < *num_rules; i++) {
        int has_left_recursion = 0;
        
        // Check if the production has left recursion
        for (int k = 0; k < rules[i].count; k++) {
            if (rules[i].rhs[k][0] == rules[i].lhs) {
                has_left_recursion = 1;
                break;
            }
        }

        if (has_left_recursion) {
            char new_non_terminal[3] = {rules[i].lhs, '\'', '\0'}; // E' instead of E1
            printf("New non-terminal: %s\n", new_non_terminal);

            Production new_rule;
            new_rule.lhs = new_non_terminal[0];
            new_rule.count = 0;

            int original_count = rules[i].count;
            rules[i].count = 0; 

            // Modify the rule to eliminate left recursion
            for (int k = 0; k < original_count; k++) {
                if (rules[i].rhs[k][0] == rules[i].lhs) {
                    strcpy(new_rule.rhs[new_rule.count], rules[i].rhs[k] + 1); // Remove the left recursion part
                    strcat(new_rule.rhs[new_rule.count], new_non_terminal); // Append the new non-terminal
                    new_rule.count++;
                } else {
                    strcpy(rules[i].rhs[rules[i].count], rules[i].rhs[k]);
                    strcat(rules[i].rhs[rules[i].count], new_non_terminal); // Add the new non-terminal for each rule
                    rules[i].count++;
                }
            }

            // Add epsilon to the new rule
            strcpy(new_rule.rhs[new_rule.count], "ε");
            new_rule.count++;

            // Add the new rule to the grammar
            if (*num_rules < MAX_RULES) {
                rules[*num_rules] = new_rule;
                (*num_rules)++;
            } else {
                printf("Maximum number of rules exceeded. Cannot add more rules.\n");
            }
        }
    }

    // Print the updated grammar after elimination of left recursion
    printf("\nGrammar after left recursion elimination:\n");
    for (int i = 0; i < *num_rules; i++) {
        printf("%c -> ", rules[i].lhs);
        for (int j = 0; j < rules[i].count; j++) {
            printf("%s", rules[i].rhs[j]);
            if (j < rules[i].count - 1) {
                printf(" | ");
            }
        }
        printf("\n");
    }
}

int main() {
    Production rules[MAX_RULES];
    int num_rules;

    printf("Enter the number of production rules: ");
    scanf("%d", &num_rules);
    getchar(); // Consume the newline character after entering the number of rules

    for (int i = 0; i < num_rules; i++) {
        printf("Enter rule %d (format: A->α|β): ", i + 1);
        char input[MAX_SYMBOLS];
        fgets(input, MAX_SYMBOLS, stdin);
        input[strcspn(input, "\n")] = 0; // Remove the newline character

        rules[i].lhs = input[0];  // Left-hand side of the production
        rules[i].count = 0;
        char *token = strtok(input + 3, "|");  // Skip the first 3 characters (A->)
        
        while (token != NULL) {
            strcpy(rules[i].rhs[rules[i].count], token);
            rules[i].count++;
            token = strtok(NULL, "|");
        }
    }

    eliminateLeftRecursion(rules, &num_rules);
    return 0;
}
