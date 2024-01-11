/**
 * 
 */
package fr.n7.simplePDL2petriNet;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.ResourceSet;
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl;
import org.eclipse.emf.ecore.xmi.impl.XMIResourceFactoryImpl;

import petrinet.*;
import simplepdl.*;
import simplepdl.Process;

/**
 * @author taudard
 *
 */
public class SimplePDL2PetriNet {

	private static PetrinetFactory myFactory;
	private static PetriNet petri;
	
	private static Map<String, Place> mapPlaceStarted = new HashMap<String, Place>();
	private static Map<String, Place> mapPlaceFinished = new HashMap<String, Place>();

	private static Map<String, Transition> mapTransitionStart = new HashMap<String, Transition>();
	private static Map<String, Transition> mapTransitionFinish = new HashMap<String, Transition>();
	
	private static Map<String, Place> mapRessource = new HashMap<String, Place>();

	private static void WD2PetriNet(WorkDefinition wd) {
		// Création des places
		Place placeNotStarted = myFactory.createPlace();
		Place placeStarted = myFactory.createPlace();
		Place placeRunning = myFactory.createPlace();
		Place placeFinished = myFactory.createPlace();

		placeNotStarted.setName(wd.getName() + "_NotStarted");
		placeStarted.setName(wd.getName() + "_Started");
		placeRunning.setName(wd.getName() + "_Running");
		placeFinished.setName(wd.getName() + "_Finished");
		
		placeNotStarted.setJeton(1);
		placeStarted.setJeton(0);
		placeRunning.setJeton(0);
		placeFinished.setJeton(0);

		petri.getNodes().add(placeNotStarted);
		petri.getNodes().add(placeStarted);
		petri.getNodes().add(placeRunning);
		petri.getNodes().add(placeFinished);

		mapPlaceStarted.put(wd.getName(), placeStarted);
		mapPlaceFinished.put(wd.getName(), placeFinished);

		// Création des transitions
		Transition transitionStart = myFactory.createTransition();
		Transition transitionFinish = myFactory.createTransition();

		transitionStart.setName(wd.getName() + "_start");
		transitionFinish.setName(wd.getName() + "_finish");

		petri.getNodes().add(transitionStart);
		petri.getNodes().add(transitionFinish);

		mapTransitionStart.put(wd.getName(), transitionStart);
		mapTransitionFinish.put(wd.getName(), transitionFinish);

		// Création des arcs
		Arc arcNS2Start = myFactory.createArc();
		Arc arcStart2Started = myFactory.createArc();
		Arc arcStart2Running = myFactory.createArc();
		Arc arcRunning2Finish = myFactory.createArc();
		Arc arcFinish2Finished = myFactory.createArc();

		arcNS2Start.setSource(placeNotStarted);
		arcNS2Start.setTarget(transitionStart);
		arcNS2Start.setDirection(ArcDirection.PLACE_TO_TRANSITION);
		arcNS2Start.setKind(ArcKind.NORMAL);
		arcNS2Start.setWeight(1);

		arcStart2Started.setSource(transitionStart);
		arcStart2Started.setTarget(placeStarted);
		arcStart2Started.setDirection(ArcDirection.TRANSITION_TO_PLACE);
		arcStart2Started.setKind(ArcKind.NORMAL);
		arcStart2Started.setWeight(1);

		arcStart2Running.setSource(transitionStart);
		arcStart2Running.setTarget(placeRunning);
		arcStart2Running.setDirection(ArcDirection.TRANSITION_TO_PLACE);
		arcStart2Running.setKind(ArcKind.NORMAL);
		arcStart2Running.setWeight(1);

		arcRunning2Finish.setSource(placeRunning);
		arcRunning2Finish.setTarget(transitionFinish);
		arcRunning2Finish.setDirection(ArcDirection.PLACE_TO_TRANSITION);
		arcRunning2Finish.setKind(ArcKind.NORMAL);
		arcRunning2Finish.setWeight(1);

		arcFinish2Finished.setSource(transitionFinish);
		arcFinish2Finished.setTarget(placeFinished);
		arcFinish2Finished.setDirection(ArcDirection.TRANSITION_TO_PLACE);
		arcFinish2Finished.setKind(ArcKind.NORMAL);
		arcFinish2Finished.setWeight(1);

		petri.getArcs().add(arcNS2Start);
		petri.getArcs().add(arcStart2Started);
		petri.getArcs().add(arcStart2Running);
		petri.getArcs().add(arcRunning2Finish);
		petri.getArcs().add(arcFinish2Finished);
		
		for (Object o : wd.getRessourcesUsed()) {
			if (o instanceof RessourceUsed) {
				RU2Arc((RessourceUsed) o);
			}
		}
	}

