package se.kth.ansjobmarcular;

/**
 *
 *
 */
public class App {


	public static void main(String[] args) throws Throwable {
		long time;
		Class.forName("se.kth.ansjobmarcular.Hand");
		Generator gen = new Generator();
		
		/* Generate the base cases. */
		Utils.debugTS("Generating base cases...\n");
		time = System.currentTimeMillis();
		gen.generateBaseCases();
		Utils.debugTS("Generated base cases in %dms\n", System.currentTimeMillis() - time);
		
		/* Generate other cases. */
		Utils.debugTS("Generating other cases...\n");
		time = System.currentTimeMillis();
		gen.generate();
		Utils.debugTS("Generated other cases in %dms\n", System.currentTimeMillis() - time);
		gen.close();

	}
}
