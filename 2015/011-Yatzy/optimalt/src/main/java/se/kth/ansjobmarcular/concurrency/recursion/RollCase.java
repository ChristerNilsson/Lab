package se.kth.ansjobmarcular.concurrency.recursion;

import java.util.Map;

import se.kth.ansjobmarcular.ActionsStorage;
import se.kth.ansjobmarcular.Category;
import se.kth.ansjobmarcular.Hand;
import se.kth.ansjobmarcular.Keeper;
import se.kth.ansjobmarcular.PanicException;
import se.kth.ansjobmarcular.ScoreCard;
import se.kth.ansjobmarcular.Utils;
import se.kth.ansjobmarcular.concurrency.ParallellAction;

public class RollCase extends ParallellAction {

	protected ScoreCard sc;
	protected ActionsStorage db;

	public RollCase(Map<Integer, Double> expectedScores, ScoreCard sc,
			ActionsStorage db) {
		super(expectedScores);
		this.sc = sc;
		this.db = db;
	}

	@Override
	public Void call() throws Exception {
		BeforeCall();

		double[] K = new double[Keeper.MAX_INDEX];

		for (byte roll = 3; roll >= 0; roll--) {

			if (roll == 3) {
				for (short hand = 1; hand <= Hand.MAX_INDEX; hand++) {
					double max = 0;
					byte bestCat = 0;
					ScoreCard tmpSc;
					/*
					 * For every unfilled category.
					 */
					for (Category cat : Category.values()) {
						if (sc.isFilled(cat)) {
							continue;
						}

						/*
						 * Pretend to fill the category.
						 */
						tmpSc = sc.getCopy();

						/*
						 * Calculate the expected score if filling current
						 * category with the hand.
						 */
						double score = tmpSc.value(Hand.getHand(hand), cat);

						/*
						 * If ONES-SIXES, take bonus into consideration.
						 */
						if (cat == Category.ONES || cat == Category.TWOS
								|| cat == Category.THREES
								|| cat == Category.FOURS
								|| cat == Category.FIVES
								|| cat == Category.SIXES) {
							tmpSc.fillScore(cat, tmpSc.value(
									Hand.getHand(hand), cat));
						} else {
							tmpSc.fillScore(cat);
						}

						/*
						 * Add the expected score of the next state.
						 */
						try {
						score += expectedScores.get(tmpSc.hashCode());
						} catch (Exception e) {
							System.err.printf("Error getting expected score: %s\n", tmpSc);
							e.printStackTrace();
							System.exit(-1);
						}

						/*
						 * If this is the best score so far, remember what
						 * category was the optimal.
						 */
						if (score >= max) {
							max = score;
							bestCat = (byte) Category.toInt(cat);
						}
					}

					/*
					 * Save the optimal expected score for this state.
					 */
					workingVals[1][hand].put(sc.hashCode(), max);
					K[Keeper.getKeeper(Hand.getHand(hand), 0x1f).getIndex()] = max;

					/*
					 * Save the optimal category to put the hand in (the optimal
					 * action).
					 */
					db.addMarkingAction(bestCat, sc, Hand.getHand(hand));
					Utils.debug(
							"R: 3 Scorecard: %s\n Hand: %s -> %s E = %.2f\n\n",
							sc, Hand.getHand(hand), Category.fromInt(bestCat),
							max);
				}
				continue;
			}
			/*
			 * Roll = 2,1,0
			 */

			for (Keeper k : Keeper.getKeepers(5)) {
				Map<Integer, Double> map = workingVals[1][k.getHand()
						.getIndex()];
				K[k.getIndex()] = map.containsKey(sc.hashCode()) ? map.get(sc
						.hashCode()) : 0;
			}

			/*
			 * Calculate K
			 */
			for (byte held = 4; held >= 0; held--) {
				for (Keeper k : Keeper.getKeepers(held)) {
					double sum = 0;
					for (byte d = 1; d <= 6; d++) {
						sum += K[k.add(d).getIndex()];
					}
					sum /= 6.0;
					K[k.getIndex()] = sum;
				}
			}

			/*
			 * Calculate optimal actions
			 */
			for (short hand = 1; hand <= Hand.MAX_INDEX; hand++) {
				Hand h = Hand.getHand(hand);
				double bestScore = 0;
				byte bestMask = 0;
				for (byte mask = 0; mask <= Hand.MAX_MASK; mask++) {
					int kidx = Keeper.getKeeper(h, mask).getIndex();
					if (K[kidx] > bestScore) {
						bestMask = mask;
						bestScore = K[kidx];
					}
					if (roll == 0) {
						expectedScores.put(sc.hashCode(), bestScore);
						Utils.debug("Exp(%s) => %.2f\n", sc, bestScore);
						return null;
					}
				}
				workingVals[0][hand].put(sc.hashCode(), bestScore);

				db.addRollingAction((byte) bestMask, sc, h, roll);
				Utils.debug("R: %d\t %s\n%s : 0x%x => %.2f\n\n", roll, sc, h,
						bestMask, bestScore);
			}
			copyResultsToNextRound();
		}
		/*
		 * Should never reach here!
		 */
		throw new PanicException("Reached invalid state in RollCase.java");
	}
}
