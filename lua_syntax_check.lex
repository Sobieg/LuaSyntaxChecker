%{
	#include <iostream>	
	#include "y.tab.h"
	void yyerror(char *s);
%}

%option yylineno
%option noyywrap

/*
for tests 
%option main
*/
multiline_string "[["(.|\n)*?"]]"
instring ([^\\\n"']|\\\n|\\["']|\\\\)*
id [a-zA-Z_]+[a-zA-Z0-9_]*
string ["']{instring}["']
fname {id}|({id}"."{id})+
idlist (({id})(" , "|" and "|" or ")*?)+
everylist (({id}|{multiline_string}|{string}|{fname})(" , "|" and "|" or ")*?)+
onesymb [-+*/%=<>().,{}]
whitespace [ \t\r\n]
int [0-9]+
double [0-9]"."[0-9]+


%%
"and"						{return AND;}
"break"						return BREAK;
"do"						return DO;
"else" 						return ELSE;
"elseif"					return ELSEIF;
"end"						return END;
"false" 					return FALSE;
"goto"						return GOTO;
"for"						return FOR;
"function"					return FUNCTION;
"if"						return IF;
"in"						return IN;
"local"						return LOCAL;
"nil"						return NIL;
"not" 						return NOT;
"or"						return OR;
"repeat"					return REPEAT;
"return"					return RETURN;
"then"						return THEN;
"true"						return TRUE;
"until"						return UNTIL;
"while"						return WHILE;
"~="						return NE;
"=="						return EQ;
"<+"						return LE;
">="						return GE;
".."						return CONC;
"..."						return DOTS;
{onesymb}					return *yytext;


"debug"						{	std::cout << "Debug switched" << std::endl;
								yydebug = yydebug?0:1;
							}

"#"{id}						{
								return NUM; //размер списка
							}


{int}					{	
								return NUM;
							}
{double}				{
								return NUM;
							}


{id}						{
								std::cout << "ID" << std::endl;
								return FID;
							}

{fname}						{
								std::cout << "FID" << std::endl;
								return FID;
							}
	




{string} 					{

								//std::cout << "STRING" << std::endl;
								return STRING;
							}

{multiline_string}			{
								//std::cout << "Multiline string" << std::endl;
								return STRING;
							}


"--"{multiline_string}	{
								//printf("Multiline comment\n");
								//return 0;
							}

"--".*?						{
								//printf("Singleline comment\n");
								//return 0;
							}


{whitespace} 				{}

.			 				{							
							//printf("%c", *yytext);
							return *yytext;	
							}
						
%%
