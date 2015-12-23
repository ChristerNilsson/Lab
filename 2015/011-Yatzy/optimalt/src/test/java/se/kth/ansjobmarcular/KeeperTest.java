package se.kth.ansjobmarcular;

import static org.junit.Assert.*;

import org.apache.commons.math.util.MathUtils;
import org.junit.Ignore;
import org.junit.Test;

import se.kth.ansjobmarcular.Hand;
import se.kth.ansjobmarcular.Keeper;

public class KeeperTest {

	@Test
	public void testGetMask() {
		Keeper k = new Keeper((byte)1, (byte)2, (byte)3, (byte)4, (byte)0);
		Hand h = new Hand(1, 1, 2, 3, 4);
		assertEquals(23, k.getMask(h));

		k = new Keeper((byte)6, (byte)6, (byte)0, (byte)0, (byte)0);
		h = new Hand(1, 2, 6, 6, 6);
		assertEquals(6, k.getMask(h));

		k = new Keeper((byte)1, (byte)2, (byte)5, (byte)0, (byte)0);
		h = new Hand(1, 1, 2, 4, 5);
		assertEquals(21, k.getMask(h));
		h = new Hand(1, 1, 2, 5, 6);
		assertEquals(22, k.getMask(h));

	}

	@Test
	public void testConstructor() {
		Keeper k = Keeper.getKeeper(new Hand(1, 2, 3, 4, 5), 0x10);
		assertEquals(1, k.getCount());
		k = Keeper.getKeeper(new Hand(1, 2, 3, 4, 5), 0x18);
		assertEquals(2, k.getCount());
		k = Keeper.getKeeper(new Hand(1, 2, 3, 4, 5), 0x1C);
		assertEquals(3, k.getCount());
		k = Keeper.getKeeper(new Hand(1, 2, 3, 4, 5), 0x1E);
		assertEquals(4, k.getCount());
		k = Keeper.getKeeper(new Hand(1, 2, 3, 4, 5), 0x1F);
		assertEquals(5, k.getCount());
	}

	@Ignore
	public void testShit() {
		double[] K = new double[Keeper.MAX_INDEX];

		K[Keeper.getKeeper(new Hand(1, 2, 3, 4, 5), 0x1f).getIndex()] = 15;

		Hand h = new Hand(1, 2, 2, 4, 6);

		generalKeeperTest(K, 26, 15.0 / 18.0, h);
	}

	@Ignore
	public void testSingleDieRoll() {
		double[] K = new double[Keeper.MAX_INDEX];
		Hand target = new Hand(1, 2, 3, 4, 5);

		K[Keeper.getKeeper(target, 0x1f).getIndex()] = 15;

		Hand h = new Hand(1, 6, 6, 6, 6);

		int expectedMask = 0x10;

		double possibleOutComes = Math.pow(6, 4);
		double successful = MathUtils.factorialDouble(4);

		generalKeeperTest(K, expectedMask,
				(successful / possibleOutComes) * 15, h);
	}

	private void generalKeeperTest(double[] K, int expBest, double expMax,
			Hand h) {
		double maxK = 0;
		int bestMask = 0x1f;
		for (int held = 4; held >= 0; held--) {
			for (Keeper k : Keeper.getKeepers(held)) {
				if (k.getCount() != held)
					throw new PanicException(k.getCount() + " != " + held);

				double sum = 0;
				for (int d = 1; d <= 6; d++) {
					Keeper otherK = k.add(d);
					sum += K[otherK.getIndex()];
				}
				sum /= 6.0;
				K[k.getIndex()] = sum;
				if (sum > maxK && k.getMask(h) != -1) {
					maxK = sum;
					bestMask = k.getMask(h);
				}
			}
		}
		assertEquals(expBest, bestMask);
		assertEquals(expMax, maxK, 0.001);
	}

	@Test
	public void testGetHand() {
		Hand h = new Hand(1, 2, 3, 4, 5);
		Keeper k = Keeper.getKeeper(h, 0x1f);

		byte[] expected = h.getDice();
		byte[] actual = k.getHand().getDice();
		assertArrayEquals(expected, actual);
		for (int hand = 1; hand <= Hand.MAX_INDEX; hand++) {
			h = Hand.getHand(hand);
			k = Keeper.getKeeper(h, 0x1f);
			expected = h.getDice();
			actual = k.getHand().getDice();
			assertArrayEquals(expected, actual);
		}
	}

}
