#ifndef MAIN_HPP
#define MAIN_HPP
 
#include <iostream> 
#include <string>
#include <stdio.h> // printf 和 FILE 要用的

using std::string;
using std::cout;
using std::endl;
 
/* 
当 lex 每识别出一个记号后，是通过变量 yylval 向 yacc 传递数据的。默认情况下 yylval 是 int 类型，也就是只能传递整型数据。
yylval 是用 YYSTYPE 宏定义的，只要重定义 YYSTYPE 宏，就能重新指定 yylval 的类型(可参见 yacc 自动生成的头文件 yacc.tab.h)。
在我们的例子里，当识别出标识符后要向 yacc 传递这个标识符串，yylval 定义成整型不太方便(要先强制转换成整型，yacc 里再转换回 char*)。
这里把 YYSTYPE 重定义为 struct Type，可存放多种信息
*/
struct Type // 通常这里面每个成员，每次只会使用其中一个，一般是定义成union以节省空间(但这里用了string等复杂类型造成不可以)
{
	string m_sId;
	int m_nInt;
	char m_cOp;
};


 
#define YYSTYPE Type // 把 YYSTYPE (即 yylval 变量)重定义为 struct Type 类型，这样 lex 就能向 yacc 返回更多的数据了

#endif
