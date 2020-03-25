#include "node.h"

// class Node

Node::Node() // Bison needs this
{
    tag = "uninitialised";
    value = "uninitialised";
}

Node::Node(string t, string v) : tag(t), value(v) {}

void Node::dump(int depth = 0)
{
    for (int i = 0; i < depth; i++)
    {
        cout << "  ";
    }
    cout << tag << ":" << value << endl;
    for (auto i = children.begin(); i != children.end(); i++)
    {
        (*i).dump(depth + 1);
    }
}

void Node::dumpDigraph(int count, string &data)
{
    static int number = count;
    if (!children.empty())
    {
        data += std::to_string(count) + " [label=\"" + tag + ":" + value + "\"];\n";
        for (auto i = children.begin(); i != children.end(); i++)
        {
            data += std::to_string(count) + " -> " + std::to_string(++number) + ";\n";
            (*i).dumpDigraph(number, data);
        }
    }
    else
    {
        data += std::to_string(count) + " [label=\"" + tag + "\"];\n";
        data += tag + std::to_string(count) + " [label=\"" + value + "\"];\n";
        data += std::to_string(count) + " -> " + tag + std::to_string(count) + ";\n";
    }
}
