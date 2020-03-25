%skeleton "lalr1.cc"
%language "c++"
%defines
%define api.value.type variant
%define api.token.constructor

%code requires{
    #include "node.h"
}

%code{
    #include "main.h"
    Node root;
}

%token <std::string> NEWL SEMI PIPE SPACE TEXT VAREXP QUOTE
%token END 0 "end of file"

%type <Node> stream optline anything command concatenate

%%
stream : optline      { $$ = Node("stream", ""); $$.children.push_back($1); root = $$; }
       | stream NEWL optline { $$ = $1; $$.children.push_back($3); root = $$; }
       ;

optline : /* empty */ { $$ = Node("optline", "empty"); }
        | command     { $$ = Node("optline", "has line"); $$.children.push_back($1); }
        ;

command : anything { $$ = Node("command", ""); $$.children.push_back($1); }
        | command anything { $$ = $1; $$.children.push_back($2); }
        | command SPACE concatenate SPACE { $$ = $1; $$.children.push_back($3); }
        ;

concatenate : anything { $$ = Node("concatenate", ""); $$.children.push_back($1); }
            | concatenate anything { $$ = $1; $$.children.push_back($2); }
            ;

anything : TEXT     { $$ = Node("WORD", $1); }
         | QUOTE    { $$ = Node("QUOTED", $1); }
         | VAREXP   { $$ = Node("VAREXP", $1); }
         ;

%%
