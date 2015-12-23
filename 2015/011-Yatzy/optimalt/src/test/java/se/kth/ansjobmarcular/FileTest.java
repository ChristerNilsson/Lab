package se.kth.ansjobmarcular;

import static org.junit.Assert.assertEquals;

import org.junit.BeforeClass;
import org.junit.*;

public class FileTest {
	
	private static ActionsStorage db;
	
	@BeforeClass
	public static void init() {
		db = new FileActionsStorage();
	}
	
	@Ignore
	public void Yatzy() {
		ScoreCard sc = new ScoreCard();
		Hand h = new Hand(1,1,1,1,1);
		byte action = db.suggestMarking(h, sc);
		Category expected = Category.YATZY;
		Category actual = Category.values[action];
		assertEquals(expected, actual);
	}
	
}
