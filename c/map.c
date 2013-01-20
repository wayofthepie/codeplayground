#include <stdio.h>

void map(void (*func)(void *), void *, int);
void addOne(void *);

int main() {
    int size = 10;
    int list[10] = {1,2,3,4,5,6,7,8,9,10};  
    
    map((void (*)(void *)) (addOne), list, size);
    
    for(int i = 0; i < size; i++) {
        printf("%d\n", list[i]);
    }    
    
    return 0;
}

void map(void (*func)(void *), void *list, int size) {
    
    for(int i = 0; i < size; i++) {
        (*func)((int *)list + i);
    }
   
}

void addOne(void *num) {
    printf("Num = %d\n", *(int *)num);
    int *numToInc = (int *)num; 
    *numToInc=*numToInc + 1;
}