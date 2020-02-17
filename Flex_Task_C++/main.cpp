#include "main.h"

void yy::parser::error(const string &err)
{
    cout << "Error: " << err << endl;
}

int main(int argc, char **argv)
{
    yy::parser parser;
    parser.parse();
    return 0;
}