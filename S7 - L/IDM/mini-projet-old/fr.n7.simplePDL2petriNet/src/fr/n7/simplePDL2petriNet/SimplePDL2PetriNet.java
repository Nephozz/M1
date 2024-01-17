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
import simplepdl.Process;
import simplepdl.SimplepdlPackage;
import simplepdl.WorkDefinition;
import simplepdl.WorkSequence;
import simplepdl.WorkSequenceType;
import petrinet.ArcKind;
import petrinet.ArcDirection;

@SuppressWarnings("unused")
public class SimplePDL2PetriNet {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		SimplepdlPackage packageSimplePDLInstance = SimplepdlPackage.eINSTANCE;
		PetrinetPackage packagePetrinetInstance = PetrinetPackage.eINSTANCE;
		
		
		Resource.Factory.Registry reg  = Resource.Factory.Registry.INSTANCE;
		Map<String, Object> m = reg.getExtensionToFactoryMap();
		m.put("xmi", new XMIResourceFactoryImpl());
		
		ResourceSet resSet = new ResourceSetImpl();
		
		URI modelURI_pdl = URI.createURI(args[0]);
		Resource resource_pdl = resSet.getResource(modelURI_pdl, true);
		
		String[] path_split = args[0].split("/");
		String name = path_split[path_split.length - 1];
		
		URI modelURI_pn = URI.createURI("models/PetriNet_"+ name);
		Resource resource_pn = resSet.createResource(modelURI_pn);
				
		PetrinetFactory myFactory = PetrinetFactory.eINSTANCE;
		
		Process process = (Process) resource_pdl.getContents().get(0);
		
		PetriNet net = myFactory.createPetriNet();
		net.setName(process.getName());
		
		resource_pn.getContents().add(net);
		
		//Création des maps
		Map<WorkDefinition, Transition> startsTransition = new HashMap<>();
		Map<WorkDefinition, Place> startedPlace = new HashMap<>();
		Map<WorkDefinition, Transition> finishingTransition = new HashMap<>();
		Map<WorkDefinition, Place> finishedPlace = new HashMap<>();
		
		
		for (Object o : process.getProcessElements()) {
			if (o instanceof WorkDefinition) {
				WorkDefinition wd = (WorkDefinition) o;
				
				/*
				 * creer 4 places
				 * creer 2 transitions
				 * creer 5 arcs
				 */
				
				Place a_NotStarted = myFactory.createPlace();
				a_NotStarted.setName(wd.getName()+ "_NotStarted");
				a_NotStarted.setJeton(1);
				net.getPlaces().add(a_NotStarted);

				Place a_Started = myFactory.createPlace();
				a_Started.setName(wd.getName()+ "_Started");
				a_Started.setJeton(0);
				startedPlace.put(wd, a_Started);
				net.getPlaces().add(a_Started);
				
				Place a_Finishing = myFactory.createPlace();
				a_Finishing.setName(wd.getName()+ "_Finishing");
				a_Finishing.setJeton(0);
				net.getPlaces().add(a_Finishing);
				
				Place a_Finished = myFactory.createPlace();
				a_Finished.setName(wd.getName()+ "_Finished");
				a_Finished.setJeton(0);
				finishedPlace.put(wd, a_Finished);
				net.getPlaces().add(a_Finished);				
				
				
				Transition a_starts = myFactory.createTransition();
				a_starts.setName(wd.getName()+ "_starts");
				startsTransition.put(wd, a_starts);
				net.getTransitions().add(a_starts);
				
				Transition a_finishes = myFactory.createTransition();
				a_finishes.setName(wd.getName()+ "_finishes");
				finishingTransition.put(wd, a_finishes);
				net.getTransitions().add(a_finishes);
				
				Arc notStarted2starts = myFactory.createArc();
				notStarted2starts.setKind(ArcKind.NORMAL);
				notStarted2starts.setDirection(ArcDirection.P2T);
				notStarted2starts.setPlace(a_NotStarted);
				notStarted2starts.setTransition(a_starts);
				notStarted2starts.setWeight(1);
				net.getArcs().add(notStarted2starts);
				
				Arc starts2Started = myFactory.createArc();
				starts2Started.setKind(ArcKind.NORMAL);
				starts2Started.setDirection(ArcDirection.T2P);
				starts2Started.setPlace(a_Started);
				starts2Started.setTransition(a_starts);
				starts2Started.setWeight(1);
				net.getArcs().add(starts2Started);
				
				Arc starts2Finishing = myFactory.createArc();
				starts2Finishing.setKind(ArcKind.NORMAL);
				starts2Finishing.setDirection(ArcDirection.T2P);
				starts2Finishing.setPlace(a_Finishing);
				starts2Finishing.setTransition(a_starts);
				starts2Finishing.setWeight(1);
				net.getArcs().add(starts2Finishing);
				
				Arc finishing2finishes = myFactory.createArc();
				finishing2finishes.setKind(ArcKind.NORMAL);
				finishing2finishes.setDirection(ArcDirection.P2T);
				finishing2finishes.setPlace(a_Finishing);
				finishing2finishes.setTransition(a_finishes);
				net.getArcs().add(finishing2finishes);
				
				Arc finishes2Finished = myFactory.createArc();
				finishes2Finished.setKind(ArcKind.NORMAL);
				finishes2Finished.setDirection(ArcDirection.T2P);
				finishes2Finished.setPlace(a_Finished);
				finishes2Finished.setTransition(a_finishes);
				finishes2Finished.setWeight(1);
				net.getArcs().add(finishes2Finished);
				
			} 
		}
		for (Object o : process.getProcessElements()) {
			if (o instanceof WorkSequence){
				WorkSequence ws = (WorkSequence) o;
				
				Arc a2bReader = myFactory.createArc();
				a2bReader.setKind(ArcKind.READ);
				a2bReader.setDirection(ArcDirection.P2T);
				a2bReader.setWeight(1);
				
				if (ws.getLinkType() == WorkSequenceType.FINISH_TO_FINISH) {
					a2bReader.setPlace(finishedPlace.get(ws.getPredecessor()));
					a2bReader.setTransition(finishingTransition.get(ws.getSuccessor()));
				} else if (ws.getLinkType() == WorkSequenceType.START_TO_FINISH) {
					a2bReader.setPlace(startedPlace.get(ws.getPredecessor()));
					a2bReader.setTransition(finishingTransition.get(ws.getSuccessor()));
				} else if (ws.getLinkType() == WorkSequenceType.START_TO_START) {
					a2bReader.setPlace(startedPlace.get(ws.getPredecessor()));
					a2bReader.setTransition(startsTransition.get(ws.getSuccessor()));
				} else if (ws.getLinkType() == WorkSequenceType.FINISH_TO_START) {
					a2bReader.setPlace(finishedPlace.get(ws.getPredecessor()));
					a2bReader.setTransition(startsTransition.get(ws.getSuccessor()));
				}
				net.getArcs().add(a2bReader);
			}
		}
		// Sauver la ressource
	    try {
	    	resource_pn.save(Collections.EMPTY_MAP);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
