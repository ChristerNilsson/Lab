/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package se.kth.ansjobmarcular;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

/**
 *
 * @author ansjob
 */
public class MemoryActionsStorage implements ActionsStorage {

	private static final String FILENAME = "/tmp/actions";
	private byte[][][] storage = new byte[3][Hand.MAX_INDEX + 1][ScoreCard.MAX_INDEX + 1];

	@Override
	public byte suggestRoll(Hand currentHand, ScoreCard currentScore, int roll) {
		return storage[roll-1][currentHand.getIndex()][currentScore.getIndex()];
	}

	@Override
	public byte suggestMarking(Hand currentHand, ScoreCard currentScore) {
		return storage[2][currentHand.getIndex()][currentScore.getIndex()];
	}

	@Override
	public void addMarkingAction(byte action, ScoreCard currentScore, Hand hand) {
		storage[2][hand.getIndex()][currentScore.getIndex()] = (byte) action;
	}

	@Override
	public void addRollingAction(byte action, ScoreCard currentScore,
			Hand hand, int roll) {
		storage[roll-1][hand.getIndex()][currentScore.getIndex()] = (byte) action;
	}

	@Override
	public void putExpectedScore(double expected, ScoreCard currentScore,
			Hand hand, int roll) {
		throw new UnsupportedOperationException("Not supported yet.");
	}

	@Override
	public double getExpectedScore(ScoreCard currentScore, Hand hand, int roll) {
		throw new UnsupportedOperationException("Not supported yet.");
	}

	@Override
	public void close() {
		try {
			PrintWriter out = new PrintWriter(new BufferedWriter(
					new FileWriter(FILENAME)));
			for (int i = 0; i < storage.length; i++) {
				for (int j = 0; j < storage[i].length; j++) {
					for (int k = 0; k < storage[i][j].length; k++) {
						out.write(storage[i][j][k]);
					}
				}
			}
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
