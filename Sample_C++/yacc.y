
%{
/*
本 yacc 的生成文件是 yacc.tab.c 和 yacc.tab.h
yacc 文件由 3 段组成，用 2 个 %% 行把这 3 段隔开。
第 1 段是声明段，包括：
1 - C 代码部分：include 头文件、函数、类型等声明，这些声明会原样拷到生成的 .c 文件中。
2 - 记号声明，如 %token
3 - 类型声明，如 %type
第 2 段是规则段，是 yacc 文件的主体，包括每个产生式是如何匹配的，以及匹配后要执行的 C 代码动作。
第 3 段是 C 函数定义段，如 yyerror() 的定义，这些 C 代码会原样拷到生成的 .c 文件中。该段内容可以为空
*/
 
// 第 1 段：声明段
#include "main.h" // lex 和 yacc 要共用的头文件，里面包含了一些头文件，重定义了 YYSTYPE
 
// 为了能够在 C++ 程序里面调用 C 函数，必须把每一个需要使用的 C 函数，其声明都包括在 extern "C"{} 块里面，这样 C++ 链接时才能成功链接它们。
// extern "C" 用来在 C++ 环境下设置 C 链接类型。
extern "C" 
{	// lex.l 中也有类似的这段 extern "C"，可以把它们合并成一段，放到共同的头文件 main.h 中
	void yyerror(const char *s);
	extern int yylex(void); // 该函数是在 lex.yy.c 里定义的，yyparse() 里要调用该函数，为了能编译和链接，必须用 extern 加以声明
}
 
%}
 
/*
lex 里要 return 的记号的声明
用 token 后加一对 <member> 来定义记号，旨在用于简化书写方式。
假定某个产生式中第 1 个终结符是记号 OPERATOR，则引用 OPERATOR 属性的方式：
1 - 如果记号 OPERATOR 是以普通方式定义的，如 %token OPERATOR，则在动作中要写 $1.m_cOp，以指明使用 YYSTYPE 的哪个成员
2 - 用 %token<m_cOp>OPERATOR 方式定义后，只需要写 $1，yacc 会自动替换为 $1.m_cOp
另外用 <> 定义记号后，非终结符如 file, tokenlist，必须用 %type<member> 来定义(否则会报错)，以指明它们的属性对应 YYSTYPE 中哪个成员，这时对该非终结符的引用，如 $$，会自动替换为 $$.member
*/
%token<m_nInt>INTEGER
%token<m_sId>IDENTIFIER
%token<m_cOp>OPERATOR

%type<m_sId>file
%type<m_sId>tokenlist
 
%%
 
file:	// 文件，由记号流组成
    tokenlist	// 这里仅显示记号流中的 ID
	{
        // $1 是非终结符 tokenlist 的属性，由于该终结符是用 %type<m_sId> 定义的，即约定对其用 YYSTYPE 的 m_sId 属性，$1 相当于 $1.m_sId，其值已经在下层产生式中赋值(tokenlist IDENTIFIER)
		cout << "all id:" << $1 << endl;	
	}
    ;
tokenlist: // 记号流，或者为空，或者由若干数字、标识符、及其它符号组成
	{
		
	}
	| tokenlist INTEGER
	{
        // $2 是记号 INTEGER 的属性，由于该记号是用 %token<m_nInt> 定义的，即约定对其用 YYSTYPE 的 m_nInt 属性，$2 会被替换为 yylval.m_nInt，已在 lex 里赋值
		cout << "int: "<< $2 << endl; 
	}
	| tokenlist IDENTIFIER
	{
        // $$ 是非终结符 tokenlist 的属性，由于该终结符是用 %type<m_sId> 定义的，即约定对其用 YYSTYPE 的 m_sId 属性，$$ 相当于 $$.m_sId，这里把识别到的标识符串保存在 tokenlist 属性中
		$$ += " " + $2;
        // $2 是记号 IDENTIFIER 的属性，由于该记号是用 %token<m_sId> 定义的，即约定对其用 YYSTYPE 的 m_sId 属性，$2 会被替换为 yylval.m_sId，已在 lex 里赋值
		cout << "id: " << $2 << endl; 
	}
	| tokenlist OPERATOR
	{
        // $2 是记号 OPERATOR 的属性，由于该记号是用 %token<m_cOp> 定义的，即约定对其用 YYSTYPE 的 m_cOp 属性，$2 会被替换为 yylval.m_cOp，已在 lex 里赋值
		cout << "op: " << $2 << endl;
	};
 
%%
 
void yyerror(const char *s)	// 当 yacc 遇到语法错误时，会回调 yyerror 函数，并且把错误信息放在参数 s 中
{
	std::cerr << s << endl; // 直接输出错误信息
}
 
int main() // 程序主函数，这个函数也可以放到其它 .c, .cpp 文件里
{
	const char* sFile = "file.txt"; // 打开要读取的文本文件
	FILE* fp = fopen(sFile, "r");
	if (fp == NULL)
	{
		printf("cannot open %s\n", sFile);
		return -1;
	}
	extern FILE* yyin;	// yyin 和 yyout 都是 FILE* 类型
	yyin=fp; // yacc 会从 yyin 读取输入，yyin 默认是标准输入，这里改为磁盘文件。yacc 默认向 yyout 输出，可修改 yyout 改变输出目的
 
	printf("-----begin parsing %s\n", sFile);
	yyparse(); // 使 yacc 开始读取输入和解析，它会调用 lex 的 yylex() 读取记号
	puts("-----end parsing");
 
	fclose(fp);
 
	return 0;
}

