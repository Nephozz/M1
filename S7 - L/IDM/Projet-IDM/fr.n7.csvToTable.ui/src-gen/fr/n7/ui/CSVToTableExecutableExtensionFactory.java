/*
 * generated by Xtext 2.23.0
 */
package fr.n7.ui;

import com.google.inject.Injector;
import fr.n7.csvToTable.ui.internal.CsvToTableActivator;
import org.eclipse.core.runtime.Platform;
import org.eclipse.xtext.ui.guice.AbstractGuiceAwareExecutableExtensionFactory;
import org.osgi.framework.Bundle;

/**
 * This class was generated. Customizations should only happen in a newly
 * introduced subclass. 
 */
public class CSVToTableExecutableExtensionFactory extends AbstractGuiceAwareExecutableExtensionFactory {

	@Override
	protected Bundle getBundle() {
		return Platform.getBundle(CsvToTableActivator.PLUGIN_ID);
	}
	
	@Override
	protected Injector getInjector() {
		CsvToTableActivator activator = CsvToTableActivator.getInstance();
		return activator != null ? activator.getInjector(CsvToTableActivator.FR_N7_CSVTOTABLE) : null;
	}

}