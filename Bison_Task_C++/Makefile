LEX = flex
YACC = bison
CC = g++
OBJECT = parser

$(OBJECT): lex.yy.c task3.tab.o main.cpp node.cpp
	$(CC) task3.tab.o lex.yy.c main.cpp node.cpp -o $(OBJECT)

task3.tab.o: task3.tab.cc
	$(CC) -c task3.tab.cc

task3.tab.cc: task3.yy
	$(YACC) -d task3.yy

lex.yy.c: task3.ll task3.tab.cc
	$(LEX) task3.ll

clean:
	@rm task3.tab.* lex.yy.c* stack.hh $(OBJECT)