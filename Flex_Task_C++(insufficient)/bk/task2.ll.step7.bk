%top{
    #include "main.h"
}

%option noyywrap nounput batch noinput stack

%x VARIABLE QUOTE

TEXT [^'\|;\$\n \t]|(\\\;)|(\\\|)|(\\\\)|(\\[ ])
QUOTETEXT [ \ta-zA-Z\$\|;]

%%
'                   { BEGIN(QUOTE); }
<QUOTE>{QUOTETEXT}+ { return TOKQUOTE; }
<QUOTE>'            { BEGIN(0); }

\$                  { yy_push_state(VARIABLE); }
<VARIABLE>{TEXT}+   { yy_pop_state(); return TOKVAR; }

\|           { return TOKPIPE; }
\n           { return TOKNL; }
;            { return TOKSEMI; }
[ \t]+       { return TOKSPACE; }
{TEXT}+      { return TOKTEXT; }
%%