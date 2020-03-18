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