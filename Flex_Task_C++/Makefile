LEX = flex
YACC = bison
CC = g++
OBJECT = parser

$(OBJECT): lex.yy.c task2.tab.o main.cpp
	$(CC) lex.yy.c task2.tab.o main.cpp -o $(OBJECT)

task2.tab.o: task2.tab.cc
	$(CC) -c task2.tab.cc

task2.tab.cc: task2.yy
	$(YACC) -d task2.yy

lex.yy.c: task2.ll task2.tab.cc
	$(LEX) task2.ll

clean:
	@rm $(OBJECT) lex.yy.c* task2.tab.*