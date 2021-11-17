package functional;

import com.intuit.karate.junit5.Karate;

public class TestRunner {
    @Karate.Test
    Karate testSample() {
    	return Karate.run().relativeTo(getClass());
//        return Karate.run("*.feature").relativeTo(getClass());
    }
//    @Karate.Test
//    Karate testFullPath() {
//        return Karate.run("classpath:karate/sample2.feature").relativeTo(getClass());
//    }
}
