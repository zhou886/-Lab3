#include <stdio.h>
int main() {
    printf("hello world");
    int a=123u,b=0214,c=0x12345u;
    for (int i=0;i<a;i++) {
        printf("%d %d\n",b+c-i);
    }
    return 0;
}