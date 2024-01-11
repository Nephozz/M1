/**
 */
package simplepdl;

import org.eclipse.emf.ecore.EObject;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Ressource Used</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * </p>
 * <ul>
 *   <li>{@link simplepdl.RessourceUsed#getOcc <em>Occ</em>}</li>
 *   <li>{@link simplepdl.RessourceUsed#getRessources <em>Ressources</em>}</li>
 *   <li>{@link simplepdl.RessourceUsed#getWorkdefinition <em>Workdefinition</em>}</li>
 * </ul>
 *
 * @see simplepdl.SimplepdlPackage#getRessourceUsed()
 * @model
 * @generated
 */
public interface RessourceUsed extends EObject {
	/**
	 * Returns the value of the '<em><b>Occ</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Occ</em>' attribute.
	 * @see #setOcc(int)
	 * @see simplepdl.SimplepdlPackage#getRessourceUsed_Occ()
	 * @model required="true"
	 * @generated
	 */
	int getOcc();

	/**
	 * Sets the value of the '{@link simplepdl.RessourceUsed#getOcc <em>Occ</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Occ</em>' attribute.
	 * @see #getOcc()
	 * @generated
	 */
	void setOcc(int value);

	/**
	 * Returns the value of the '<em><b>Ressources</b></em>' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Ressources</em>' reference.
	 * @see #setRessources(Ressource)
	 * @see simplepdl.SimplepdlPackage#getRessourceUsed_Ressources()
	 * @model required="true"
	 * @generated
	 */
	Ressource getRessources();

	/**
	 * Sets the value of the '{@link simplepdl.RessourceUsed#getRessources <em>Ressources</em>}' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Ressources</em>' reference.
	 * @see #getRessources()
	 * @generated
	 */
	void setRessources(Ressource value);

	/**
	 * Returns the value of the '<em><b>Workdefinition</b></em>' container reference.
	 * It is bidirectional and its opposite is '{@link simplepdl.WorkDefinition#getRessourcesUsed <em>Ressources Used</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Workdefinition</em>' container reference.
	 * @see #setWorkdefinition(WorkDefinition)
	 * @see simplepdl.SimplepdlPackage#getRessourceUsed_Workdefinition()
	 * @see simplepdl.WorkDefinition#getRessourcesUsed
	 * @model opposite="ressourcesUsed" required="true" transient="false"
	 * @generated
	 */
	WorkDefinition getWorkdefinition();

	/**
	 * Sets the value of the '{@link simplepdl.RessourceUsed#getWorkdefinition <em>Workdefinition</em>}' container reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Workdefinition</em>' container reference.
	 * @see #getWorkdefinition()
	 * @generated
	 */
	void setWorkdefinition(WorkDefinition value);

} // RessourceUsed
