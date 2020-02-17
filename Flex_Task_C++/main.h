#ifndef MAIN_H
#define MAIN_H

#include <iostream>
#include <string>
#include "task2.tab.hh"

#define YY_DECL yy::parser::symbol_type yylex()

using std::cout;
using std::endl;
using std::string;

#endif