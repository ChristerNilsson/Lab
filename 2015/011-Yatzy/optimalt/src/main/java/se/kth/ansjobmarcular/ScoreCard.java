package se.kth.ansjobmarcular;

import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

public class ScoreCard {
	public static final int MAX_INDEX = 2097151;
	private short upperTotal;
	private short filled;

	public ScoreCard() {
		upperTotal = 0;
		filled = 0;
	}

//	public int lowestEffectiveUpper() {
//		int res;
//		int max = 0;
//		for (int i = 0; i < 6; i++) {
//			if (!isFilled(Category.values()[i])) {
//				max += 5*(i+1);
//			}
//		}
//		res = 63 - max;
//		if (res < 0)
//			return 0;
//		else
//			return res;
//	}

//	public String getFilled() {
//		List<Category> checked = new LinkedList<Category>();
//
//		for (int i = 0; i < 15; i++) {
//			if (((1 << i) & filled) > 0) {
//				checked.add(Category.values()[i]);
//			}
//		}
//
//		return checked.toString();
//	}

	public String getUnFilled() {
		List<Category> checked = new LinkedList<Category>();

		for (int i = 0; i < 15; i++) {
			if (((1 << (14-i)) & filled) == 0) {
				checked.add(Category.values()[i]);
			}
		}

		return checked.toString();
	}

	public ScoreCard(short filled, short upperTotal) {
		this.filled = filled;
		this.upperTotal = upperTotal;
	}

        public ScoreCard getCopy() {
		return new ScoreCard(filled, upperTotal);
        }

	public boolean isFilled(Category cat) {
		switch (cat) {
		case ONES:
			return (filled & (1 << 14)) > 0;
		case TWOS:
			return (filled & (1 << 13)) > 0;
		case THREES:
			return (filled & (1 << 12)) > 0;
		case FOURS:
			return (filled & (1 << 11)) > 0;
		case FIVES:
			return (filled & (1 << 10)) > 0;
		case SIXES:
			return (filled & (1 << 9)) > 0;
		case PAIR:
			return (filled & (1 << 8)) > 0;
		case TWOPAIR:
			return (filled & (1 << 7)) > 0;
		case THREEOFAKIND:
			return (filled & (1 << 6)) > 0;
		case FOUROFAKIND:
			return (filled & (1 << 5)) > 0;
		case SMALLSTRAIGHT:
			return (filled & (1 << 4)) > 0;
		case LARGESTRAIGHT:
			return (filled & (1 << 3)) > 0;
		case HOUSE:
			return (filled & (1 << 2)) > 0;
		case CHANCE:
			return (filled & (1 << 1)) > 0;
		case YATZY:
			return (filled & (1 << 0)) > 0;
		default:
			return false;
		}
	}

//	public int getUpper() {
//		return upperTotal;
//	}

	public void addScore(int score) {
		upperTotal += score;
		if (upperTotal > 63)
			upperTotal = 63;
	}

	public void fillScore(Category cat) {
		fillScore(cat, 0);
	}

	public void fillScore(Category cat, int score) {
		switch (cat) {
		case ONES:
			filled |= (1 << 14);
			addScore(score);
			break;
		case TWOS:
			filled |= (1 << 13);
			addScore(score);
			break;
		case THREES:
			filled |= (1 << 12);
			addScore(score);
			break;
		case FOURS:
			filled |= (1 << 11);
			addScore(score);
			break;
		case FIVES:
			filled |= (1 << 10);
			addScore(score);
			break;
		case SIXES:
			filled |= (1 << 9);
			addScore(score);
			break;
		case PAIR:
			filled |= (1 << 8);
			break;
		case TWOPAIR:
			filled |= (1 << 7);
			break;
		case THREEOFAKIND:
			filled |= (1 << 6);
			break;
		case FOUROFAKIND:
			filled |= (1 << 5);
			break;
		case SMALLSTRAIGHT:
			filled |= (1 << 4);
			break;
		case LARGESTRAIGHT:
			filled |= (1 << 3);
			break;
		case HOUSE:
			filled |= (1 << 2);
			break;
		case CHANCE:
			filled |= (1 << 1);
			break;
		case YATZY:
			filled |= 1;
			break;
		}
	}

	public int getIndex() {
		return ((0x3f & upperTotal) << 15) | (0x7FFF & filled);
	}

	@Override
	public String toString() {
		return upperTotal + " " + getUnFilled();
	}

	@Override
	public int hashCode() {
		return getIndex();
	}

	@Override
	public boolean equals(Object obj) {
		if (obj instanceof ScoreCard) {
			return ((ScoreCard) obj).getIndex() == this.getIndex();
		}
		return false;
	}

