/**
 * generated by Xtext 2.23.0
 */
package fr.n7.pDL1;


/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Ressource</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * </p>
 * <ul>
 *   <li>{@link fr.n7.pDL1.Ressource#getName <em>Name</em>}</li>
 *   <li>{@link fr.n7.pDL1.Ressource#getQuantity <em>Quantity</em>}</li>
 * </ul>
 *
 * @see fr.n7.pDL1.PDL1Package#getRessource()
 * @model
 * @generated
 */
public interface Ressource extends ProcessElement
{
  /**
   * Returns the value of the '<em><b>Name</b></em>' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @return the value of the '<em>Name</em>' attribute.
   * @see #setName(String)
   * @see fr.n7.pDL1.PDL1Package#getRessource_Name()
   * @model
   * @generated
   */
  String getName();

  /**
   * Sets the value of the '{@link fr.n7.pDL1.Ressource#getName <em>Name</em>}' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @param value the new value of the '<em>Name</em>' attribute.
   * @see #getName()
   * @generated
   */
  void setName(String value);

  /**
   * Returns the value of the '<em><b>Quantity</b></em>' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @return the value of the '<em>Quantity</em>' attribute.
   * @see #setQuantity(int)
   * @see fr.n7.pDL1.PDL1Package#getRessource_Quantity()
   * @model
   * @generated
   */
  int getQuantity();

  /**
   * Sets the value of the '{@link fr.n7.pDL1.Ressource#getQuantity <em>Quantity</em>}' attribute.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @param value the new value of the '<em>Quantity</em>' attribute.
   * @see #getQuantity()
   * @generated
   */
  void setQuantity(int value);

} // Ressource