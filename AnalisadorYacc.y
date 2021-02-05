%{

#include <stdio.h>
#include "y.tab.h"
    int yylex(void);
    int yyerror(const char *s);
    int success = 1;

%}

%define parse.error verbose


%token RETURN EXIT CHAF TYPEDEF STRUCT CARDINAL WHILE IF ELSE INCLUDE FOR INCDEC CHAR NUMBER EOL CONST PTV OPERADORES_COMPOSTOS MAIN PRINTF

%left PTV

%start PROGRAMA

%% 


PROGRAMA:
   	|PROGRAMA exp EOL 
        ;


exp:
   exp_include
    ;

exp_include :exp_definicao
	     |CARDINAL INCLUDE '<' id '>' 
             ;

exp_definicao:
	      exp_struct
             |exp_struct_fim
	     |exp_logica
  	     |CONST exp_funcao
             |exp_funcao
             |CHAF
             ;


exp_struct:
	    TYPEDEF STRUCT '{'
            ;

exp_struct_fim:
	     CHAF id PTV
              ;
                       
              


exp_funcao:
	   MAIN '('')' '{'
	  |FOR '(' exp_condicoes_for ')' '{'
          |IF '(' exp_condicoes_if_while ')'  '{'
          |WHILE '(' exp_condicoes_if_while ')''{'
          |ELSE '{'
          |PRINTF'('id')' PTV
          |RETURN exp_saida PTV
          |EXIT exp_saida PTV
          |exp_logica PTV exp_definicao 
	  ;

exp_saida:
          id 
          |'(' id ')' 
          ;

exp_condicoes_for:
	        id '=' id PTV id operadores_condicoes id PTV id for_incdec
               ;


for_incdec:
	   |INCDEC
           |operador exp_logica
           ;


exp_condicoes_if_while:
               id operadores_condicoes exp_condicoes_if_while
               |id 
               ;

operadores_condicoes:
               '<'|'>'
              |OPERADORES_COMPOSTOS
	      ;

operador: 
	  '='|'*'|'+'|'-'|'<'|'>'|'/'|'^'
           |OPERADORES_COMPOSTOS
 	   ;


exp_logica:
	   id operador exp_logica 
	  |id 
          ;
            



id: 
    carater
   |num
   ;


carater: 
       CHAR carater
      |
      ;
           

num:
    NUMBER num
   |
   ;












%%

int yyerror(const char *msg)
{
    extern int yylineno;
    printf("Erro de parsing na ultima linha\nErro:%s\n",msg);
    success = 0;
    return 0;
}



int main()
{

printf("Codigo:\n");
if(yyparse()==0)
return 0;
}



