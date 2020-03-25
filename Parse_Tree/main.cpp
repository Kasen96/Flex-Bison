#include "main.h"
#include "node.h"

#include <fstream>
//#include <cstdlib>

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

    std::ofstream outfile;
    outfile.open("parse-tree.dot", std::ios::out);

    string data;
    data = "digraph {\n";

    root.dumpDigraph(1, data);

    data += "}";
    outfile << data << endl;
    outfile.close();

    //system("dot -T pdf example.dot -o example.pdf");

    string fileName = "parse-tree";
    string cmd = "dot -T pdf " + fileName + ".dot -o " + fileName + ".pdf";
    const char *sysCmd = cmd.data();
    FILE *fp = popen(sysCmd, "r");
    if (!fp)
    {
        return 1;
    }
    pclose(fp);

    return 0;
}
