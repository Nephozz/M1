/**
 */
package petrinet;

import org.eclipse.emf.ecore.EObject;

/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Arc</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * </p>
 * <ul>
 *   <li>{@link petrinet.Arc#getWeight <em>Weight</em>}</li>
 *   <li>{@link petrinet.Arc#getKind <em>Kind</em>}</li>
 *   <li>{@link petrinet.Arc#getPlace <em>Place</em>}</li>
 *   <li>{@link petrinet.Arc#getTransition <em>Transition</em>}</li>
 *   <li>{@link petrinet.Arc#getDirection <em>Direction</em>}</li>
 * </ul>
 *
 * @see petrinet.PetrinetPackage#getArc()
 * @model
 * @generated
 */
public interface Arc extends EObject {
	/**
	 * Returns the value of the '<em><b>Weight</b></em>' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Weight</em>' attribute.
	 * @see #setWeight(int)
	 * @see petrinet.PetrinetPackage#getArc_Weight()
	 * @model required="true"
	 * @generated
	 */
	int getWeight();

	/**
	 * Sets the value of the '{@link petrinet.Arc#getWeight <em>Weight</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Weight</em>' attribute.
	 * @see #getWeight()
	 * @generated
	 */
	void setWeight(int value);

	/**
	 * Returns the value of the '<em><b>Kind</b></em>' attribute.
	 * The literals are from the enumeration {@link petrinet.ArcKind}.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Kind</em>' attribute.
	 * @see petrinet.ArcKind
	 * @see #setKind(ArcKind)
	 * @see petrinet.PetrinetPackage#getArc_Kind()
	 * @model required="true"
	 * @generated
	 */
	ArcKind getKind();

	/**
	 * Sets the value of the '{@link petrinet.Arc#getKind <em>Kind</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Kind</em>' attribute.
	 * @see petrinet.ArcKind
	 * @see #getKind()
	 * @generated
	 */
	void setKind(ArcKind value);

	/**
	 * Returns the value of the '<em><b>Place</b></em>' reference.
	 * It is bidirectional and its opposite is '{@link petrinet.Place#getArcs <em>Arcs</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Place</em>' reference.
	 * @see #setPlace(Place)
	 * @see petrinet.PetrinetPackage#getArc_Place()
	 * @see petrinet.Place#getArcs
	 * @model opposite="arcs"
	 * @generated
	 */
	Place getPlace();

	/**
	 * Sets the value of the '{@link petrinet.Arc#getPlace <em>Place</em>}' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Place</em>' reference.
	 * @see #getPlace()
	 * @generated
	 */
	void setPlace(Place value);

	/**
	 * Returns the value of the '<em><b>Transition</b></em>' reference.
	 * It is bidirectional and its opposite is '{@link petrinet.Transition#getArcs <em>Arcs</em>}'.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Transition</em>' reference.
	 * @see #setTransition(Transition)
	 * @see petrinet.PetrinetPackage#getArc_Transition()
	 * @see petrinet.Transition#getArcs
	 * @model opposite="arcs"
	 * @generated
	 */
	Transition getTransition();

	/**
	 * Sets the value of the '{@link petrinet.Arc#getTransition <em>Transition</em>}' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Transition</em>' reference.
	 * @see #getTransition()
	 * @generated
	 */
	void setTransition(Transition value);

	/**
	 * Returns the value of the '<em><b>Direction</b></em>' attribute.
	 * The literals are from the enumeration {@link petrinet.ArcDirection}.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Direction</em>' attribute.
	 * @see petrinet.ArcDirection
	 * @see #setDirection(ArcDirection)
	 * @see petrinet.PetrinetPackage#getArc_Direction()
	 * @model required="true"
	 * @generated
	 */
	ArcDirection getDirection();

	/**
	 * Sets the value of the '{@link petrinet.Arc#getDirection <em>Direction</em>}' attribute.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Direction</em>' attribute.
	 * @see petrinet.ArcDirection
	 * @see #getDirection()
	 * @generated
	 */
	void setDirection(ArcDirection value);

} // Arc
