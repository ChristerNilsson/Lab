package se.kth.ansjobmarcular;

import java.util.*;

@SuppressWarnings("unchecked")
public class Keeper {
	public static final int MAX_INDEX = 462;
	private final static Keeper[] keepers = new Keeper[MAX_INDEX];

	private final static List<Keeper>[] keepersM = (List<Keeper>[]) new List<?>[6];

	private final static Map<Keeper, Integer> indexes = new HashMap<Keeper, Integer>();
	private byte count = 0;
	private byte[] dice = new byte[6];

	private Keeper() {
	}

	static {
		for (int j = 0; j < keepersM.length; j++) {
			keepersM[j] = new ArrayList<Keeper>(Hand.MAX_INDEX);
		}
		int i = 0;
		for (byte a = 0; a <= 6; a++) {
			for (byte b = a; b <= 6; b++) {
				for (byte c = b; c <= 6; c++) {
					for (byte d = c; d <= 6; d++) {
						for (byte e = d; e <= 6; e++) {
							Keeper k = new Keeper(a, b, c, d, e);
							keepers[i] = k;
							// Utils.debug("Generated keeper[%d]: %s\n", i,
							// keepers[i]);
							indexes.put(keepers[i], i);
							keepersM[k.count].add(k);
							i++;
						}
					}
				}
			}
		}
	}

	public static List<Keeper> getKeepers(int cardinality) {
		return keepersM[cardinality];
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + count;
		result = prime * result + Arrays.hashCode(dice);
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!(obj instanceof Keeper))
			return false;
		Keeper other = (Keeper) obj;
		if (count != other.count)
			return false;
		if (!Arrays.equals(dice, other.dice))
			return false;
		return true;
	}

//	public byte getMask(Hand hand) {
//		byte mask = 0;
//		byte[] h = hand.getDice();
//		byte local[] = Arrays.copyOf(dice, dice.length);
//
//		int i = 0;
//		int c = count;
//		int d = 0;
//		while (c > 0) {
//			/* Find the first die needed. */
//			while (local[d] == 0)
//				d++;
//			/* d is now the die needed. */
//
//			if (h[i] == (d + 1)) {
//				mask |= (1 << (4 - i));
//				c--;
//				local[d]--;
//			}
//			i++;
//
//			if (i == 5 && c > 0)
//				return -1;
//		}
//		return mask;
//	}

	public Keeper add(int d) {
		Keeper other = new Keeper();
		other.count = (byte) (this.count + 1);
		other.dice = Arrays.copyOf(this.dice, this.dice.length);
		other.dice[d - 1]++;
		short idx = (short) other.getIndex();
		other = null;
		return Keeper.keepers[idx];
	}

//	public int getCount() {
//		return count;
//	}
//
//	public byte[] getDice() {
//		return dice;
//	}

	public int getIndex() {
		return indexes.get(this);
	}

	public Hand getHand() {
		if (count != 5) {
			throw new IllegalArgumentException(
					"Tried to do getHand when count was " + count);
		}
		byte[] hand = new byte[5];
		byte c = count, i = 0, d = 1;
		byte[] ldice = Arrays.copyOf(dice, dice.length);
		while (c > 0) {
			if (ldice[d-1] > 0) {
				hand[i++] = (byte) (d);
				ldice[d-1]--;
				c--;
			} else {
				d++;
			}
		}
		Hand h = new Hand(hand[0], hand[1], hand[2], hand[3], hand[4]);
		short idx = (short) h.getIndex();
		return Hand.getHand(idx);
	}

//	public Keeper getKeeper(int index) {
//		return keepers[index];
//	}

	public static Keeper getKeeper(Hand hand, int mask) {
		Keeper k = new Keeper();
		byte[] tmp = hand.getDice();
		for (byte i = 0; i < 5; i++) {
			if ((mask & (1 << (4 - i))) != 0) {
				k.dice[tmp[i] - 1]++;
				k.count++;
			}
		}
		return keepers[k.getIndex()];
	}

	public Keeper(byte a, byte b, byte c, byte d, byte e) {
		if (a != 0) {
			count++;
			dice[a - 1]++;
		}
		if (b != 0) {
			count++;
			dice[b - 1]++;
		}
		if (c != 0) {
			count++;
			dice[c - 1]++;
		}
		if (d != 0) {
			count++;
			dice[d - 1]++;
		}
		if (e != 0) {
			count++;
			dice[e - 1]++;
		}
	}

	@Override
	public String toString() {
		return Arrays.toString(dice);
	}
}
