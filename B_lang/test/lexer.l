%{
#include <stdio.h>
#include <stdlib.h>
#include <FlexLexer.h>

void yyerror(const char *s);

// Define YY_INPUT to read from a file with UTF-8 handling
#undef YY_INPUT
#define YY_INPUT(buf, result, max_size) \
    { \
        int c = fgetc(yyin); \
        if (c == EOF) { \
            result = YY_NULL; \
        } else { \
            result = 1; \
            *buf = (char)c; \
        } \
    }
%}

%option yylineno

digit       [০-৯]
bengali_alpha [অ-ঔক-হড়-ঢ়য়]
identifier  {bengali_alpha}+({bengali_alpha}|{digit})*

%%

"পুন"        { printf("T_INT: %s\n", yytext); }
"দশমি"      { printf("T_FLOAT: %s\n", yytext); }
"যদি"       { printf("T_IF: %s\n", yytext); }
"বাযদি"     { printf("T_ELSEIF: %s\n", yytext); }
"নয়তো"     { printf("T_ELSE: %s\n", yytext); }
"কর"        { printf("T_DO: %s\n", yytext); }
"যখন"      { printf("T_WHILE: %s\n", yytext); }
"বারবার"    { printf("T_FOR: %s\n", yytext); }
"প্রধান"     { printf("T_MAIN: %s\n", yytext); }
"ছাপাও"     { printf("T_PPRINTF: %s\n", yytext); }

"+"         { printf("T_PLUS: %s\n", yytext); }
"*"         { printf("T_STAR: %s\n", yytext); }
"-"         { printf("T_MINUS: %s\n", yytext); }
"/"         { printf("T_SLASH: %s\n", yytext); }
"%"         { printf("T_PERCENT: %s\n", yytext); }
"&&"        { printf("T_AND: %s\n", yytext); }
"||"        { printf("T_OR: %s\n", yytext); }
"=="        { printf("T_EQ: %s\n", yytext); }
"<"         { printf("T_LT: %s\n", yytext); }
">"         { printf("T_GT: %s\n", yytext); }
"!="        { printf("T_NEQ: %s\n", yytext); }
"="         { printf("T_ASSIGN: %s\n", yytext); }
"++"        { printf("T_INCREMENT: %s\n", yytext); }
"--"        { printf("T_DECREMENT: %s\n", yytext); }

";"         { printf("T_SEMICOLON: %s\n", yytext); }
","         { printf("T_COMMA: %s\n", yytext); }

"%প"        { printf("T_INT_FORMAT: %s\n", yytext); }
"%দ"        { printf("T_FLOAT_FORMAT: %s\n", yytext); }

"("         { printf("T_LPAREN: %s\n", yytext); }
")"         { printf("T_RPAREN: %s\n", yytext); }
"{"         { printf("T_LBRACE: %s\n", yytext); }
"}"         { printf("T_RBRACE: %s\n", yytext); }

"/*"        {
                int c;
                while ((c = yyinput()) != 0) {
                    if (c == '*' && yyinput() == '/')
                        break;
                    else
                        yyless(1);
                }
                printf("T_COMMENT_BLOCK: /* ... */\n");
            }
"//".*      { printf("T_COMMENT_LINE: // ...\n"); }

[ \t\n]+    { /* Ignore whitespace */ }

{digit}+     { printf("T_INTEGER_LITERAL: %s\n", yytext); }
{digit}+\.{digit}+  { printf("T_FLOAT_LITERAL: %s\n", yytext); }
{identifier} { printf("T_IDENTIFIER: %s\n", yytext); }
"\""([^"\\]|\\.)*"\"" { printf("T_STRING_LITERAL: %s\n", yytext); }

.           { printf("T_UNKNOWN: %s\n", yytext); } // This should be the last rule

%%

int yywrap() {
    return 1; // Indicate no more input
}

void yyerror(const char *s) {
  fprintf(stderr, "Lexing Error: %s at line %d\n", s, yylineno);
}

int main() {
    yyin = fopen("input.b", "r");
    if (!yyin) {
        perror("Error opening input.b");
        return 1;
    }

    while (yylex());
    fclose(yyin);
    return 0;
}