package se.kth.ansjobmarcular;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.util.Arrays;
import java.util.List;
import java.util.Random;

import org.junit.Test;

public class SolutionTest {
	ActionsStorage db;
	ScoreCard sc;
	byte roll;
	Hand h;

	public SolutionTest() {
		db = new FileActionsStorage();
	}

	@Test
	public void testFirstRound() {
		/* Trivial (Yatzy) keeper. */
		sc = new ScoreCard();
		h = new Hand(6, 6, 6, 6, 6);
		roll = 1;
		assertEquals(0x1f, db.suggestRoll(h, sc, roll));
		assertEquals(Category.toInt(Category.YATZY), db.suggestMarking(h, sc));

		/* Trivial (Yatzy) keeper mid game. */
		sc = new ScoreCard();
		sc.fillScore(Category.ONES);
		sc.fillScore(Category.SMALLSTRAIGHT);
		sc.fillScore(Category.HOUSE);
		sc.fillScore(Category.TWOS);
		sc.fillScore(Category.FOURS);
		sc.fillScore(Category.TWOPAIR);
		sc.fillScore(Category.PAIR);
		h = new Hand(6, 6, 6, 6, 6);
		roll = 1;
		assertEquals(0x1f, db.suggestRoll(h, sc, roll));
		assertEquals(Category.toInt(Category.YATZY), db.suggestMarking(h, sc));

		/* Test with one to keep. */
		sc = new ScoreCard();
		h = new Hand(5, 6, 6, 6, 6);
		roll = 1;
		assertEquals(0xf, db.suggestRoll(h, sc, roll));
		assertEquals(Category.toInt(Category.SIXES), db.suggestMarking(h, sc));

		/* Test with two to keep. */
		sc = new ScoreCard();
		h = new Hand(3, 4, 6, 6, 6);
		roll = 1;
		assertEquals(0x7, db.suggestRoll(h, sc, roll));
		assertEquals(Category.toInt(Category.THREEOFAKIND), db.suggestMarking(h, sc)); // Stämmer detta?

		/* Test with small straight. */
		sc = new ScoreCard();
		h = new Hand(1, 2, 3, 4, 5);
		roll = 1;
		assertEquals(0x1f, db.suggestRoll(h, sc, roll));
		assertEquals(Category.toInt(Category.SMALLSTRAIGHT), db.suggestMarking(h, sc));

		/* Test with large straight. */
		sc = new ScoreCard();
		h = new Hand(2, 3, 4, 5, 6);
		roll = 1;
		assertEquals(0x1f, db.suggestRoll(h, sc, roll));
		assertEquals(Category.toInt(Category.LARGESTRAIGHT), db.suggestMarking(h, sc));
	}

    @Test
    public void SixesTest() {
        ScoreCard sc = new ScoreCard();
        sc.fillScore(Category.YATZY);
        Hand h = new Hand(6,6,6,6,6);
        roll = 1;
        assertEquals(0x1f, db.suggestRoll(h, sc, roll));
        assertEquals(Category.toInt(Category.SIXES), db.suggestMarking(h, sc));
    }
    
    
    @Test
    public void LastTwoLoop() {
    	for (int i = 0; i < 1000; i++) {
    		LastTwo();
    	}
    }
    
    public void LastTwo() {
    	sc = new ScoreCard();
    	Category cat1, cat2;
    	Random r = new Random();
    	cat1 = Category.values[r.nextInt(15)];
    	do {
        	cat2 = Category.values[r.nextInt(15)];
    	} while (cat2 == cat1);
    	
    	/* Set upper total */
    	sc.addScore(42);
    	
    	/* Now we have 2 different cats */
    	for (Category x : Category.values) {
    		if (x != cat1 && x != cat2) {
    			sc.fillScore(x);
    		}
    	}
    	/* Scorecard generated! */
    	int[] dice = new int[5];
    	for (int i = 0; i < dice.length; i++) {
    		dice[i] = 1 + r.nextInt(6);
    	}
    	
    	Hand h = new Hand(dice[0], dice[1], dice[2], dice[3], dice[4]);
    	
    	int suggestion = db.suggestMarking(h, sc);
    	Category su = Category.values[suggestion];
    	assertTrue(su == cat1 || su == cat2);
    }

	@Test
	public void testSecondRound() {
		/* Trivial (Sixes) keeper. */
		sc = new ScoreCard();
		sc.fillScore(Category.YATZY);
		h = new Hand(6, 6, 6, 6, 6);
		roll = 1;
		assertEquals(0x1f, db.suggestRoll(h, sc, roll));
		assertEquals(Category.toInt(Category.SIXES), db.suggestMarking(h, sc));

		/* Test with one to keep. */
		sc = new ScoreCard();
		sc.fillScore(Category.YATZY);
		h = new Hand(5, 6, 6, 6, 6);
		roll = 1;
		assertEquals(0xf, db.suggestRoll(h, sc, roll));
		assertEquals(Category.toInt(Category.SIXES), db.suggestMarking(h, sc));
	}
	
