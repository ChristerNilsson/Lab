package se.kth.ansjobmarcular;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//import org.apache.commons.math.util.MathUtils;

/**
 * The hand class represents the 5 dices in a set state.
 *
 * @author Marcus
 * @author Andreas Sjöberg
 *
 */
public class Hand {
	public static final int MAX_INDEX = 252;
	public static final int MAX_MASK = 0x1f;
	public static final int MAX_KEEPER = 462;
	public static final byte SIZE = 5;
	private final byte dice[];

	public Hand(int a, int b, int c, int d, int e) {
		dice = new byte[SIZE];
		this.dice[0] = (byte) a;
		this.dice[1] = (byte) b;
		this.dice[2] = (byte) c;
		this.dice[3] = (byte) d;
		this.dice[4] = (byte) e;
		Arrays.sort(this.dice);
	}

	public static long factorial(long a) {
		long res = 1;
		for (int i=1; i<=a; i++) res *= i;
		return res;
	}

	public static int binomialCoefficient(int a, int b) {
		long res = factorial(a)/factorial(b)/factorial(a-b);
		return (int)res;
	}

//	public Hand[] getPossibleOutcomes(int holdMask) {
//		int outcomes;
//		byte[] counts = new byte[6];
//		Hand[] res;
//		List<Integer> rolledIdxs = new ArrayList<Integer>(5);
//
//		/* Count the held, and the number of rolled dice. */
//		for (int i = 0; i < 5; i++) {
//			if ((holdMask & (16 >> i)) > 0){
//				counts[this.dice[i] - 1]++;
//			}
//			else{
//				rolledIdxs.add(i);
//			}
//		}
//
//		/* If all dice are held, there's only one outcome (the current hand). */
//		if (rolledIdxs.size() == 0)
//			return new Hand[] { this };
//
//		/* Calculate how many different outcomes there are. */
//		outcomes = binomialCoefficient(rolledIdxs.size() +5, 5);
//		res = new Hand[outcomes];
//
//		/* Initialize a buffer with 1's for the dice to be rolled.*/
//		byte[] prevBuf = Arrays.copyOf(dice, 5);
//		for (Integer rolledIdx : rolledIdxs) {
//			prevBuf[rolledIdx] = 1;
//		}
//		/* Sort the 1's to the head */
//		Arrays.sort(prevBuf);
//		/* The first possible outcome is generated. Let's save it */
//		res[0] = new Hand(prevBuf[0], prevBuf[1], prevBuf[2], prevBuf[3], prevBuf[4]);
//
//		for (int outcome = 1; outcome<outcomes; outcome++) {
//			byte[] buf = Arrays.copyOf(prevBuf, 5);
//
//			/* Now let's fill the first n dice with something smart.
//			 * we want to go from something like 1, 1, 1 -> 2, 1, 1
//			 * or 6, 5, 5 -> 6, 6, 5 -> 6, 6, 6 */
//			buf[0]++;
//			for (int i = 0 ; i < rolledIdxs.size(); i++) {
//				if (buf[i] > 6){
//					buf[i+1]++;
//					for (int j = i; j >=0; j--) {
//						buf[j] = buf[i+1];
//					}
//				}
//			}
//
//			prevBuf = Arrays.copyOf(buf, 5);
//			Arrays.sort(buf);
//			res[outcome] = new Hand(buf[0], buf[1], buf[2], buf[3], buf[4]);
//		}
//
//		return res;
//	}

	public byte[] getDice() {
		return dice;
	}

//	public static int indexOf(Hand h) {
//		return getIndexes.get(h);
//	}

	public static Hand getHand(int index) {
		return getHands[index];
	}

	@Override
	public int hashCode() {
		return Arrays.hashCode(dice);
	}

	public int getIndex() {
		return getIndexes.get(this);
	}

//	public double probability(Hand other, int holdMask) {
//		byte[] desired = new byte[7];
//		byte[] held = new byte[7];
//		byte[] needed = new byte[7];
//		int rolled = 0;
//		int s = 1;
//		int d;
//
//		/* Count the number of dice of each type that are held & desired. */
//		for (int i = 0; i < SIZE; i++) {
//			/* See if the holdMask tells us to hold/keep this dice. */
//			if ((holdMask & (16 >> i)) > 0)
//				held[this.dice[i]]++;
//			else
//				/* If it's not held, increase the number of dice rolled. */
//				rolled++;
//			desired[other.getDice()[i]]++;
//		}
//
//		/* Calculate the number of dice we need to roll. */
//		for (int i = 1; i <= 6; i++) {
//			if (held[i] > desired[i]) {
//				return 0;
//			} else if (held[i] < desired[i]) {
//				needed[i] = (byte) (desired[i] - held[i]);
//			}
//		}
//
//		/* Calculate the probability of rolling those dice. */
//		d = rolled;
//		for (int i = 1; i <= 6; i++) {
//			s *= nCr(d, needed[i]);
//			d -= needed[i];
//		}
//
//		return s / Math.pow(6.0, rolled);
//	}

//	public static int nCr(int a, int b) {
//		if (b == 0)
//			return 1;
//		if (a == 0)
//			return 0;
//		if (b > a)
//			return 0;
//		return factorial[a] / (factorial[b] * factorial[(a - b)]);
//	}

	private static final int[] factorial = { 1, 1, 2, 6, 24, 120, 720 };

	private static final Hand[] getHands;
	private static final Map<Hand, Integer> getIndexes;
	static {
		getHands = new Hand[MAX_INDEX +1];
		getIndexes = new HashMap<Hand, Integer>();
		generate();
	}

	@Override
	public boolean equals(Object o) {
		if (o instanceof Hand) {
			return Arrays.equals(dice, ((Hand) o).dice);
		}
		return false;
	}

	@Override
	public String toString() {
		return Arrays.toString(dice);
	}

    static {
        generate();
    }

	private static void generate() {
		int a, b, c, d, e, i;
		i = 0;
		for (a = 1; a <= 6; a++) {
			for (b = a; b <= 6; b++) {
				for (c = b; c <= 6; c++) {
					for (d = c; d <= 6; d++) {
						for (e = d; e <= 6; e++) {
							i++;
							Hand h = new Hand(a, b, c, d, e);
							getHands[i] = h;
							getIndexes.put(h, i);
						}
					}
				}
			}
		}
	}
}
