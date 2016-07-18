using System;
using System.Collections.Generic;

namespace GålöExercise {
	class Lektion {
		public static bool trueorfalse;
		public static void ass(int a, int b) {
			if (a != b) {
				throw new Exception ();
			}
		}
		public static void ass(string a, string b) {
			if (a != b) {
				throw new Exception ();
			}
		}
		public static void ass(string[] a, string[] b) {
			string s = string.Join (",", a);
			string t = string.Join (",", b);
			ass (s, t);
		}
		public static void ass(bool a, bool b) {
			if (a != b) {
				throw new Exception ();
			}
		}
	}

	class Lektion_1 : Lektion {
		static int e(int x) {return 00;}
		static int g(int x) {return 00;}
		static int h(int x) {return 00;}
		static int j(int x) {return 00;}
		static int k(int x) {return 00;}
		static int m(int x) {return 00;}
		static int n(int x) {return 00;}
		static int o(int x, int y) {return 00;}
		static int p(int x, int y) {return 00;}
		static int q(int x, int y) {return 00;}

		public Lektion_1() {
			ass(e(5), 5);
			ass(e(-3), -3);

			ass(g (5), -5);
			ass(g(-3), 3);

			ass(h(3), 9);
			ass(h(4), 16);

			ass(j(3), 1);
			ass(j(4), 0);

			ass(k(7), 14);
			ass(k(8), 16);

			ass(m(10), 5);
			ass(m(8),4);

			ass(n(1), 3);
			ass(n(2), 5);

			ass(o(4, 5), 9);
			ass(o(2, 3), 5);

			ass(p(4, 5), 20);
			ass(p(2, 3), 6);

			ass(q(8, 4), 2);
			ass(q(10, 5), 2);
		}
	}

	class Lektion_2 : Lektion {
		static string f(string x) {return "00";}
		static string g(string x) {return "00";}
		static string h(string x) {return "00";}
		static string i(string x) {return "00";}
		static string j(string x) {return "00";}
		static string k(string x) {return "00";}
		static string j(string a, string b, string c) {return "00";}
		static int k(string a, string b) {return 00;}
		static int l(string a, string b) {return 00;}
		static string m(string a, int pos, string b) {return "00";}
		static string n(string a, List<string> words) {return "00";}
		static string o(string a, int n, char b) {return "00";}
		static string p(string a, int n, char b) {return "00";}
		static string q(string a, int m, int n) {return "00";}
		static bool r(string a, string b) {return trueorfalse;}
		static bool s(string a, string b) {return trueorfalse;}
		static string t(string a) {return "00";}
		static string u(string a) {return "00";}
		static string v(string a) {return "00";}
		static string w(string a, char[] b) {return "00";}
		static string x(float a) {return "00";}
		static string y(float a) {return "00";}
		static string[] z(string s, char ch) {return new string[]{"00"};}

		public Lektion_2() {
			ass(f("Pelle"), "PELLE");
			ass(f("Stor-Klas"), "STOR-KLAS");

			ass(g("Pelle"), "pelle");
			ass(g("Lill-Klas"), "lill-klas");

			ass(h("viktor"), "k");
			ass(h("bertil"), "r");

			ass(i("viktor"), "kt");
			ass(i("stor-klas"), "or");

			ass(j("christer nilsson","i","#"), "chr#ster n#lsson");

			ass(k("christer nilsson","i"), 3);

			ass(l("christer nilsson","i"), 10);

			ass(m("UnityD",5,"3"), "Unity3D");
			ass(m("Gålölägret",4,"-"), "Gålö-lägret");

			ass(n("-", new List<string> {"adam","bertil"} ),"adam-bertil");
			ass(n(" och ", new List<string> {"a","b","c"} ),"a och b och c");

			ass(o("Quadcopter", 15, '='), "=====Quadcopter");
			ass(p("Quadrocopter", 15, '#'), "Quadrocopter###");

			ass(q("Quadrocopter", 4, 2), "Quadcopter");
			ass(q("Quadrocopter", 4, 8), "Quad");

			ass(r("Quadcopter", "Qu"), true);
			ass(r("Quadcopter", "copter"), false);

			ass(s("Quadcopter", "Qu"), false);
			ass(s("Quadcopter", "copter"), true);

			ass(t("  Pelle "), "Pelle");

			ass(u("  Pelle "), "  Pelle");

			ass(v("  Pelle "), "Pelle ");

			ass(w("#¤#¤%&Stina¤%#¤%", new char[]{'#','¤','%','&'}), "Stina");

			ass(x(3.1415f), "3.14");
			ass(y(3.1415f), "3");

			ass(z("Stockholm",'o'), new string[]{"St","ckh","lm"});

		}
	}

	class MainClass	{
		public static void Main (string[] args)		{
			Lektion lektion_1 = new Lektion_1();
			Lektion lektion_2 = new Lektion_2();
			Console.WriteLine("OK!");
		}
	}
}