	@Test
	public void testObviousPlaythrough() {
		
		List<Round> rounds = Arrays.asList(
				new Round(0x0f,0x0f,new Hand(5,6,6,6,6), new Hand(5,6,6,6,6), new Hand(6,6,6,6,6), Category.YATZY),
				new Round(0x0f,0x0f,new Hand(5,6,6,6,6), new Hand(5,6,6,6,6), new Hand(6,6,6,6,6), Category.SIXES),
				new Round(0x1f,0x1f,new Hand(5,5,6,6,6), new Hand(5,5,6,6,6), new Hand(5,5,6,6,6), Category.HOUSE),
				new Round(0x1f,0x1f,new Hand(2,3,4,5,6), new Hand(2,3,4,5,6), new Hand(2,3,4,5,6), Category.LARGESTRAIGHT),
				
				new Round(0x0f,0x0f,new Hand(1,5,5,5,5), new Hand(1,5,5,5,5), new Hand(5,5,5,5,5), Category.FIVES),
				new Round(0x0f,0x0f,new Hand(1,4,4,4,4), new Hand(2,4,4,4,4), new Hand(4,4,4,4,4), Category.FOURS),
				new Round(0x0f,0x0f,new Hand(2,3,3,3,3), new Hand(2,3,3,3,3), new Hand(3,3,3,3,3), Category.THREES),
				new Round(0x0f,0x0f,new Hand(1,2,2,2,2), new Hand(1,2,2,2,2), new Hand(2,2,2,2,2), Category.TWOS),
				new Round(0x1f,0x1f,new Hand(1,1,1,1,1), new Hand(1,1,1,1,1), new Hand(1,1,1,1,1), Category.ONES),
				
				new Round(0x1f,0x1f,new Hand(1,2,3,4,5), new Hand(1,2,3,4,5), new Hand(1,2,3,4,5), Category.SMALLSTRAIGHT),
				new Round(0x03,0x03,new Hand(1,1,1,6,6), new Hand(1,1,2,6,6), new Hand(1,2,3,6,6), Category.PAIR),
				new Round(0x03,0x07,new Hand(1,1,1,6,6), new Hand(1,1,6,6,6), new Hand(1,1,6,6,6), Category.THREEOFAKIND),
				new Round(0x1f,0x1f,new Hand(1,5,5,6,6), new Hand(1,5,5,6,6), new Hand(1,5,5,6,6), Category.TWOPAIR),
				new Round(0x03,0x0f,new Hand(1,5,5,6,6), new Hand(1,5,5,6,6), new Hand(1,6,6,6,6), Category.FOUROFAKIND),
				/* Last round always suggest ONES, since the choice should be obvious */
				new Round(0x07,0x07,new Hand(1,1,6,6,6), new Hand(1,1,6,6,6), new Hand(6,6,6,6,6), Category.ONES)
		);	
		
		assertRounds(rounds);
		
	}
	
	public void assertRounds(List<Round> rounds) {
		int sum = 0;
		sc = new ScoreCard();
		for (Round r: rounds) {
			sum += assertRound(r);
		}
		System.out.printf("Total score: %d\n", sum);
	}
	
	private int assertRound(Round r) {
		assertEquals(r.toString(), r.mask1, db.suggestRoll(r.h1, sc, 1));
		assertEquals(r.toString(), r.mask2, db.suggestRoll(r.h2, sc, 2));
		assertEquals(r.toString(), r.expectedMarking, Category.values[db.suggestMarking(r.h3, sc)]);
		int score = sc.value(r.h3, r.expectedMarking);
		sc.fillScore(r.expectedMarking, score);
		return score;
	}
	
	private class Round {
		 
		public Round(int i, int j, Hand h1, Hand h2, Hand h3,
				Category expectedMarking) {
			this.mask1 = i;
			this.mask2 = j;
			this.h1 = h1;
			this.h2 = h2;
			this.h3 = h3;
			this.expectedMarking = expectedMarking;
		}
		int mask1, mask2;
		Hand h1, h2, h3;
		Category expectedMarking;
		@Override
		public String toString() {
			return "Round [expectedMarking=" + expectedMarking + ", h1=" + h1
					+ ", h2=" + h2 + ", h3=" + h3 + ", mask1=" + mask1
					+ ", mask2=" + mask2 + "]";
		}
		
	}
}
