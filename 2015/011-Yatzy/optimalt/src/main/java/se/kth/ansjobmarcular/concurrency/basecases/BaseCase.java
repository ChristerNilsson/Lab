package se.kth.ansjobmarcular.concurrency.basecases;

import java.util.Map;
import java.util.concurrent.ExecutorService;

import se.kth.ansjobmarcular.ActionsStorage;
import se.kth.ansjobmarcular.Category;
import se.kth.ansjobmarcular.Hand;
import se.kth.ansjobmarcular.Keeper;
import se.kth.ansjobmarcular.ScoreCard;
import se.kth.ansjobmarcular.Utils;
import se.kth.ansjobmarcular.concurrency.ParallellAction;

public class BaseCase extends ParallellAction {

    protected int upperTotal;
    protected Category cat;
    protected ActionsStorage db;

    public BaseCase(Map<Integer, Double> expectedScores, int upperTotal,
            Category cat,  ActionsStorage db) {
        super(expectedScores);
        this.upperTotal = upperTotal;
        this.cat = cat;
        this.db = db;
    }

    public Void call() throws Exception {
    	BeforeCall();
        ScoreCard sc = new ScoreCard();
        sc.addScore(upperTotal);
        for (Category c : Category.values()) {
            if (c != cat) {
                sc.fillScore(c);
            }
        }

        /*
         * For every roll during this round.
         */
        for (int roll = 3; roll >= 0; roll--) {
            /*
             * If last roll.
             */
            if (roll == 3) {
                /*
                 * For every possible hand
                 */
                for (int hand = 1; hand <= Hand.MAX_INDEX; hand++) {
                    double expected = sc.value(Hand.getHand(hand), cat);
                    workingVals[1][hand].put(sc.hashCode(), expected);
                }
                continue;
            }

            /*
             * If roll 0-2
             */

            /*
             * Doing the keepers trick here!
             */

            /*
             * Base case: all dice are held:
             */
            double[] K = new double[Keeper.MAX_INDEX];
            for (Keeper k : Keeper.getKeepers(5)) {
            	Map<Integer, Double> map = workingVals[1][k.getHand().getIndex()];
            	K[k.getIndex()] = map.containsKey(sc.hashCode()) ? map.get(sc.hashCode()) : 0;
            }

            /*
             * "Dynamic" step: for each amount of dice to throw...
             */
            for (int held = 4; held >= 0; held--) {
                for (Keeper k : Keeper.getKeepers(held)) {
                    double sum = 0;
                    for (int d = 1; d <= 6; d++) {
                        sum += K[k.add(d).getIndex()];
                    }
                    sum /= 6.0;
                    K[k.getIndex()] = sum;
                }
            }

            for (int hand = 1; hand <= Hand.MAX_INDEX; hand++) {
                Hand h = Hand.getHand(hand);
                int bestMask = 0;
                double bestScore = 0;
                for (int mask = 0; mask <= Hand.MAX_MASK; mask++) {
                    Keeper k = Keeper.getKeeper(h, mask);
                    if (K[k.getIndex()] > bestScore) {
                        bestScore = K[k.getIndex()];
                        bestMask = mask;
                    }
                    if (roll == 0) {
                        /*
                         * We just calculated the expected score for mask 0x0 ==
                         * rolling all dice, which is the model for "roll 0".
                         * Let's save this as the expected score for this round
                         * of the game.
                         */
                        expectedScores.put(sc.hashCode(), bestScore);
                        Utils.debug("Exp(%s)=> %.2f\n", sc , bestScore);
                        return null;
                    }
                }

                Utils.debug("R: %d\t SC: %s\t%s\t %x -> %.2f\n", roll, sc,
                        h, bestMask, bestScore);
                workingVals[0][hand].put(sc.hashCode(), bestScore);
                db.addRollingAction((byte) bestMask, sc, h, roll);

            }
           copyResultsToNextRound();
        }
        Utils.debug("Generated all base cases for %s with upperTotal %d\n",
                cat, upperTotal);
        return null;
    }
}