	private static void WS2ReadArc(WorkSequence ws) {
		// Création du read arc
		Arc readArc = myFactory.createArc();
		readArc.setDirection(ArcDirection.PLACE_TO_TRANSITION);
		readArc.setKind(ArcKind.READ);
		readArc.setWeight(1);
		switch (ws.getLinkType()) {
		case START_TO_START :
			readArc.setSource(mapPlaceStarted.get(ws.getPredecessor().getName()));
			readArc.setTarget(mapTransitionStart.get(ws.getSuccessor().getName()));
			break;
		case START_TO_FINISH :
			readArc.setSource(mapPlaceStarted.get(ws.getPredecessor().getName()));
			readArc.setTarget(mapTransitionFinish.get(ws.getSuccessor().getName()));
			break;
		case FINISH_TO_START :
			readArc.setSource(mapPlaceFinished.get(ws.getPredecessor().getName()));
			readArc.setTarget(mapTransitionStart.get(ws.getSuccessor().getName()));
			break;
		case FINISH_TO_FINISH :
			readArc.setSource(mapPlaceFinished.get(ws.getPredecessor().getName()));
			readArc.setTarget(mapTransitionFinish.get(ws.getSuccessor().getName()));
			break;
		}
		petri.getArcs().add(readArc);
	}
	
	
	private static void R2Place(Ressource r) {
		// Création de la place ressource
		Place ressource = myFactory.createPlace();
		ressource.setName(r.getName());
		ressource.setJeton(r.getQuantity());
		petri.getNodes().add(ressource);
		mapRessource.put(r.getName(), ressource);
	}
	
	private static void RU2Arc(RessourceUsed r_used) {
		// Ressource to Transition
		Arc r_to_transition = myFactory.createArc();
		r_to_transition.setDirection(ArcDirection.PLACE_TO_TRANSITION);
		r_to_transition.setKind(ArcKind.NORMAL);
		r_to_transition.setSource(mapRessource.get(r_used.getRessources().getName()));
		r_to_transition.setTarget(mapTransitionStart.get(r_used.getWorkdefinition().getName()));
		r_to_transition.setWeight(r_used.getOcc());
		
		// Transition to Ressource
		Arc transition_to_r = myFactory.createArc();
		transition_to_r.setDirection(ArcDirection.TRANSITION_TO_PLACE);
		transition_to_r.setKind(ArcKind.NORMAL);
		transition_to_r.setSource(mapTransitionFinish.get(r_used.getWorkdefinition().getName()));
		transition_to_r.setTarget(mapRessource.get(r_used.getRessources().getName()));
		transition_to_r.setWeight(r_used.getOcc());
		
		petri.getArcs().add(r_to_transition);
		petri.getArcs().add(transition_to_r);
	}

	public static void main(String[] args) {
		// Chargement des packages SimplePDL et PetriNet afin de l'enregistrer dans le registre d'Eclipse.
		SimplepdlPackage simplePdlPackageInstance = SimplepdlPackage.eINSTANCE;
		
		// Enregistrer l'extension ".xmi" comme devant être ouverte à
		// l'aide d'un objet "XMIResourceFactoryImpl"
		Resource.Factory.Registry reg = Resource.Factory.Registry.INSTANCE;
		Map<String, Object> m = reg.getExtensionToFactoryMap();
		m.put("xmi", new XMIResourceFactoryImpl());
		
		// Créer un objet resourceSetImpl qui contiendra une ressource EMF (notre modèle)
		ResourceSet resSet = new ResourceSetImpl();

		// Charger les ressources (notre modèle)
		URI simplePDLmodelURI = URI.createURI("models/process_exemple.xmi");
		Resource simplePDLResource = resSet.getResource(simplePDLmodelURI, true);
		
		// Chargement des packages SimplePDL et PetriNet afin de l'enregistrer dans le registre d'Eclipse.
		PetrinetPackage petriNetPackageInstance = PetrinetPackage.eINSTANCE;

		// Créer le modèle de sortie 
		URI petriNetmodelURI = URI.createURI("models/petriNet_exemple.xmi");
		Resource petriNetResource = resSet.createResource(petriNetmodelURI);
		
		// La fabrique pour fabriquer les éléments de Petrinet
	    myFactory = PetrinetFactory.eINSTANCE;
	    
		// Récupérer le premier élément du modèle (élément racine)
		Process process = (Process) simplePDLResource.getContents().get(0);
		
		// Ajouter le Process dans le modÃ¨le
		simplePDLResource.getContents().add(process);
		
		// Création du PetriNet
		petri = myFactory.createPetriNet();
		
		/**
		* Manipulation de notre instance
		*/
		// Accéder aux informations du processus chargé
	    System.out.println("Processus : " + process.getName());
	    // Naviguer dans les références
	    Integer nbPE = process.getProcessElements().size();
	    System.out.println("Nombre de ProcessElement dans " + process.getName() + " : " + nbPE);

		// Afficher les sous-activités
		System.out.println("Les sous-activités sont :");
		for (Object o : process.getProcessElements()) {
			// WorkDefinition to Place
			if (o instanceof WorkDefinition) {
				WorkDefinition wd = (WorkDefinition) o;
				System.out.println("  - " + wd.getName());
				WD2PetriNet(wd);
			}
			
			// WorkSequence to Arc
			else if (o instanceof WorkSequence) {
				WorkSequence ws = (WorkSequence) o;
				System.out.println("  - " + ws.getLinkType());
				WS2ReadArc(ws);
			}
			
			// Ressource to Place
			else if (o instanceof Ressource) {
				Ressource r = (Ressource) o;
				System.out.println("  - " + r.getName());
				R2Place(r);
			}
		}
		// Sauvegarde des ressource
		petriNetResource.getContents().add(petri);
		try {
			petriNetResource.save(Collections.EMPTY_MAP);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}