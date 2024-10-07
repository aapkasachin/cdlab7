%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int yylex();
void yyerror(char *s);
extern int yylineno;
extern char * yytext;
extern FILE* yyin;
%}

%token INCLUDE TYPE PRINTF RETURN VOID IDENTIFIER BASIC_OP NUM STRING_LIT
%left BASIC_OP '='

%%
program:headers definitions
       ;
headers:headers header
       |header
       ;
header:INCLUDE
      ;
definitions:definitions definition
           |definition
           ;
definition:TYPE IDENTIFIER '(' arg_list ')' '{' body RETURN expr ';' '}'
          |TYPE IDENTIFIER '(' arg_list ')' '{'RETURN expr ';' '}'
          |VOID IDENTIFIER '(' body ')'
          ;
arg_list:arg_list ',' TYPE IDENTIFIER
        |TYPE IDENTIFIER
        |
        ;
identifiers_list:identifiers_list ',' IDENTIFIER
                |IDENTIFIER
                ;
body:body statement
    |statement
    ;
statement:declaration
         |assignment
         |PRINTF '(' STRING_LIT ',' identifiers_list ')' ';'
         ;
declaration:TYPE identifiers_list ';'
           ;
assignment:IDENTIFIER '=' expr ';'
          ;
expr:expr BASIC_OP expr
    |expr '=' expr
    |NUM
    |IDENTIFIER
    ;     
%%

void yyerror(char *s)
{
    fprintf(stderr,"%d\t%s\t%s\n",yylineno,s,yytext);
    exit(0);
}

int main()
{
   yyin=fopen("7_in.c","r");
   if(yyparse()==0)
   {
      printf("parsing successful");
   }
   else
   {
      printf("parsing unsuccessful");
   }
   return 0;
}

       







