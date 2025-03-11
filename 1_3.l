//COUNT THE NO. OF VOWELS AND CONSONANTS IN A GIVEN STRING
%option noyywrap
%{
#include <stdio.h>

int v = 0, c = 0;  // Counters for vowels and consonants
%}

%%

[AEIOUaeiou]    { v++; }          // Count vowels
[a-zA-Z]        { c++; }          // Count consonants (both uppercase and lowercase letters)
\n              { /* optional action on newline, if needed */ }

%%

int main()
{
    printf("\nEnter the string: ");
    yylex();  // Perform lexical analysis
    printf("\nThe number of Vowels: %d", v);
    printf("\nThe number of Consonants: %d", c);
    return 0;
}
