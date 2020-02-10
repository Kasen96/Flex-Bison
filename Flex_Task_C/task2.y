%{
    #include <stdio.h>
    #include <string.h>
    void yyerror(const char *c); /* Supress C99 warning */
    int yylex();                 /* Supress C99 warning on OSX */
    extern char *yytext;         /* Correct for Flex */
%}

%token TOKNL TOKSEMI TOKPIPE TOKSPACE TOKVAR TOKTEXT TOKQUOTE

%%
commands:
        | commands command
        ;

command : TOKNL    { printf("NL\n"); }
        | TOKPIPE  { printf("Pipe\n"); }
        | TOKSEMI  { printf("Semi\n"); }
        | TOKSPACE { printf("Blank %zu chars\n", strlen(yytext)); }
        | TOKVAR   { printf("Var ->%s<-\n", yytext); }
        | TOKQUOTE { printf("Quoted ->%s<-\n", yytext); }
        | TOKTEXT  { printf("Text ->%s<-\n", yytext); }
        ;
%%