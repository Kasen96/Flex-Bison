#ifndef MAIN_H
#define MAIN_H

#define YYSTYPE int

#include <iostream>
#include <string>
#include "string.h"

#include "task2.tab.hh"

using std::string;
using std::cout;
using std::endl;

extern "C"
{
    int yylex(void);
    void yyerror(const char *s);
    extern char *yytext;
}

#endif