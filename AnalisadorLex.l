%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
#include <math.h>

void yyerror (char *c);
%}

%option yylineno

%%

return return RETURN;

exit return EXIT;

"}"  return CHAF;

typedef return TYPEDEF;

struct return STRUCT;

include return INCLUDE;

if return IF;

else return ELSE;

while return WHILE;

for return FOR;

printf return PRINTF;

main return MAIN;

void|int|float|char|double return CONST;

[0-9]+?[/.][0-9]+ return NUMBER;

[a-zA-Z] return CHAR;


[\n] return EOL;

[\ \t]+ ;

; return PTV;

"--"|"++" return INCDEC;

# return CARDINAL;


"{"|"("|")"|"="|"*"|"+"|"-"|"/"|"&"|"|"|"^"|"!"|"%"|"<"|">" return yytext[0];

"=="|"!="|"<="|">="|"&&"|"||" return OPERADORES_COMPOSTOS;

. ;

%%




int yywrap(){

return 1;
}
