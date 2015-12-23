package se.kth.ansjobmarcular;

import java.text.DateFormat;
import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

import se.kth.ansjobmarcular.concurrency.basecases.BaseCase;
import se.kth.ansjobmarcular.concurrency.recursion.RollCase;


public class Generator {

    // The array containing the optimal strategy.
    private Map<Integer, Double> expectedScores;
    private static final int NUM_THREADS = 8;
    private ActionsStorage db = new MemoryActionsStorage();

    //private final boolean USE_THREADS = true; // Parallell 14 minuter
    private final boolean USE_THREADS = false;  // Serie     50 minuter

    public Generator() {
        expectedScores = new ConcurrentHashMap<Integer, Double>();
    }

    public void generateBaseCases() throws Exception {
        // For every last (unfilled) category.
        ExecutorService run = Executors.newFixedThreadPool(NUM_THREADS);
        for (Category cat : Category.values()) {
            // The upper total only matters for the first six categories
            for (int upperTotal = 0; upperTotal <= 63; upperTotal++) {
                BaseCase task = new BaseCase(expectedScores, upperTotal, cat, db);
                if (USE_THREADS) {
                    run.submit(task);
                } else {
                    task.call();
                }
            }

        }
        run.shutdown();
        run.awaitTermination(1, TimeUnit.DAYS);
    }

    @SuppressWarnings("unchecked")
    public void generate() throws Exception {
        boolean[][] ways;
        ScoreCard sc;

        // For every round in the game (backwards).
        for (byte filled = 13; filled >= 0; filled--) {
             // For every way the scorecard may be filled when we get here
            ExecutorService run = Executors.newFixedThreadPool(NUM_THREADS);
            ways = Utils.allWaysToPut(filled, 15);
            for (boolean[] way : ways) {
                //* Fill out the scorecard in this new way
                sc = new ScoreCard();
                for (byte i = 0; i < way.length; i++) {
                    if (way[i]) {
                        sc.fillScore(Category.values()[i]);
                    }
                }
                // For every possible upperTotal score.
                for (byte upperTotal = 0; upperTotal < 64; upperTotal++) {
                    ScoreCard tmpsc = sc.getCopy();
                    tmpsc.addScore(upperTotal);
                    RollCase task = new RollCase(expectedScores, tmpsc, db);
                    if (USE_THREADS) {
                        run.submit(task);
                    } else {
                        task.call();
                    }
                }
            }
            run.shutdown();
            run.awaitTermination(1, TimeUnit.DAYS);

            DateFormat df = DateFormat.getTimeInstance();
            System.out.printf("[%s] Done with recursion step %d\n", df.format(new Date()), 14 - filled);
        }

        // Print the expected score for a Yatzy game.
        System.out.printf("Expected total score: %.2f\n", expectedScores.get(new ScoreCard().hashCode()));
        db.close();
    }

    /**
     * Copies the results from upperTotal=0 to all other upperTotal values in
     * the database, to facilitate lookups later.
     */
//    private void copyResults() {
//        long startTime = System.currentTimeMillis();
//        Utils.debug("Starting to copy results for PAIR -> YATZY\n\n");
//        Category[] values = Category.values();
//        for (int cat = 6; cat < values.length; cat++) {
//            Category c = values[cat];
//            /*
//             * Now let's generate the scorecard
//             */
//            ScoreCard sc = new ScoreCard();
//            for (Category other : values) {
//                if (!other.equals(c)) {
//                    sc.fillScore(other);
//                }
//            }
//            Utils.debug("Copying values for %s\n", c);
//            for (short hand = 1; hand <= Hand.MAX_INDEX; hand++) {
//                Hand h = Hand.getHand(hand);
//                for (byte roll = 0; roll <= 3; roll++) {
//                    int action;
//                    if (roll == 3) {
//                        action = db.suggestMarking(h, sc);
//                    } else {
//                        action = db.suggestRoll(h, sc, roll);
//                    }
//                    for (byte upperTotal = 1; upperTotal <= 63; upperTotal++, sc.addScore(1)) {
//                        if (roll == 3) {
//                            db.addMarkingAction((byte) action, sc, h);
//                        } else {
//                            db.addRollingAction((byte) action, sc, h, roll);
//                        }
//                    }
//                }
//                Utils.debug("Copied everything for %s with hand %s\n", c, h.toString());
//            }
//        }
//        long elapsed = System.currentTimeMillis() - startTime;
//        Utils.debug("Copied base cases in %d ms\n", elapsed);
//    }
//
//    public void copyResults(ScoreCard sc) {
//
//        Utils.debug("Copying values for %s\n", sc);
//        for (int hand = 1; hand <= Hand.MAX_INDEX; hand++) {
//            Hand h = Hand.getHand(hand);
//            for (int roll = 0; roll <= 3; roll++) {
//                int action;
//                if (roll == 3) {
//                    action = db.suggestMarking(h, sc);
//                } else {
//                    action = db.suggestRoll(h, sc, roll);
//                }
//                for (int upperTotal = 1; upperTotal <= 63; upperTotal++, sc.addScore(1)) {
//                    if (roll == 3) {
//                        db.addMarkingAction((byte) action, sc, h);
//                    } else {
//                        db.addRollingAction((byte) action, sc, h, roll);
//                    }
//                }
//            }
//            Utils.debug("Copied everything for %s with hand %s\n", sc, h.toString());
//        }
//    }

    public void close() {
        db.close();
    }

}
