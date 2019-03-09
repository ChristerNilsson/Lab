#include <iostream>
#include <ctime>

using namespace std;

// uint64_t fib(int n) {
// 	if (n < 2) {
// 		return 1;
// 	} else {
// 		return fib(n - 1) + fib(n - 2);
// 	}
// }  

uint64_t fib(int n) {
	uint64_t a=1,b=1;

	for (int i=0; i<n; i++) {
		uint64_t tmp = a;
		a = b;
		b = tmp+b;
	}
	return a;
}


int main() {
	int start = clock();
	uint64_t z = 0;
	for (int i=0; i<1000000000; i++) {
		z=fib(46);
	}
	cout << z << ' ';
	cout << clock()-start;
}
