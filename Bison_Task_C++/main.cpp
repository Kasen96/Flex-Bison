#include "main.h"
#include "node.h"

extern Node root;

void yy::parser::error(const string &err)
{
    cout << "Error: " << err << endl;
}

int main(int argc, char **argv)
{
    yy::parser parser;
    parser.parse();
    cout << "Built a parse-tree:" << endl;
    root.dump(0);
    return 0;
}
