package exception;
import java.lang.reflect.Method;

public class UnauthorizedException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Class<?> classE;
	
	private String method;
	
	public UnauthorizedException(Class<?> classE, String method) {
		this.classE = classE;
		this.method = method;
	}
	
	public String toString() {
		String s = "Error : the operation " + method + " is unauthorized for a " + classE +".";
		return s;
		
	}

}
