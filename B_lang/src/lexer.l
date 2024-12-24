%{
#include "parser.tab.h"
#include <string>
#include <cstdlib>

void yyerror(const char *s);
%}

%option yylineno

digit       [০-৯]
bengali_alpha [অ-ঔক-হড়-ঢ়য়]
identifier  {bengali_alpha}+({bengali_alpha}|{digit})*

%%

"সামিল"      { return T_INCLUDE; }
"প্রধান"     { return T_MAIN; }
"ছাপাও"     { return T_PPRINTF; }

"পুন"        { return T_INT; }
"দশমি"      { return T_FLOAT; }
"যদি"       { return T_IF; }
"বাযদি"     { return T_ELSEIF; }
"নয়তো"     { return T_ELSE; }
"কর"        { return T_DO; }
"যখন"      { return T_WHILE; }
"বারবার"    { return T_FOR; }

"+"         { return T_PLUS; }
"*"         { return T_STAR; }
"-"         { return T_MINUS; }
"/"         { return T_SLASH; }
"%"         { return T_PERCENT; }
"&&"        { return T_AND; }
"||"        { return T_OR; }
"=="        { return T_EQ; }
"<"         { return T_LT; }
">"         { return T_GT; }
"!="        { return T_NEQ; }
"="         { return T_ASSIGN; }

";"         { return T_SEMICOLON; }
","         { return T_COMMA; }

"%প"        { return T_INT_FORMAT; }
"%দ"        { return T_FLOAT_FORMAT; }

"/*"        {
                int c;
                while ((c = yyinput()) != 0) {
                    if (c == '*' && yyinput() == '/')
                        break;
                    else
                        yyless(1);
                }
            }
"//".*      ;

"\""([^"\\]|\\.)*"\"" {
    yylval.sval = new std::string(yytext + 1, yyleng - 2);
    return T_STRING_LITERAL;
}

{digit}+     { yylval.ival = std::stoi(yytext); return T_INTEGER_LITERAL; }
{digit}+\.{digit}+  { yylval.fval = std::stof(yytext); return T_FLOAT_LITERAL; }
{identifier} { yylval.sval = new std::string(yytext); return T_IDENTIFIER; }

[ \t\n]+    ; /* Ignore whitespace */
.           { yyerror("Unknown character"); }

%%

int yywrap() {
    return 0;
}