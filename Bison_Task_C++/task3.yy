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

%token <std::string> NEWL SEMI PIPE SPACE TEXT VAREXP QUOTE SUBHEAD SUBTAIL
%token END 0 "end of file"

%type <Node> stream optline line anything command subshell pipeline

%%
stream : optline      { $$ = Node("stream", ""); $$.children.push_back($1); root = $$; }
       | stream NEWL optline { $$ = $1; $$.children.push_back($3); root = $$; }
       ;

optline : /* empty */ { $$ = Node("optline", "empty"); }
        | line        { $$ = Node("optline", "has line"); $$.children.push_back($1); }
        ;

line : pipeline  { $$ = $1; }
     | line SEMI command { $$ = Node("line", ""); $$.children.push_back($1); $$.children.push_back($3); }
     ;

pipeline : command { $$ = $1; }
         | pipeline PIPE command { $$ = Node("pipeline", ""); $$.children.push_back($1); $$.children.push_back($3); }
         ;

command : anything { $$ = Node("command", ""); $$.children.push_back($1); }
        | SPACE anything { $$ = Node("command", ""); $$.children.push_back($2); }
        | command SPACE anything { $$ = $1; $$.children.push_back($3); }
        | command SPACE SUBHEAD subshell SUBTAIL { $$ = $1; $$.children.push_back($4); }
        ;
    
subshell : stream { $$ = Node("SUBSHELL", ""); $$.children.push_back($1); }
         ;

anything : TEXT     { $$ = Node("WORD", $1); }
         | QUOTE    { $$ = Node("QUOTED", $1); }
         | VAREXP   { $$ = Node("VAREXP", $1); }
         ;

%%
