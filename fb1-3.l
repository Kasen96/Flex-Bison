/* Identify the tokens used in the calculator and output them */

/* flex fb1-3.l */
/* cc lex.yy.c -lfl */
/* ./a.out */
/* ^D */

%%
"+"     { printf("PLUS\n"); }
"-"     { printf("MINUS\n"); }
"*"     { printf("TIMES\n"); }
"/"     { printf("DIVIDE\n"); }
"|"     { printf("ABS\n"); }
[0-9]+  { printf("NUMBER %s\n", yytext); }
\n      { printf("NUWLINE\n"); }
[ \t]   { }
.       { printf("Mystery character %s\n", yytext); }
%%