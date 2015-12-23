package se.kth.ansjobmarcular;

import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

public class FileActionsStorage implements ActionsStorage {

	private static final long MAX_INDEX = 3 * (Hand.MAX_INDEX + 1)
			* (ScoreCard.MAX_INDEX + 1);

	private RandomAccessFile fp;

	private static final int BUFSIZE = 1024 * 1024;
	private int count = 0;
	private Map<Long, Byte> buffer;

    private ExecutorService ioRunner = Executors.newSingleThreadExecutor();



	public FileActionsStorage() {
		File file = new File("/tmp/actions");
		buffer = new HashMap<Long, Byte>(BUFSIZE);
		try {
			fp = new RandomAccessFile(file, "r");
			//fp = new RandomAccessFile(file, "rw");
			//fp.setLength(MAX_INDEX);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public byte suggestRoll(Hand currentHand, ScoreCard currentScore, int roll) {
		long index = getIndex(currentScore, currentHand, roll-1);
		int b = getByte(index);
		return (byte) b;
	}

	public byte suggestMarking(Hand currentHand, ScoreCard currentScore) {
		long index = getIndex(currentScore, currentHand, 2);
		return (byte) getByte(index);
	}

	public void addMarkingAction(byte action, ScoreCard currentScore, Hand hand) {
		long index = getIndex(currentScore, hand, 2);
		putByte(index, action);
	}

	public void addRollingAction(byte action, ScoreCard currentScore,
			Hand hand, int roll) {
		long index = getIndex(currentScore, hand, roll-1);
		putByte(index, action);
	}

	public void putExpectedScore(double expected, ScoreCard currentScore,
			Hand hand, int roll) {
		throw new UnsupportedOperationException();
	}

	public double getExpectedScore(ScoreCard currentScore, Hand hand, int roll) {
		throw new UnsupportedOperationException();
	}

	long cardSize = 1;
	long handSize = cardSize * (ScoreCard.MAX_INDEX + 1);
	long rollSize = handSize * (Hand.MAX_INDEX + 1);

	private long getIndex(ScoreCard sc, Hand hand, int roll) {
		long idx = (rollSize * roll) + (handSize * hand.getIndex())
				+ (cardSize * sc.getIndex());
		return idx;
	}

	private synchronized void putByte(long index, int b) {
		try {
			count++;
			buffer.put(index, (byte) b);
			if (count % BUFSIZE == 0) {
				flush();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private synchronized int getByte(long index) {
		flush();
		try {
			fp.seek(index);
			int b = fp.read();
			return b;
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(-1);
			return -1;
		}
	}

	public void close() {
		try {
            ioRunner.shutdown();
            ioRunner.awaitTermination(10, TimeUnit.MINUTES);
			fp.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public synchronized void flush() {
		Set<Map.Entry<Long, Byte>> tmp = buffer.entrySet();
		for (Map.Entry<Long, Byte> entry : tmp) {
			try {
				fp.seek(entry.getKey());
				fp.writeByte(entry.getValue());
			} catch (IOException e) {
				e.printStackTrace();
				System.exit(-1);
			}
		}
		buffer.clear();
		count = 0;
	}

}
