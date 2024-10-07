%{
#include "y.tab.h"
%}

%%
^"#include".*[\n] {return INCLUDE;}
[\t ] { }
[\n ] {yylineno++;}
"int" {return TYPE;}
"float" {return TYPE;}
"char" {return TYPE;}
"double" {return TYPE;}
"printf" {return PRINTF;}
"return" {return RETURN;}
"void" {return VOID;}
"//".*[\n] { }
"/*"[.|\n]*"*/" { }
"," {return ',';}
";" {return ';';}
"(" {return '(';}
")" {return ')';}
"{" {return '{';}
"}" {return '}';}
[_a-zA-Z][_a-zA-Z0-9]*  {return IDENTIFIER;}
[0-9]+ {return NUM;}
"=" {return '=';}
[+\-*/] {return BASIC_OP;}
\"(\\.|[^\\"])*\" {return STRING_LIT;}
. {return yytext[0];}
%%

int yywrap()
{
   return 1;
}


