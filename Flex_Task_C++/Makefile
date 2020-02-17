LEX = flex
YACC = bison
CC = g++
OBJECT = parser

$(OBJECT): lex.yy.c task2.tab.o main.cpp
	$(CC) task2.tab.o lex.yy.c main.cpp -o $(OBJECT)

task2.tab.o: task2.tab.cc
	$(CC) -c task2.tab.cc

task2.tab.cc: task2.yy
	$(YACC) task2.yy

lex.yy.c: task2.ll task2.tab.cc
	$(LEX) task2.ll

clean:
	@rm task2.tab.* lex.yy.c* stack.hh $(OBJECT)