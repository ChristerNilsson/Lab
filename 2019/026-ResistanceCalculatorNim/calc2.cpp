#include <iostream>
#include <stack>
#include <iterator>
#include <string>
#include <chrono>
#include <vector>
#include <iomanip>

using namespace std;

// static version, no pointers

class Node;

vector<Node> nodes(50); 
int nodestop = -1;

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
	int a;
	int b;

	Node() {
		kind = ' ';
		resistance = -1;
		a = -1;
		b = -1;		
	}
	Node(char k, float r) {
		kind = k;
		resistance = r;
	}
	Node(char k, int _a, int _b) {
		kind = k;
		a = _a;
		b = _b;
	}
	float current() {return voltage/resistance;}
	float effect() {return current() * voltage;}

	void update(char k, float r) {
		kind = k;
		resistance = r;		
	}
	void update(char k, int _a, int _b) {
		kind = k;
		a = _a;
		b = _b;
	}

	void dump(int nodestop) {
		cout << nodestop << setw(8) << resistance << setw(8) << voltage << setw(8) << current() << setw(8) << effect() << ' ' << kind << "\n";
	}

	void report(string level="") {
		cout << fixed;
		cout.precision(3);
		cout << setw(8) << resistance << setw(8) << voltage << setw(8) << current() << setw(8) << effect() << ' ' << level << kind << "\n";
		if (kind=='s' || kind=='p') {
			nodes[a].report(level + "| ");
			nodes[b].report(level + "| ");
		}
	}

	float evalR() {
		if (kind=='s') resistance = nodes[a].evalR() + nodes[b].evalR();
		if (kind=='p') resistance = 1 / (1/nodes[a].evalR() + 1/nodes[b].evalR());
		return resistance;
	}

	void setVoltage(float v) {
		voltage = v;
		if (kind=='s') {
			float ra = nodes[a].resistance;
			float rb = nodes[b].resistance;
			nodes[a].setVoltage(ra/(ra+rb)*voltage);
			nodes[b].setVoltage(rb/(ra+rb)*voltage);
		} 
		if (kind=='p') {
			nodes[a].setVoltage(voltage);
			nodes[b].setVoltage(voltage);
		}
	}
};

Node build(float voltage, string s) {
	nodestop  = -1;
	stack<int> stk;
	vector<string> arr = split(s);

	for (string word : arr) {

		if (word=="s" || word=="p") {
			int a = stk.top();
			stk.pop(); 
			int b = stk.top(); 
			stk.pop();

			nodestop++;
			nodes[nodestop].update(word[0],a,b);
			stk.push(nodestop);
		} else {
			nodestop++;
			nodes[nodestop].update('r',stof(word));
			stk.push(nodestop);
		}
	}

	int index = stk.top();
	stk.pop();
	nodes[index].evalR();
	nodes[index].setVoltage(voltage);
	return nodes[index];
}

//let node = build(12.0, "8")
//let node = build(12.0, "8 10 s")
//let node = build(12.0, "3 12 p")
//let node = build(12.0, "8 4 s 12 p 6 s")

int main() {
	for (int i=0; i<50; i++) nodes[i] = Node();
	Node node;
	std::chrono::steady_clock::time_point time_begin = std::chrono::steady_clock::now();
	for (int i=0; i<1000000; i++) {
		node = build(18.0, "10 2 s 6 p 8 s 6 p 4 s 8 p 4 s 8 p 6 s");
	}
	std::chrono::steady_clock::time_point time_end = std::chrono::steady_clock::now();
	int diff = std::chrono::duration_cast<std::chrono::microseconds>(time_end - time_begin).count();
	cout << ' ' << ' ' << diff/1000000.0 << "\n"; 

	cout << "     Ohm    Volt  Ampere    Watt Network tree\n";
	node.report();
}
