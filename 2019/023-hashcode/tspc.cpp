#include <iostream>
#include <algorithm>
#include <vector>
#include <iterator>
#include <fstream>
#include <string>
#include <sstream>
#include <ctime>

using namespace std;

class Photo {
	public:
		int id;
		vector<string> tags;

		Photo(int id, vector<string> tags) {
			sort(tags.begin(),tags.end());    
			this->id = id;
			this->tags = tags;
			if (id<10) {
				for (int i=0; i<tags.size(); i++) {
					cout << tags[i] << " ";
				}
				cout << "\n";				
			}
		}
};
 
vector<Photo> PHOTOS = vector<Photo> {};
int n = 0;
vector<int> route = vector<int> {};
int totalScore = 0;
int start = 0;
int swaps = 0;
clock_t time_req = clock();

vector<string> split(string s) {
	stringstream ss(s);
	istream_iterator<string> begin(ss);
	istream_iterator<string> end;
	vector<string> vstrings(begin, end);
	return vstrings;
}

vector<string> setdifference (vector<string> first, vector<string> second) {
  vector<string> v(first.size()+second.size());
  vector<string>::iterator it;
  it = std::set_difference (first.begin(), first.end(), second.begin(), second.end(), v.begin());
  v.resize(it-v.begin());
  return v;
}

vector<string> setunion (vector<string> first, vector<string> second) {
  vector<string> v(first.size()+second.size());
  vector<string>::iterator it;
  it = std::set_union (first.begin(), first.end(), second.begin(), second.end(), v.begin());
  v.resize(it-v.begin());
  return v;
}

vector<string> setintersection (vector<string> first, vector<string> second) {
  vector<string> v(first.size()+second.size());
  vector<string>::iterator it;
  it = std::set_intersection (first.begin(), first.end(), second.begin(), second.end(), v.begin());
  v.resize(it-v.begin());
  return v;
}

void read () {
  string s;
	ifstream infile;
	infile.open("e.txt");
  getline(infile,s); // n
  for (int i=0; i < 80000; i++) {
    getline(infile,s); 
    vector<string> arr = split(s);
    arr.erase(arr.begin(), arr.begin()+2);
		PHOTOS.push_back(Photo(i, arr));
  }
	infile.close();
}

void save(string filename) {
  ofstream f;
  f.open(filename);
  f << 80000; 
  for (int i=0; i < 80000; i++) {
    f << route[i] << '\n'; 
  }
  f.close();
}

void dumptags(int id, vector<string> tags) {
	cout << id;
	for (int i=0; i<tags.size(); i++) {
		cout << ' ' << tags[i];
	}
	cout << "\n";
}

vector<string> set2(int i, int j) {	
	// assert i>=0
	// assert j>=0
	// assert i<len(self.route)
	// assert j<len(self.route)
	int id0 = route[i];
	int id1 = route[j];
	// assert id0 >= 0
	// assert id1 >= 0
	vector<string> s0 = PHOTOS[id0].tags;
	vector<string> s1 = PHOTOS[id1].tags;
	if (id0 < 5 && id1 < 5) {
		// dumptags(id0,s0);
		// dumptags(id1,s1);
		// dumptags(0,setunion(s0,s1));
	}
	return setunion(s0,s1);
}

int min3(int a, int b, int c) {
	int result = a;
	if (b<result) result=b;
	if (c<result) result=c;
	return result;
} 

int score1(vector<string>s, vector<string>t) {
	vector<string> a = setintersection(s,t);
	vector<string> b = setdifference(s,t);
	vector<string> c = setdifference(t,s);
	return min3(a.size(), b.size(), c.size());
}

int score4(int a,int b,int c,int d) {
	vector<string> s0 = set2(a,b);
	vector<string> s1 = set2(c,d);
	return score1(s0,s1);
}

int score6(int a,int b,int c,int d,int e,int f) {
	vector<string> s0 = set2(a,b); 
	vector<string> s1 = set2(c,d);
	vector<string> s2 = set2(e,f);
	return score1(s0,s1) + score1(s1,s2);
}

int swapscore(int i,int j) {
	//assert i%2==j%2
	if (i%2 == 0) { // even
		// slides: a0b0 c0d0
		// a0 = i - 2  // index to route to photo
		// b0 = i - 1
		// c0 = i
		// d0 = i + 1

		// slides: a1b1 c1d1
		// a1 = j - 2  // index to route to photo
		// b1 = j - 1
		// c1 = j
		// d1 = j + 1

		int xold = score4(i-2,i-1,i+0,i+1) + score4(j-2,j-1,j+0,j+1);
		int xnew = score4(i-2,i-1,j-1,j-2) + score4(i+1,i+0,j+0,j+1);
		return xnew - xold;
	} else { 
		// slides: a0b0 c0d0 e0f0
		int a0 = i - 3; // index to route to photo
		int b0 = i - 2;
		int c0 = i - 1;
		int d0 = i + 0;
		int e0 = i + 1;
		int f0 = i + 2;

		// slides: a1b1 c1d1 e1f1
		int a1 = j - 3;  // index to route to photo
		int b1 = j - 2;
		int c1 = j - 1;
		int d1 = j + 0;
		int e1 = j + 1;
		int f1 = j + 2;

		int xold = score6(a0,b0,c0,d0,e0,f0) + score6(a1,b1,c1,d1,e1,f1);
		int xnew = score6(a0,b0,c0,c1,b1,a1) + score6(f0,e0,d0,d1,e1,f1);
		return xnew - xold;
	}
}

int calc1(int i) {
	//assert i%2 == 0
	Photo photo0 = PHOTOS[route[i+0]];
	Photo photo1 = PHOTOS[route[i+1]];
	vector<string> s0 = setunion(photo0.tags,photo1.tags);
	Photo photo2 = PHOTOS[route[i+2]];
	Photo photo3 = PHOTOS[route[i+3]];
	vector<string> s1 = setunion(photo2.tags,photo3.tags);
	return score1(s0,s1);
}

int calc() {
	int result = 0;
	for (int i=0; i < 80000-2; i+=2) {
		result += calc1(i);
		//if (i<1000) cout << i << ' ' << result << "\n";
	};
	return result;
}

void swap(int i, int j) {
	//route[i:j] = route[j-1:i-1:-1]
	reverse(route.begin() + i, route.begin() + j);
} 

void opt(int i, int j) {
	int score = swapscore(i, j);
	if (score > 0) {
		swaps += 1;

		// print('before',self.totalScore, self.calc())
		// assert self.totalScore == self.calc()

		totalScore += score;
		swap(i, j);

		// print('after',self.totalScore, self.calc())
		// assert self.totalScore == self.calc()
	}
}

void two_opt() {
	swaps = 1;
	while (swaps > 0) {
		swaps = 0;
		for (int i=2; i < route.size()-4; i++) {
			cout << i << ' ' << totalScore << ' ' << (clock() - time_req)/CLOCKS_PER_SEC << "\n"; //, self.route[:64])
			for (int j=i+4; j < route.size()-2; j+=2) {
				opt(i,j);
				opt(i+1,j+1);
			}
		}
		save("e.cpp");
	}
}

void init() {
  for (int i=0; i < 80000; i++) {
		route.push_back(i);
  }
}	

int main() {
	read();
	init();
	totalScore = calc();
	two_opt();

//	vector<string> first = {"a","b","c","d","f"};
//	vector<string> second = {"a","b"};
//	vector<string> v;
//	v = setintersection(first,second);

//  cout << "Result " << (v.size()) << " elements:\n";
// for (int i=0; i<v.size(); i++) {
//    cout << ' ' << v[i];
//  }

  return 0;

};
