%{
    #include "main.h"
%}

%token <string> TOKNL
%token <string> TOKTEXT
%token <string> TOKSEMI
%token <string> TOKPIPE
%token <string> TOKSPACE
%token <string> TOKVAR
%token <string> TOKQUOTE

%type <string> commands
%type <string> command

%%
commands: %empty {}
        | commands command
        ;

command : TOKNL { cout << "NL" << endl; }
        | TOKPIPE { cout << "Pipe" << endl; }
        | TOKSEMI { cout << "Semi" << endl; }
        | TOKSPACE { cout << "Blank " << strlen(yytext) << " chars" << endl; }
        | TOKVAR { cout << "Var ->" << yytext << "<-" << endl; }
        | TOKQUOTE { cout << "Quoted ->" << yytext << "<-" << endl; }
        | TOKTEXT { cout << "Text ->" << yytext << "<-" << endl; }
        ;
%%