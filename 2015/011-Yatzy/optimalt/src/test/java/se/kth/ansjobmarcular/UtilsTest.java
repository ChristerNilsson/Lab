/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package se.kth.ansjobmarcular;

import java.util.Arrays;

import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author ansjob
 */
public class UtilsTest {

    @Test
    public void TestOne() {
        boolean[] bools = {true};
        assertEquals(1, Utils.fromBooleanArray(bools));
    }

    @Test
    public void TestTwo() {
        boolean[] bools = {true, false};
        assertEquals(2, Utils.fromBooleanArray(bools));
    }

    @Test
    public void Test42() {
        boolean[] bools = {true, false, true, false, true, false};
        assertEquals(42, Utils.fromBooleanArray(bools));
    }

    @Test
    public void OneToBoolean() {
        int x = 1;
        int size = 4;
        boolean[] expected = {false, false, false, true};
        assertTrue(Arrays.equals(expected, Utils.fromInt(x, size)));
    }

    @Test
    public void FiveToBoolean() {
        int x = 5;
        int size = 4;
        boolean[] expected = {false, true, false, true};
        assertTrue(Arrays.equals(expected, Utils.fromInt(x, size)));
    }

    @Test
    public void bigTest() {
        for (int i = 0; i < 1024; i++) {
            assertEquals(i, Utils.fromBooleanArray(Utils.fromInt(i, 32)));
        }
    }
    
    @Test
    public void test3Ways() {
    	int size = 3; int trues = 2;
    	boolean[][] expected = {	
    			{false, true, true},
    			{true, false, true},
    			{true, true, false}
    	};
    	boolean[][] actuals = Utils.allWaysToPut(trues, size);
    	for (int i = 0; i < expected.length; i++) {
    		assertTrue(Arrays.equals(expected[i], actuals[i]));
    	}
    }
    
    @Test
    public void test8Ways() {
    	int size = 5; int trues = 3;
    	boolean[][] expected = {	
    			{false, false, true, true, true},
    			{false, true, false, true, true},
    			{true, false, false, true, true},
    			{false, true, true, false, true},
    			{true, false, true, false, true},
    			{true, true, false, false, true},
    			{false, true, true, true, false},
    			{true, false, true, true, false},
    			{true, true, false, true, false},
    			{true, true, true, false, false}
    			
    	};
    	boolean[][] actuals = Utils.allWaysToPut(trues, size);
    	for (int i = 0; i < expected.length; i++) {
    		assertTrue(Arrays.equals(expected[i], actuals[i]));
    	}
    }
    
    @Test
    public void testBinaryStrings() {
    	assertEquals("11111111", Utils.maskToBinaryString(0xff));
    	assertEquals("11101111", Utils.maskToBinaryString(239));
    	assertEquals("10100011", Utils.maskToBinaryString(163));
    	assertEquals("111111111", Utils.maskToBinaryString(0x1ff));
    	assertEquals("0", Utils.maskToBinaryString(0));
    }

}

