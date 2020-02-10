parser: lex.yy.c task2.tab.h main.c
	gcc -o parser task2.tab.c lex.yy.c main.c
task2.tab.h: task2.y
	bison -d task2.y
lex.yy.c: task2.l task2.tab.h
	flex task2.l
clean:
	rm lex.yy.c parser task2.tab.c task2.tab.h