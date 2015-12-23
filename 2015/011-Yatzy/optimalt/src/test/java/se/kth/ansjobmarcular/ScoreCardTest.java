package se.kth.ansjobmarcular;

import static org.junit.Assert.*;

import org.junit.Test;

import se.kth.ansjobmarcular.ScoreCard;

public class ScoreCardTest {
	ScoreCard sc;
	
	public ScoreCardTest() {
		sc = new ScoreCard();
	}


	@Test
	public void testIndexLimit() {
		for (Category cat : Category.values()) {
			sc.fillScore(cat);
		}
		sc.addScore(63);
		assertEquals(ScoreCard.MAX_INDEX, sc.getIndex());
		assertEquals("111111111111111111111", Utils.maskToBinaryString(sc.getIndex()));
		sc = new ScoreCard();
	}
	
	@Test
	public void testScoreCard() {		
		assertEquals(0, sc.getIndex());

		sc.fillScore(Category.HOUSE);
		assertEquals(4, sc.getIndex());

		sc.fillScore(Category.YATZY);
		assertEquals(5, sc.getIndex());

		sc.fillScore(Category.ONES, 500);
		assertEquals(2080773, sc.getIndex());
		
		sc = new ScoreCard();
		sc.fillScore(Category.ONES, 0);
		ScoreCard sc2 = new ScoreCard();
		sc2.addScore(1);
		assertTrue(sc.getIndex() != sc2.getIndex());
		
		sc.addScore(20);
		assertEquals(671744, sc.getIndex());	
		sc.addScore(1);
		assertEquals(704512, sc.getIndex());
		sc.fillScore(Category.YATZY);
		assertEquals(704513, sc.getIndex());
		
	}

	@Test
	public void testScoreCardGeneration() {
		ScoreCard sc;
		boolean[][] variations;
		boolean[] usedIndexes = new boolean[ScoreCard.MAX_INDEX];

		for (int filled = 14; filled >= 0; filled--) {
			variations = Utils.allWaysToPut(filled, 15);

			for (boolean[] way : variations) {
				sc = new ScoreCard();
				int i = 0;
				for (Category cat : Category.values()) {
					if (way[i++])
						sc.fillScore(cat);
				}
				assertFalse(usedIndexes[sc.getIndex()]);
				usedIndexes[sc.getIndex()] = true;
			}
		}
	}


	@Test
	public void testNumbers() {
		assertEquals(5, sc.value(new Hand(1, 1, 1, 1, 1), Category.ONES));
		assertEquals(4, sc.value(new Hand(1, 1, 1, 1, 6), Category.ONES));
		assertEquals(3, sc.value(new Hand(1, 4, 1, 2, 1), Category.ONES));
		assertEquals(2, sc.value(new Hand(2, 1, 3, 1, 2), Category.ONES));
		assertEquals(1, sc.value(new Hand(2, 6, 6, 1, 2), Category.ONES));

		assertEquals(0, sc.value(new Hand(1, 1, 4, 1, 1), Category.TWOS));
		assertEquals(2, sc.value(new Hand(1, 1, 1, 1, 2), Category.TWOS));
		assertEquals(4, sc.value(new Hand(1, 2, 3, 2, 1), Category.TWOS));
		assertEquals(6, sc.value(new Hand(2, 1, 2, 5, 2), Category.TWOS));
		assertEquals(8, sc.value(new Hand(2, 2, 2, 1, 2), Category.TWOS));

		assertEquals(0, sc.value(new Hand(1, 1, 4, 1, 1), Category.THREES));
		assertEquals(9, sc.value(new Hand(1, 3, 3, 3, 2), Category.THREES));
		assertEquals(18, sc.value(new Hand(6, 6, 3, 6, 1), Category.SIXES));
		assertEquals(10, sc.value(new Hand(2, 5, 2, 5, 2), Category.FIVES));
		assertEquals(12, sc.value(new Hand(2, 4, 4, 1, 4), Category.FOURS));
	}

