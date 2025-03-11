//WRITE A PROGRAM TO COUNT THE NUMBER OF LINES AND NUMBER OF CHARACTERS
%{
#include <stdio.h>

int no_of_lines = 0;
int no_of_chars = 0;
%}

%%
\n          { ++no_of_lines; }
.           { ++no_of_chars; }
%%

int yywrap() {
    return 1;  // Returning 1 to indicate no more input
}

int main(int argc, char **argv)
{
    yylex();  // Start lexical analysis
    printf("number of lines = %d, number of chars = %d\n", no_of_lines, no_of_chars);
    return 0;
}
