%{
// This is our Lexical tokeniser 
// It should be compiled into cpp with :
// flex++ -d -otokeniser.cpp tokeniser.l 
// And then compiled into object with
// g++ -c tokeniser.cpp
// tokens can be read using lexer->yylex()
// lexer->yylex() returns the type of the lexicon entry (see enum TOKEN in tokeniser.h)
// and lexer->YYText() returns the lexicon entry as a string

#include "tokeniser.h"
#include <iostream>

using namespace std;

%}

%option noyywrap
%option c++
%option yylineno

charconst  \'\\?.\'
ws      [ \t\n\r]+
alpha   [A-Za-z]
digit   [0-9]
number  {digit}+(\.{digit}+)?
id	{alpha}({alpha}|{digit})*
idArray {id}+\[({number}|{id})\]
addop	(\+|\-|\|\|)
mulop	(\*|\/|%|\&\&)
relop	(\<|\>|"=="|\<=|\>=|!=)
unknown [^\"A-Za-z0-9 \n\r\t\(\)\<\>\=\!\%\&\|\}\-\;\.]+
keyword ("IF"|"THEN"|"ELSE"|"WHILE"|"DO"|"FOR"|"TO"|"DOWNTO"|"BEGIN"|"END"|"CASE"|"OF"|"DISPLAY"|"VAR"|"INTEGER"|"BOOLEAN"|"DOUBLE"|"CHAR"|"TRUE"|"FALSE"|"ARRAY")


%%

{addop}		return ADDOP;
{mulop}		return MULOP;
{relop}		return RELOP;
{number}	return NUMBER;
{keyword}	return KEYWORD;
{id}		return ID;
{idArray}	return IDARRAY; 
{charconst}	return CHARCONST;
"["		return RBRACKET;
"]"		return LBRACKET;
","		return COMMA;
";"		return SEMICOLON;
"."		return DOT;
":="		return ASSIGN;
"("		return RPARENT;
")"		return LPARENT;
"!"		return NOT;
":"		return COLON;
<<EOF>>		return FEOF;
{ws}    {/* skip blanks and tabs */};
"(*"    { /* Skip comments between '(*' and '*)' */
		int c;
		while((c = yyinput()) != 0){
     			if(c == '*'){
     	    			if((c = yyinput()) == ')')
    	        			break;
    	     			else
  	          			unput(c);
  	   		}	
		}
	};

{unknown}	return UNKNOWN;

%%