	@Test
	public void testPairs() {
		assertEquals(8, sc.value(new Hand(1, 4, 3, 4, 6), Category.PAIR));
		assertEquals(12, sc.value(new Hand(4, 6, 4, 4, 6), Category.PAIR));
		assertEquals(6, sc.value(new Hand(3, 2, 3, 1, 3), Category.PAIR));
		assertEquals(0, sc.value(new Hand(1, 2, 3, 4, 5), Category.PAIR));
		
		assertEquals(22, sc.value(new Hand(3, 5, 5, 6, 6), Category.TWOPAIR));
		assertEquals(14, sc.value(new Hand(3, 3, 4, 4, 5), Category.TWOPAIR));
	}

	@Test
	public void testKinds() {
		assertEquals(12, sc.value(new Hand(1, 4, 4, 4, 6), Category.THREEOFAKIND));
		assertEquals(0, sc.value(new Hand(1, 2, 4, 4, 6), Category.THREEOFAKIND));
		assertEquals(0, sc.value(new Hand(1, 2, 4, 4, 6), Category.FOUROFAKIND));
		assertEquals(4, sc.value(new Hand(1, 1, 1, 1, 6), Category.FOUROFAKIND));
		assertEquals(24, sc.value(new Hand(6, 6, 5, 6, 6), Category.FOUROFAKIND));
	}

	@Test
	public void testStraights() {
		assertEquals(15, sc.value(new Hand(1, 2, 4, 3, 5), Category.SMALLSTRAIGHT));
		assertEquals(0, sc.value(new Hand(1, 1, 1, 1, 1), Category.SMALLSTRAIGHT));
		assertEquals(20, sc.value(new Hand(2, 3, 5, 4, 6), Category.LARGESTRAIGHT));
		assertEquals(0, sc.value(new Hand(1, 1, 1, 1, 6), Category.LARGESTRAIGHT));
		assertEquals(0, sc.value(new Hand(6, 6, 6, 6, 6), Category.LARGESTRAIGHT));
	}

	@Test
	public void testHouses() {
		assertEquals(7, sc.value(new Hand(1, 1, 1, 2, 2), Category.HOUSE));
		assertEquals(28, sc.value(new Hand(6, 6, 6, 5, 5), Category.HOUSE));
		assertEquals(0, sc.value(new Hand(2, 3, 5, 4, 6), Category.HOUSE));
		assertEquals(0, sc.value(new Hand(1, 1, 1, 5, 6), Category.HOUSE));
		assertEquals(0, sc.value(new Hand(6, 6, 6, 6, 6), Category.HOUSE));
	}

	@Test
	public void testYatzy() {
		assertEquals(50, sc.value(new Hand(1, 1, 1, 1, 1), Category.YATZY));
		assertEquals(50, sc.value(new Hand(6, 6, 6, 6, 6), Category.YATZY));
		assertEquals(50, sc.value(new Hand(2, 2, 2, 2, 2), Category.YATZY));
		assertEquals(0, sc.value(new Hand(1, 1, 1, 1, 6), Category.YATZY));
		assertEquals(0, sc.value(new Hand(6, 6, 4, 6, 6), Category.YATZY));
	}

	 @Test
	 public void testChance() {
			assertEquals(5, sc.value(new Hand(1, 1, 1, 1, 1), Category.CHANCE));
			assertEquals(30, sc.value(new Hand(6, 6, 6, 6, 6), Category.CHANCE));
			assertEquals(10, sc.value(new Hand(2, 2, 2, 2, 2), Category.CHANCE));
			assertEquals(16, sc.value(new Hand(1, 2, 3, 4, 6), Category.CHANCE));
	 }
	
	 
	 @Test
	 public void testBonus() {
		 sc.fillScore(Category.ONES, 61);
		 assertEquals(52, sc.value(new Hand(1, 2, 3, 4, 5), Category.TWOS));
		 sc = new ScoreCard();
		 sc.fillScore(Category.ONES, 60);
		 assertEquals(2, sc.value(new Hand(1, 2, 3, 4, 5), Category.TWOS));
		 sc = new ScoreCard();
		 sc.fillScore(Category.ONES, 60);
		 assertEquals(55, sc.value(new Hand(2, 2, 2, 4, 5), Category.FIVES));
		 sc.fillScore(Category.TWOS, 3);
		 assertEquals(5, sc.value(new Hand(2, 2, 2, 4, 5), Category.FIVES));
		 sc = new ScoreCard();
	 }
}
