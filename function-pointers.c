#include <stdio.h>

int doSomething(int *parOne, int *parTwo, int (*func)(int *, int *)) {    
	return (*func)(parOne,parTwo);
}

int add(int *numOne, int *numTwo) {
	printf("Add...\n");
	return *numOne + *numTwo;
}

int subtract(int *numOne, int *numTwo) {
	printf("Subtract...\n");
	return *numOne - *numTwo;
}

int main() {
	int x = 5;
	int y = 5;
    int z = doSomething(&x,&y,(int (*)(int *,int *)) (add));
    printf( "%d\n", z );
    return 0;
}