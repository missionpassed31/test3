%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void yyerror(const char *s);
int yylex();
%}

%union {
    double num;
}

%token <num> NUMBER
%token SQRT CQRT POW EXP SIN COS TAN ASIN ACOS ATAN SINH COSH TANH
%left '+' '-'
%left '*' '/'
%right '^'

%type <num> expr

%%

input:
    | input line
    ;

line:
    expr '\n' { printf("Result: %lf\n", $1); }
    | '\n'
    ;

expr:
    NUMBER { $$ = $1; }
    | expr '+' expr { $$ = $1 + $2; }
    | expr '-' expr { $$ = $1 - $2; }
    | expr '*' expr { $$ = $1 * $2; }
    | expr '/' expr { if ($2 == 0) yyerror("Division by zero!"); else $$ = $1 / $2; }
    | SQRT '(' expr ')' { $$ = sqrt($3); }
    | CQRT '(' expr ')' { $$ = cbrt($3); }
    | POW '(' expr ',' expr ')' { $$ = pow($3, $5); }
    | EXP '(' expr ')' { $$ = exp($3); }
    | SIN '(' expr ')' { $$ = sin($3); }
    | COS '(' expr ')' { $$ = cos($3); }
    | TAN '(' expr ')' { $$ = tan($3); }
    | ASIN '(' expr ')' { $$ = asin($3); }
    | ACOS '(' expr ')' { $$ = acos($3); }
    | ATAN '(' expr ')' { $$ = atan($3); }
    | SINH '(' expr ')' { $$ = sinh($3); }
    | COSH '(' expr ')' { $$ = cosh($3); }
    | TANH '(' expr ')' { $$ = tanh($3); }
    | '(' expr ')' { $$ = $2; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
