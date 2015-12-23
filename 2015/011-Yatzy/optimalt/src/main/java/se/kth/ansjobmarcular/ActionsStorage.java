package se.kth.ansjobmarcular;

public interface ActionsStorage {
	
	/**
	 * Fetches the action associated in the database with this state of the game.
	 * @param currentHand The dice possessed by the player
	 * @param currentScore The scorecard the player has
	 * @param roll an integer 0, 1, or 2 (how many times the player has already rolled the dice)
	 * @return An action that encodes which dice to hold
	 */
	public byte suggestRoll(Hand currentHand, ScoreCard currentScore, int roll);

	/**
	 * Will get the action stored in the database how to mark the scorecard with a given hand.
	 * @param currentHand The hand at the end of the rolls
	 * @param currentScore The scorecard.
	 * @return A {@link MarkingAction} that tells how to mark the scorecard.
	 */
	public byte suggestMarking(Hand currentHand, ScoreCard currentScore);
	
	/**
	 * Saves the action for later retrieval.
	 * @param action
	 * @param currentScore
	 * @param hand
	 */
	public void addMarkingAction(byte action, ScoreCard currentScore, Hand hand);
	
	/**
	 * Saves the action for later retrieval.
	 * @param action
	 * @param currentScore
	 * @param hand
	 * @param roll
	 */
	public void addRollingAction(byte action, ScoreCard currentScore, Hand hand, int roll);
	
	public void putExpectedScore(double expected, ScoreCard currentScore, Hand hand, int roll);

	public double getExpectedScore(ScoreCard currentScore, Hand hand, int roll);
	
	public void close();
}
