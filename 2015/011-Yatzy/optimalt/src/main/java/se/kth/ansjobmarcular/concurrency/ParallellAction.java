/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package se.kth.ansjobmarcular.concurrency;

import java.util.Map;
import java.util.concurrent.Callable;
import java.util.concurrent.ConcurrentHashMap;

import se.kth.ansjobmarcular.Hand;

/**
 *
 * @author ansjob
 */
public abstract class ParallellAction implements Callable<Void> {

    protected Map<Integer, Double>[][] workingVals;
    protected final Map<Integer, Double> expectedScores;


    public ParallellAction(
            Map<Integer, Double> expectedScores) {
        this.expectedScores = expectedScores;
        
    }
    
    @SuppressWarnings("unchecked")
	protected void BeforeCall() throws Exception {
    	this.workingVals = (Map<Integer, Double>[][]) new Map<?,?>[2][Hand.MAX_INDEX+1];
        for (int i = 0; i < 2; i++) {
        	for (int j = 0; j <= Hand.MAX_INDEX; j++) {
        		workingVals[i][j] = new ConcurrentHashMap<Integer, Double>();
        	}
        }
    }

    @SuppressWarnings("unchecked")
	protected void copyResultsToNextRound() {
    	 workingVals[1] = workingVals[0]; //Remember stuff until next round
         workingVals[0] = (Map<Integer, Double>[]) new Map<?,?>[Hand.MAX_INDEX+1];
         for (int i = 0; i <= Hand.MAX_INDEX; i++) {
         	workingVals[0][i] = new ConcurrentHashMap<Integer, Double>();
         }
    }


}
