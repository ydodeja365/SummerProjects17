#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>

long long int fun(long long int);
long long int power(long long int,long long int,long long int);

int main() {

    long long int T, N, temp=0, ans;
    scanf("%lld", &T);
    while(temp<T)
        {
         scanf("%lld", &N); 
         printf("%lld\n", fun(N));
         temp++;
        }
    return 0;
}

long long int fun (long long int N)
    { 
     long long int ans;
     ans = (-4*power(-1,N-1,1000000007)+7*power(2,N-1,1000000007))*power(3,1000000007-2,1000000007);
     return ans%1000000007;
}

long long int power (long long int a, long long int N, long long int p)
    {
    long long int result = 1;
    while (N > 0)
    {
        if (N % 2 == 1)
            result = (result * a) % p;
        N = N>>1;
        a = (a * a) % p;
    }
    return result;
}

