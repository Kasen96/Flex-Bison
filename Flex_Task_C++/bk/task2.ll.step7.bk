%top{
    #include "main.h"
}

%x VARIABLE QUOTE

%option noyywrap nounput batch noinput stack

TEXT [^'\|;\$\n \t]|(\\\;)|(\\\|)|(\\\\)|(\\[ ])
QUOTETEXT [ \ta-zA-Z\$\|;]

%%
'                   { BEGIN(QUOTE); }
<QUOTE>{QUOTETEXT}+ { return yy::parser::make_QUOTE(yytext); }
<QUOTE>'            { BEGIN(0); }

\$                 { yy_push_state(VARIABLE); }
<VARIABLE>{TEXT}+  { yy_pop_state(); 
                     return yy::parser::make_VAR(yytext); }

\|          { return yy::parser::make_PIPE(yytext); }
;           { return yy::parser::make_SEMI(yytext); }
\n          { return yy::parser::make_NL(yytext); }
[ \t]+      { return yy::parser::make_SPACE(yytext); }
{TEXT}+     { return yy::parser::make_TEXT(yytext); }
<<EOF>>     { return yy::parser::make_END(); }
%%