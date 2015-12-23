package se.kth.ansjobmarcular;

import static org.junit.Assert.*;

import java.util.Arrays;

import org.junit.Test;

import se.kth.ansjobmarcular.Hand;

public class HandTest {

	@Test
	public void test() {
		byte a, b, c, d, e;
		int i = 1;
		for (a = 1; a <= 6; a++) {
			for (b = a; b <= 6; b++) {
				for (c = b; c <= 6; c++) {
					for (d = c; d <= 6; d++) {
						for (e = d; e <= 6; e++) {
							assertEquals(i++, new Hand(a, b, c, d, e)
									.getIndex());
						}
					}
				}
			}
		}
		
		assertEquals(1, new Hand(1, 1, 1, 1, 1).getIndex());
		assertEquals(Hand.MAX_INDEX, new Hand(6, 6, 6, 6, 6).getIndex());
	}

	@Test
	public void testOutcomes() {
		Hand hand = new Hand(1, 2, 3, 4, 5);

		assertEquals(
				"[[1, 1, 2, 3, 4], [1, 2, 2, 3, 4], [1, 2, 3, 3, 4], [1, 2, 3, 4, 4], [1, 2, 3, 4, 5], [1, 2, 3, 4, 6]]",
				Arrays.toString(hand.getPossibleOutcomes(30)));

	}
	
	@Test
	public void test2Outcomes() {
		Hand hand = new Hand(1,1,1,1,1);
		int mask = 0x1c; //roll two last dice
		String expected = 
				"[" +
						"[1, 1, 1, 1, 1], " +
						"[1, 1, 1, 1, 2], " +
						"[1, 1, 1, 1, 3], " +
						"[1, 1, 1, 1, 4], " +
						"[1, 1, 1, 1, 5], " +
						"[1, 1, 1, 1, 6], " +
						"[1, 1, 1, 2, 2], " +
						"[1, 1, 1, 2, 3], " +
						"[1, 1, 1, 2, 4], " +
						"[1, 1, 1, 2, 5], " +
						"[1, 1, 1, 2, 6], " +
						"[1, 1, 1, 3, 3], " +
						"[1, 1, 1, 3, 4], " +
						"[1, 1, 1, 3, 5], " +
						"[1, 1, 1, 3, 6], " +
						"[1, 1, 1, 4, 4], " +
						"[1, 1, 1, 4, 5], " +
						"[1, 1, 1, 4, 6], " +
						"[1, 1, 1, 5, 5], " +
						"[1, 1, 1, 5, 6], " +
						"[1, 1, 1, 6, 6]" +
				"]";
		String actual = Arrays.toString(hand.getPossibleOutcomes(mask));
		assertEquals(expected, actual);
	}
}
