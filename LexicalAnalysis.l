%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
%}

DIGIT [0-9]
ID [a-z][a-z0-9]*

%%

{DIGIT}+ {printf("An integer: %s (%d)\n", yytext, atoi(yytext));}
{DIGIT}+"."{DIGIT}* {printf("A float: %s (%g)\n", yytext, atof(yytext));}
"main"|"return"|"if"|"then"|"begin"|"end"|"procedure"|"function" {printf("A keyword: %s\n", yytext);}
{ID} {printf("An identifier: %s\n", yytext);}
"+"|"-"|"*"|"/" {printf("An operator: %s\n", yytext);}
"{"[\^{}}\n]*"}"   /* Eat up one-line comments */
[ \t\n]+            /* Eat up whitespace */
","|";"             {printf("special symbols: %s\n", yytext);}
.                   {printf("Unrecognized character: %s\n", yytext);}

%%

int yywrap() {
    return 1;  // Indicate end of input
}

int main(int argc, char **argv) {
    FILE *fp;
    char filename[50];
    printf("Enter the filename: \n");
    scanf("%s", filename);
    fp = fopen(filename, "r");
    yyin = fp;
    yylex();
    fclose(fp);
    return 0;
