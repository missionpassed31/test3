// 1.WRITE A PROGRAM FOR FINDING A CAPITAL LETTER OR NOT
%{
int count = 0;
%}
%%
[A-Z] {printf(&quot;%s capital letter\n&quot;, yytext);
count++;}
. {printf(&quot;%s not a capital letter\n&quot;, yytext);}
\n {return 0;}
%%
int yywrap(){}
int main(){
yylex();
printf(&quot;\nNumber of Capital letters in the given input - %d\n&quot;, count);
return 0;
}
