/**
 * generated by Xtext 2.23.0
 */
package fr.n7.algorithmeXtext.impl;

import fr.n7.algorithmeXtext.*;

import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.EPackage;

import org.eclipse.emf.ecore.impl.EFactoryImpl;

import org.eclipse.emf.ecore.plugin.EcorePlugin;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model <b>Factory</b>.
 * <!-- end-user-doc -->
 * @generated
 */
public class AlgorithmeXtextFactoryImpl extends EFactoryImpl implements AlgorithmeXtextFactory
{
  /**
   * Creates the default factory implementation.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public static AlgorithmeXtextFactory init()
  {
    try
    {
      AlgorithmeXtextFactory theAlgorithmeXtextFactory = (AlgorithmeXtextFactory)EPackage.Registry.INSTANCE.getEFactory(AlgorithmeXtextPackage.eNS_URI);
      if (theAlgorithmeXtextFactory != null)
      {
        return theAlgorithmeXtextFactory;
      }
    }
    catch (Exception exception)
    {
      EcorePlugin.INSTANCE.log(exception);
    }
    return new AlgorithmeXtextFactoryImpl();
  }

  /**
   * Creates an instance of the factory.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public AlgorithmeXtextFactoryImpl()
  {
    super();
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public EObject create(EClass eClass)
  {
    switch (eClass.getClassifierID())
    {
      case AlgorithmeXtextPackage.ALGORITHME: return createAlgorithme();
      case AlgorithmeXtextPackage.ALGORITHME_ELEMENT: return createAlgorithmeElement();
      case AlgorithmeXtextPackage.RESSOURCE: return createRessource();
      case AlgorithmeXtextPackage.SORTIE: return createSortie();
      case AlgorithmeXtextPackage.ENTREE: return createEntree();
      default:
        throw new IllegalArgumentException("The class '" + eClass.getName() + "' is not a valid classifier");
    }
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public Algorithme createAlgorithme()
  {
    AlgorithmeImpl algorithme = new AlgorithmeImpl();
    return algorithme;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public AlgorithmeElement createAlgorithmeElement()
  {
    AlgorithmeElementImpl algorithmeElement = new AlgorithmeElementImpl();
    return algorithmeElement;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public Ressource createRessource()
  {
    RessourceImpl ressource = new RessourceImpl();
    return ressource;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public Sortie createSortie()
  {
    SortieImpl sortie = new SortieImpl();
    return sortie;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public Entree createEntree()
  {
    EntreeImpl entree = new EntreeImpl();
    return entree;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public AlgorithmeXtextPackage getAlgorithmeXtextPackage()
  {
    return (AlgorithmeXtextPackage)getEPackage();
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @deprecated
   * @generated
   */
  @Deprecated
  public static AlgorithmeXtextPackage getPackage()
  {
    return AlgorithmeXtextPackage.eINSTANCE;
  }

} //AlgorithmeXtextFactoryImpl