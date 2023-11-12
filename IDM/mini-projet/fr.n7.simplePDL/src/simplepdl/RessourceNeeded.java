/**
 */
package simplepdl;

import org.eclipse.emf.ecore.EObject;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Ressource Needed</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * </p>
 * <ul>
 *   <li>{@link simplepdl.RessourceNeeded#getQuantityNeeded <em>Quantity Needed</em>}</li>
 *   <li>{@link simplepdl.RessourceNeeded#getRessource <em>Ressource</em>}</li>
 * </ul>
 *
 * @see simplepdl.SimplepdlPackage#getRessourceNeeded()
 * @model
 * @generated
 */
public interface RessourceNeeded extends EObject {
	/**
	 * Returns the value of the '<em><b>Quantity Needed</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Quantity Needed</em>' attribute.
	 * @see #setQuantityNeeded(int)
	 * @see simplepdl.SimplepdlPackage#getRessourceNeeded_QuantityNeeded()
	 * @model required="true"
	 * @generated
	 */
	int getQuantityNeeded();

	/**
	 * Sets the value of the '{@link simplepdl.RessourceNeeded#getQuantityNeeded <em>Quantity Needed</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Quantity Needed</em>' attribute.
	 * @see #getQuantityNeeded()
	 * @generated
	 */
	void setQuantityNeeded(int value);

	/**
	 * Returns the value of the '<em><b>Ressource</b></em>' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Ressource</em>' reference.
	 * @see #setRessource(RessourceType)
	 * @see simplepdl.SimplepdlPackage#getRessourceNeeded_Ressource()
	 * @model required="true"
	 * @generated
	 */
	RessourceType getRessource();

	/**
	 * Sets the value of the '{@link simplepdl.RessourceNeeded#getRessource <em>Ressource</em>}' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Ressource</em>' reference.
	 * @see #getRessource()
	 * @generated
	 */
	void setRessource(RessourceType value);

} // RessourceNeeded
