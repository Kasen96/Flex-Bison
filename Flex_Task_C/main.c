#include <stdio.h>
#include "task2.tab.h"

void yyerror(const char *c)
{
    printf("Error: %s\n", c);
}



int main(int argc, char* argv[])
{
    yyparse();
    return 0;
}