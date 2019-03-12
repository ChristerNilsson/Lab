#include <iostream>
#include <algorithm>
#include <stack>
#include <iterator>
#include <fstream>
#include <string>
#include <sstream>
#include <ctime>
#include <chrono>
#include <vector>
#include <iomanip>

using namespace std;

// Object Oriented Solution

vector<string> split(string s) {
	stringstream ss(s);
	istream_iterator<string> begin(ss);
	istream_iterator<string> end;
	vector<string> vstrings(begin, end);
	return vstrings;
}

class Node {

public:
	char kind;
	float resistance;
	float voltage;
	Node * a;
	Node * b;

	Node(char k, float r) {
		kind = k;
		resistance = r;
	}
	Node(char k, Node * _a, Node * _b) {
		kind = k;
		a = _a;
		b = _b;
	}
	float current() {return voltage/resistance;}
	float effect() {return current() * voltage;}

	void report(string level="") {
		cout << fixed;
		cout.precision(3);
		cout << setw(8) << resistance << setw(8) << voltage << setw(8) << current() << setw(8) << effect() << '  ' << level << kind << "\n";
		if (kind=='s' || kind=='p') {
			a->report(level + "| ");
			b->report(level + "| ");
		}
	}

	float evalR() {
		if (kind=='s') resistance = a->evalR() + b->evalR();
		if (kind=='p') resistance = 1 / (1/a->evalR() + 1/b->evalR());
		return resistance;
	}

	void setVoltage(float v) {
		voltage = v;
		if (kind=='s') {
			float ra = a->resistance;
			float rb = b->resistance;
			a->setVoltage(ra/(ra+rb)*voltage);
			b->setVoltage(rb/(ra+rb)*voltage);
		} 
		if (kind=='p') {
			a->setVoltage(voltage);
			b->setVoltage(voltage);
		}
	}
};

Node * build(float voltage, string s) {
	stack<Node*> stk;
	vector<string> arr = split(s);
	for (int i=0; i < arr.size(); i++) {
		string word = arr[i];

		if (word=="s" || word=="p") {
			int n = stk.size();
			Node * a = stk.top();
			stk.pop(); 
			Node * b = stk.top(); 
			stk.pop(); 
			stk.push(new Node(word[0],a,b));
		} else {
			stk.push(new Node('r',stof(word)));
		}
	}

	int n = stk.size();
	Node * node = stk.top();
	stk.pop();
	node->evalR();
	node->setVoltage(voltage);
	return node;
}

//let node = build(12.0, "8")
//let node = build(12.0, "8 10 s")
//let node = build(12.0, "3 12 p")
//let node = build(12.0, "8 4 s 12 p 6 s")

int main() {
	Node * node;
	std::chrono::steady_clock::time_point time_begin = std::chrono::steady_clock::now();
	for (int i=0; i<1000000; i++) {
		node = build(18.0, "10 2 s 6 p 8 s 6 p 4 s 8 p 4 s 8 p 6 s");
	}
	std::chrono::steady_clock::time_point time_end = std::chrono::steady_clock::now();
	int diff = std::chrono::duration_cast<std::chrono::microseconds>(time_end - time_begin).count();
	cout << ' ' << ' ' << diff/1000000.0 << "\n"; 

	cout << "     Ohm    Volt  Ampere    Watt  Network tree\n";
	node->report();
}