	/**
	 * Calculate the score value for a given hand in the given score type,
	 * taking into consideration how the scorecard has been filled in so far.
	 *
	 * @param hand
	 *            The hand to be evaluated.
	 * @param sp
	 *            The intended score card type to be filled in, Pairs, Twos,
	 *            etc.
	 * @return The numeric score of the hand, if filled in as the given type.
	 */
	public int value(Hand hand, Category sp) {
		switch (sp) {
		case ONES:
		case TWOS:
		case THREES:
		case FOURS:
		case FIVES:
		case SIXES:
			return scoreNumbers(hand, sp);

		case PAIR:
			return scorePair(hand, 1);
		case TWOPAIR:
			return scorePair(hand, 2);

		case THREEOFAKIND:
			return scoreKind(hand, 3);
		case FOUROFAKIND:
			return scoreKind(hand, 4);

		case SMALLSTRAIGHT:
			return scoreStraight(hand, Category.SMALLSTRAIGHT);
		case LARGESTRAIGHT:
			return scoreStraight(hand, Category.LARGESTRAIGHT);

		case HOUSE:
			return scoreHouse(hand);

		case YATZY:
			return scoreYatzy(hand);

		case CHANCE:
			return scoreChance(hand);

		default:
			return 0;
		}
	}

	/**
	 * Calculate the numbers (specified) score for a hand.
	 *
	 * @param hand
	 *            Hand to be evaluated.
	 * @param cat
	 *            Category used for the hand (ONES for example).
	 * @return Score.
	 */
	private short scoreNumbers(Hand hand, Category cat) {
		short score;
		switch (cat) {
		case ONES:
			score = count(hand, 1);
			break;
		case TWOS:
			score = (short) (count(hand, 2) * 2);
			break;
		case THREES:
			score = (short) (count(hand, 3) * 3);
			break;
		case FOURS:
			score = (short) (count(hand, 4) * 4);
			break;
		case FIVES:
			score = (short) (count(hand, 5) * 5);
			break;
		case SIXES:
			score = (short) (count(hand, 6) * 6);
			break;
		default:
			score = 0;
			break;
		}
		if (upperTotal < 63 && score + upperTotal >= 63)
			score += 50;
		return score;
	}

	/**
	 * Calculate the chance score for a hand.
	 *
	 * @param hand
	 *            Hand to be evaluated.
	 * @return Score.
	 */
	private short scoreChance(Hand hand) {
		short sum = 0;
		for (int i : hand.getDice())
			sum += i;
		return sum;
	}

	/**
	 * Calculate the yatzy score for a hand.
	 *
	 * @param hand
	 *            Hand to be evaluated.
	 * @return Score.
	 */
	private short scoreYatzy(Hand hand) {
		byte count = 1;
		byte prev = 0;
		for (byte i : hand.getDice()) {
			if (prev == i)
				count++;
			prev = i;
		}

		if (count == 5)
			return 50;
		else
			return 0;
	}

	/**
	 * Calculate the house score of a hand.
	 *
	 * @param hand
	 *            Hand to be evaluated.
	 * @return Score.
	 */
	private short scoreHouse(Hand hand) {
		short val = 0;
		byte prev = 0;
		byte count = 0;

		for (byte i : hand.getDice()) {
			if (i == prev || prev == 0) {
				count++;
			} else {
				if (count != 2 && count != 3)
					return 0;
				val += count * prev;
				count = 1;
			}
			prev = i;
		}
		if (count != 2 && count != 3)
			return 0;
		val += count * prev;

		return val;
	}

	/**
	 * Calculate the straight score of a hand.
	 *
	 * @param hand
	 *            Hand to be evaluated.
	 * @param type
	 *            The type of straight (big/small) to be calculated.
	 * @return Score.
	 */
	private int scoreStraight(Hand hand, Category type) {
		if (type == Category.SMALLSTRAIGHT
				&& Arrays.equals(hand.getDice(), new byte[] { 1, 2, 3, 4, 5 }))
			return 15;
		if (type == Category.LARGESTRAIGHT
				&& Arrays.equals(hand.getDice(), new byte[] { 2, 3, 4, 5, 6 }))
			return 20;
		return 0;
	}

	/**
	 * Calculate the 3-, 4-of-a-kind score of a hand.
	 *
	 * @param hand
	 *            Hand to be evaluated.
	 * @param no
	 *            Number of dice that should be the same (3 for THREEOFAKIND,
	 *            etc).
	 * @return Score.
	 */
	private short scoreKind(Hand hand, int no) {
		short val = 0;
		byte count = 1;
		byte prev = 0;

		for (byte i : hand.getDice()) {
			if (i == prev)
				count++;
			else
				count = 1;
			prev = i;
			if (count == no)
				val = (short) (no * prev);
		}

		return val;
	}

	/**
	 * Calculates the (two-)pair score of a hand.
	 *
	 * @param hand
	 *            Hand to be evaluated.
	 * @param no
	 *            Number of pairs to calculate for.
	 * @return Score.
	 */
	private short scorePair(Hand hand, int no) {
		byte max = 0;
		byte prev = 0;
		byte used = 0;
		short score = 0;

		for (; no > 0; no--) {
			for (byte i : hand.getDice()) {
				if (prev == i && max < i && i != used) {
					max = i;
				}
				prev = i;
			}
			used = max;
			score += max * 2;
			max = 0;
		}
		return score;
	}

	/**
	 * Count the occurrences of given number in given hand.
	 *
	 * @param hand
	 *            The hand in which the dice will be counted.
	 * @param number
	 *            The (dice) number to be counted.
	 * @return Occurrences of <i>number</i> in <i>hand</i>.
	 */
	public static short count(Hand hand, int number) {
		short val = 0;
		for (int i : hand.getDice()) {
			if (i == number)
				val += 1;
		}
		return val;
	}
}