%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "calc.tab.h"

int yylval;
%}

DIGIT  [0-9]
NUMBER {DIGIT}+(\.{DIGIT}+)?

%%

{NUMBER}   { yylval = atof(yytext); return NUMBER; }
"SQRT"     { return SQRT; }
"CQRT"     { return CQRT; }
"POW"      { return POW; }
"EXP"      { return EXP; }
"SIN"      { return SIN; }
"COS"      { return COS; }
"TAN"      { return TAN; }
"ASIN"     { return ASIN; }
"ACOS"     { return ACOS; }
"ATAN"     { return ATAN; }
"SINH"     { return SINH; }
"COSH"     { return COSH; }
"TANH"     { return TANH; }
"+"        { return '+'; }
"-"        { return '-'; }
"*"        { return '*'; }
"/"        { return '/'; }
"^"        { return '^'; }
"("        { return '('; }
")"        { return ')'; }
","        { return ','; }
"\n"       { return '\n'; }
[ \t]      { /* Ignore whitespace */ }
.          { printf("Unexpected character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
