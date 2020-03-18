%top{
    #include "main.h"
    #include "node.h"
}

%x VARIABLE QUOTE

%option noyywrap nounput batch noinput stack

TEXT [^ \t\n;\|'\$\<\(\)]|(\\\;)|(\\\|)
QUOTETEXT [ \ta-zA-Z\$\|;^\.]

%%
'                    { BEGIN(QUOTE); }
<QUOTE>{QUOTETEXT}+  { return yy::parser::make_QUOTE(yytext); }
<QUOTE>'             { BEGIN(0); }

\<\(                           { return yy::parser::make_SUBHEAD(yytext); }
\)                             { return yy::parser::make_SUBTAIL(yytext); }

\$                 { yy_push_state(VARIABLE); }
<VARIABLE>{TEXT}+  { yy_pop_state(); return yy::parser::make_VAREXP(yytext); }

{TEXT}+      { return yy::parser::make_TEXT(yytext); }
[ \t]+       { return yy::parser::make_SPACE(yytext); }
\n           { return yy::parser::make_NEWL(yytext); }
;            { return yy::parser::make_SEMI(yytext); }
\|           { return yy::parser::make_PIPE(yytext); }
<<EOF>>      { return yy::parser::make_END(); }
%%