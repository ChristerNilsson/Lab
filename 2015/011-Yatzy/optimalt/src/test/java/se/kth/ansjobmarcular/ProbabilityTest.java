/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package se.kth.ansjobmarcular;

import static org.junit.Assert.*;
import org.junit.Test;

/**
 *
 * @author ansjob
 */
public class ProbabilityTest {

    @Test
    public void sameProbabilityOne() {
        Hand h = new Hand(1,1,1,1,1);
        Hand other = new Hand(1,1,1,1,1);
        assertEquals(1.0, h.probability(other, 0xFF), 0.00001);
    }

    @Test
    public void allDiffProbability() {
        Hand h = new Hand(1,1,1,1,1);
        Hand other = new Hand(2,2,2,2,2);
        assertEquals(1.0/7776.0, h.probability(other, 0x00), 0.00001);
    }

    @Test
    public void fullHouseTest() {
        Hand h = new Hand(1,2,3,4,5);
        Hand other = new Hand(1,1,1,2,2);
        assertEquals(3/216.0, h.probability(other, 0x18), 0.00001);
    }

	@Test
	public void oneDiffTest() {
        Hand h = new Hand(1,2,3,4,5);
        Hand other = new Hand(1,2,3,4,6);
        assertEquals(1.0/6.0, h.probability(other, 0x1e), 0.00001);
	}

	@Test
	public void noChanceTest() {
        Hand h = new Hand(1,2,3,4,5);
        Hand other = new Hand(4, 4, 4, 4, 4);
        assertEquals(0.0, h.probability(other, 0x1F), 0.00001);
	}
}
