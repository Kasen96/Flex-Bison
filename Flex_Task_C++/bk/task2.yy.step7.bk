%skeleton "lalr1.cc" 
%defines
%define api.value.type variant
%define api.token.constructor

%code{
    #include "main.h"
    YY_DECL;
}

%token <std::string> NL
%token <std::string> PIPE
%token <std::string> SEMI
%token <std::string> SPACE
%token <std::string> VAR
%token <std::string> QUOTE
%token <std::string> TEXT
%token END 0 "end of file"

%type <std::string> commands
%type <std::string> command

%%
commands: {}
        | commands command
        ;

command : NL     { cout << "NL" << endl; }
        | PIPE   { cout << "Pipe" << endl; }
        | SEMI   { cout << "Semi" << endl; }
        | SPACE  { cout << "Blank " << $1.length() << " chars" << endl; }
        | VAR    { cout << "Var ->" << $1 << "<-" << endl; }
        | QUOTE  { cout << "Quoted ->" << $1 << "<-" << endl; }
        | TEXT   { cout << "Text ->" << $1 << "<-" << endl; }
        ;
%%
