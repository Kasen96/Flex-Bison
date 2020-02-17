#include "main.h"

void yyerror(const char *s)
{
    std::cerr << s << endl;
}

int main(int argc, char **argv)
{
    yyparse();
}