/*
 * generated by Xtext 2.23.0
 */
grammar InternalAlgorithmeXtext;

options {
	superClass=AbstractInternalAntlrParser;
}

@lexer::header {
package fr.n7.parser.antlr.internal;

// Hack: Use our own Lexer superclass by means of import. 
// Currently there is no other way to specify the superclass for the lexer.
import org.eclipse.xtext.parser.antlr.Lexer;
}

@parser::header {
package fr.n7.parser.antlr.internal;

import org.eclipse.xtext.*;
import org.eclipse.xtext.parser.*;
import org.eclipse.xtext.parser.impl.*;
import org.eclipse.emf.ecore.util.EcoreUtil;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.parser.antlr.AbstractInternalAntlrParser;
import org.eclipse.xtext.parser.antlr.XtextTokenStream;
import org.eclipse.xtext.parser.antlr.XtextTokenStream.HiddenTokens;
import org.eclipse.xtext.parser.antlr.AntlrDatatypeRuleToken;
import fr.n7.services.AlgorithmeXtextGrammarAccess;

}

@parser::members {

 	private AlgorithmeXtextGrammarAccess grammarAccess;

    public InternalAlgorithmeXtextParser(TokenStream input, AlgorithmeXtextGrammarAccess grammarAccess) {
        this(input);
        this.grammarAccess = grammarAccess;
        registerRules(grammarAccess.getGrammar());
    }

    @Override
    protected String getFirstRuleName() {
    	return "Algorithme";
   	}

   	@Override
   	protected AlgorithmeXtextGrammarAccess getGrammarAccess() {
   		return grammarAccess;
   	}

}

@rulecatch {
    catch (RecognitionException re) {
        recover(input,re);
        appendSkippedTokens();
    }
}

// Entry rule entryRuleAlgorithme
entryRuleAlgorithme returns [EObject current=null]:
	{ newCompositeNode(grammarAccess.getAlgorithmeRule()); }
	iv_ruleAlgorithme=ruleAlgorithme
	{ $current=$iv_ruleAlgorithme.current; }
	EOF;

// Rule Algorithme
ruleAlgorithme returns [EObject current=null]
@init {
	enterRule();
}
@after {
	leaveRule();
}:
	(
		otherlv_0='Algorithme'
		{
			newLeafNode(otherlv_0, grammarAccess.getAlgorithmeAccess().getAlgorithmeKeyword_0());
		}
		(
			(
				{
					newCompositeNode(grammarAccess.getAlgorithmeAccess().getNomNomParserRuleCall_1_0());
				}
				lv_nom_1_0=ruleNom
				{
					if ($current==null) {
						$current = createModelElementForParent(grammarAccess.getAlgorithmeRule());
					}
					set(
						$current,
						"nom",
						lv_nom_1_0,
						"fr.n7.AlgorithmeXtext.Nom");
					afterParserOrEnumRuleCall();
				}
			)
		)
		(
			(
				{
					newCompositeNode(grammarAccess.getAlgorithmeAccess().getAlgorithmeElementAlgorithmeElementParserRuleCall_2_0());
				}
				lv_algorithmeElement_2_0=ruleAlgorithmeElement
				{
					if ($current==null) {
						$current = createModelElementForParent(grammarAccess.getAlgorithmeRule());
					}
					add(
						$current,
						"algorithmeElement",
						lv_algorithmeElement_2_0,
						"fr.n7.AlgorithmeXtext.AlgorithmeElement");
					afterParserOrEnumRuleCall();
				}
			)
		)+
	)
;

// Entry rule entryRuleNom
entryRuleNom returns [String current=null]:
	{ newCompositeNode(grammarAccess.getNomRule()); }
	iv_ruleNom=ruleNom
	{ $current=$iv_ruleNom.current.getText(); }
	EOF;

// Rule Nom
ruleNom returns [AntlrDatatypeRuleToken current=new AntlrDatatypeRuleToken()]
@init {
	enterRule();
}
@after {
	leaveRule();
}:
	(
		this_ID_0=RULE_ID
		{
			$current.merge(this_ID_0);
		}
		{
			newLeafNode(this_ID_0, grammarAccess.getNomAccess().getIDTerminalRuleCall_0());
		}
		(
			kw='.'
			{
				$current.merge(kw);
				newLeafNode(kw, grammarAccess.getNomAccess().getFullStopKeyword_1_0());
			}
			this_ID_2=RULE_ID
			{
				$current.merge(this_ID_2);
			}
			{
				newLeafNode(this_ID_2, grammarAccess.getNomAccess().getIDTerminalRuleCall_1_1());
			}
		)*
	)
;

// Entry rule entryRuleAlgorithmeElement
entryRuleAlgorithmeElement returns [EObject current=null]:
	{ newCompositeNode(grammarAccess.getAlgorithmeElementRule()); }
	iv_ruleAlgorithmeElement=ruleAlgorithmeElement
	{ $current=$iv_ruleAlgorithmeElement.current; }
	EOF;

// Rule AlgorithmeElement
ruleAlgorithmeElement returns [EObject current=null]
@init {
	enterRule();
}
@after {
	leaveRule();
}:
	(
		{
			newCompositeNode(grammarAccess.getAlgorithmeElementAccess().getRessourceParserRuleCall_0());
		}
		this_Ressource_0=ruleRessource
		{
			$current = $this_Ressource_0.current;
			afterParserOrEnumRuleCall();
		}
		    |
		{
			newCompositeNode(grammarAccess.getAlgorithmeElementAccess().getEntreeParserRuleCall_1());
		}
		this_Entree_1=ruleEntree
		{
			$current = $this_Entree_1.current;
			afterParserOrEnumRuleCall();
		}
		    |
		{
			newCompositeNode(grammarAccess.getAlgorithmeElementAccess().getSortieParserRuleCall_2());
		}
		this_Sortie_2=ruleSortie
		{
			$current = $this_Sortie_2.current;
			afterParserOrEnumRuleCall();
		}
	)
;

// Entry rule entryRuleRessource
entryRuleRessource returns [EObject current=null]:
	{ newCompositeNode(grammarAccess.getRessourceRule()); }
	iv_ruleRessource=ruleRessource
	{ $current=$iv_ruleRessource.current; }
	EOF;

// Rule Ressource
ruleRessource returns [EObject current=null]
@init {
	enterRule();
}
@after {
	leaveRule();
}:
	(
		otherlv_0='Ressource :'
		{
			newLeafNode(otherlv_0, grammarAccess.getRessourceAccess().getRessourceKeyword_0());
		}
		(
			(
				{
					newCompositeNode(grammarAccess.getRessourceAccess().getNomCheminParserRuleCall_1_0());
				}
				lv_nom_1_0=ruleChemin
				{
					if ($current==null) {
						$current = createModelElementForParent(grammarAccess.getRessourceRule());
					}
					set(
						$current,
						"nom",
						lv_nom_1_0,
						"fr.n7.AlgorithmeXtext.Chemin");
					afterParserOrEnumRuleCall();
				}
			)
		)
		otherlv_2='de type'
		{
			newLeafNode(otherlv_2, grammarAccess.getRessourceAccess().getDeTypeKeyword_2());
		}
		(
			(
				{
					newCompositeNode(grammarAccess.getRessourceAccess().getTypeTypeAlgoParserRuleCall_3_0());
				}
				lv_type_3_0=ruleTypeAlgo
				{
					if ($current==null) {
						$current = createModelElementForParent(grammarAccess.getRessourceRule());
					}
					set(
						$current,
						"type",
						lv_type_3_0,
						"fr.n7.AlgorithmeXtext.TypeAlgo");
					afterParserOrEnumRuleCall();
				}
			)
		)
	)
;

// Entry rule entryRuleChemin
entryRuleChemin returns [String current=null]:
	{ newCompositeNode(grammarAccess.getCheminRule()); }
	iv_ruleChemin=ruleChemin
	{ $current=$iv_ruleChemin.current.getText(); }
	EOF;

// Rule Chemin
ruleChemin returns [AntlrDatatypeRuleToken current=new AntlrDatatypeRuleToken()]
@init {
	enterRule();
}
@after {
	leaveRule();
}:
	(
		kw='/'
		{
			$current.merge(kw);
			newLeafNode(kw, grammarAccess.getCheminAccess().getSolidusKeyword_0());
		}
		this_ID_1=RULE_ID
		{
			$current.merge(this_ID_1);
		}
		{
			newLeafNode(this_ID_1, grammarAccess.getCheminAccess().getIDTerminalRuleCall_1());
		}
		(
			kw='.'
			{
				$current.merge(kw);
				newLeafNode(kw, grammarAccess.getCheminAccess().getFullStopKeyword_2_0());
			}
			this_ID_3=RULE_ID
			{
				$current.merge(this_ID_3);
			}
			{
				newLeafNode(this_ID_3, grammarAccess.getCheminAccess().getIDTerminalRuleCall_2_1());
			}
		)*
	)+
;

// Entry rule entryRuleSortie
entryRuleSortie returns [EObject current=null]:
	{ newCompositeNode(grammarAccess.getSortieRule()); }
	iv_ruleSortie=ruleSortie
	{ $current=$iv_ruleSortie.current; }
	EOF;

// Rule Sortie
ruleSortie returns [EObject current=null]
@init {
	enterRule();
}
@after {
	leaveRule();
}:
	(
		otherlv_0='Port sortie'
		{
			newLeafNode(otherlv_0, grammarAccess.getSortieAccess().getPortSortieKeyword_0());
		}
		(
			(
				{
					newCompositeNode(grammarAccess.getSortieAccess().getNomNomParserRuleCall_1_0());
				}
				lv_nom_1_0=ruleNom
				{
					if ($current==null) {
						$current = createModelElementForParent(grammarAccess.getSortieRule());
					}
					set(
						$current,
						"nom",
						lv_nom_1_0,
						"fr.n7.AlgorithmeXtext.Nom");
					afterParserOrEnumRuleCall();
				}
			)
		)
		(
			(
				otherlv_2='associ\u00E9 \u00E0 r\u00E9sultat'
				{
					newLeafNode(otherlv_2, grammarAccess.getSortieAccess().getAssociRSultatKeyword_2_0_0());
				}
				(
					(
						{
							newCompositeNode(grammarAccess.getSortieAccess().getValeurResultatParserRuleCall_2_0_1_0());
						}
						lv_valeur_3_0=ruleResultat
						{
							if ($current==null) {
								$current = createModelElementForParent(grammarAccess.getSortieRule());
							}
							set(
								$current,
								"valeur",
								lv_valeur_3_0,
								"fr.n7.AlgorithmeXtext.Resultat");
							afterParserOrEnumRuleCall();
						}
					)
				)
			)
			    |
			otherlv_4='associ\u00E9 au retour de la fonction'
			{
				newLeafNode(otherlv_4, grammarAccess.getSortieAccess().getAssociAuRetourDeLaFonctionKeyword_2_1());
			}
		)
	)
;

// Entry rule entryRuleResultat
entryRuleResultat returns [String current=null]:
	{ newCompositeNode(grammarAccess.getResultatRule()); }
	iv_ruleResultat=ruleResultat
	{ $current=$iv_ruleResultat.current.getText(); }
	EOF;

// Rule Resultat
ruleResultat returns [AntlrDatatypeRuleToken current=new AntlrDatatypeRuleToken()]
@init {
	enterRule();
}
@after {
	leaveRule();
}:
	this_ID_0=RULE_ID
	{
		$current.merge(this_ID_0);
	}
	{
		newLeafNode(this_ID_0, grammarAccess.getResultatAccess().getIDTerminalRuleCall());
	}
;

// Entry rule entryRuleEntree
entryRuleEntree returns [EObject current=null]:
	{ newCompositeNode(grammarAccess.getEntreeRule()); }
	iv_ruleEntree=ruleEntree
	{ $current=$iv_ruleEntree.current; }
	EOF;

// Rule Entree
ruleEntree returns [EObject current=null]
@init {
	enterRule();
}
@after {
	leaveRule();
}:
	(
		otherlv_0='Port entr\u00E9e'
		{
			newLeafNode(otherlv_0, grammarAccess.getEntreeAccess().getPortEntrEKeyword_0());
		}
		(
			(
				{
					newCompositeNode(grammarAccess.getEntreeAccess().getNomNomParserRuleCall_1_0());
				}
				lv_nom_1_0=ruleNom
				{
					if ($current==null) {
						$current = createModelElementForParent(grammarAccess.getEntreeRule());
					}
					set(
						$current,
						"nom",
						lv_nom_1_0,
						"fr.n7.AlgorithmeXtext.Nom");
					afterParserOrEnumRuleCall();
				}
			)
		)
		otherlv_2='associ\u00E9 \u00E0 argument'
		{
			newLeafNode(otherlv_2, grammarAccess.getEntreeAccess().getAssociArgumentKeyword_2());
		}
		(
			(
				{
					newCompositeNode(grammarAccess.getEntreeAccess().getArgumentArgumentParserRuleCall_3_0());
				}
				lv_argument_3_0=ruleArgument
				{
					if ($current==null) {
						$current = createModelElementForParent(grammarAccess.getEntreeRule());
					}
					set(
						$current,
						"argument",
						lv_argument_3_0,
						"fr.n7.AlgorithmeXtext.Argument");
					afterParserOrEnumRuleCall();
				}
			)
		)
	)
;

// Entry rule entryRuleArgument
entryRuleArgument returns [String current=null]:
	{ newCompositeNode(grammarAccess.getArgumentRule()); }
	iv_ruleArgument=ruleArgument
	{ $current=$iv_ruleArgument.current.getText(); }
	EOF;

// Rule Argument
ruleArgument returns [AntlrDatatypeRuleToken current=new AntlrDatatypeRuleToken()]
@init {
	enterRule();
}
@after {
	leaveRule();
}:
	(
		this_ID_0=RULE_ID
		{
			$current.merge(this_ID_0);
		}
		{
			newLeafNode(this_ID_0, grammarAccess.getArgumentAccess().getIDTerminalRuleCall_0());
		}
		    |
		this_INT_1=RULE_INT
		{
			$current.merge(this_INT_1);
		}
		{
			newLeafNode(this_INT_1, grammarAccess.getArgumentAccess().getINTTerminalRuleCall_1());
		}
	)
;

// Entry rule entryRuleTypeAlgo
entryRuleTypeAlgo returns [String current=null]:
	{ newCompositeNode(grammarAccess.getTypeAlgoRule()); }
	iv_ruleTypeAlgo=ruleTypeAlgo
	{ $current=$iv_ruleTypeAlgo.current.getText(); }
	EOF;

// Rule TypeAlgo
ruleTypeAlgo returns [AntlrDatatypeRuleToken current=new AntlrDatatypeRuleToken()]
@init {
	enterRule();
}
@after {
	leaveRule();
}:
	(
		{
			newCompositeNode(grammarAccess.getTypeAlgoAccess().getCalculParserRuleCall_0());
		}
		this_Calcul_0=ruleCalcul
		{
			$current.merge(this_Calcul_0);
		}
		{
			afterParserOrEnumRuleCall();
		}
		    |
		{
			newCompositeNode(grammarAccess.getTypeAlgoAccess().getScriptParserRuleCall_1());
		}
		this_Script_1=ruleScript
		{
			$current.merge(this_Script_1);
		}
		{
			afterParserOrEnumRuleCall();
		}
	)
;

// Entry rule entryRuleScript
entryRuleScript returns [String current=null]:
	{ newCompositeNode(grammarAccess.getScriptRule()); }
	iv_ruleScript=ruleScript
	{ $current=$iv_ruleScript.current.getText(); }
	EOF;

// Rule Script
ruleScript returns [AntlrDatatypeRuleToken current=new AntlrDatatypeRuleToken()]
@init {
	enterRule();
}
@after {
	leaveRule();
}:
	(
		this_ID_0=RULE_ID
		{
			$current.merge(this_ID_0);
		}
		{
			newLeafNode(this_ID_0, grammarAccess.getScriptAccess().getIDTerminalRuleCall_0());
		}
		kw=', sous-programme'
		{
			$current.merge(kw);
			newLeafNode(kw, grammarAccess.getScriptAccess().getSousProgrammeKeyword_1());
		}
		{
			newCompositeNode(grammarAccess.getScriptAccess().getProgrammeParserRuleCall_2());
		}
		this_Programme_2=ruleProgramme
		{
			$current.merge(this_Programme_2);
		}
		{
			afterParserOrEnumRuleCall();
		}
	)
;

// Entry rule entryRuleProgramme
entryRuleProgramme returns [String current=null]:
	{ newCompositeNode(grammarAccess.getProgrammeRule()); }
	iv_ruleProgramme=ruleProgramme
	{ $current=$iv_ruleProgramme.current.getText(); }
	EOF;

// Rule Programme
ruleProgramme returns [AntlrDatatypeRuleToken current=new AntlrDatatypeRuleToken()]
@init {
	enterRule();
}
@after {
	leaveRule();
}:
	this_ID_0=RULE_ID
	{
		$current.merge(this_ID_0);
	}
	{
		newLeafNode(this_ID_0, grammarAccess.getProgrammeAccess().getIDTerminalRuleCall());
	}
;

// Entry rule entryRuleCalcul
entryRuleCalcul returns [String current=null]:
	{ newCompositeNode(grammarAccess.getCalculRule()); }
	iv_ruleCalcul=ruleCalcul
	{ $current=$iv_ruleCalcul.current.getText(); }
	EOF;

// Rule Calcul
ruleCalcul returns [AntlrDatatypeRuleToken current=new AntlrDatatypeRuleToken()]
@init {
	enterRule();
}
@after {
	leaveRule();
}:
	(
		this_ID_0=RULE_ID
		{
			$current.merge(this_ID_0);
		}
		{
			newLeafNode(this_ID_0, grammarAccess.getCalculAccess().getIDTerminalRuleCall());
		}
	)+
;

RULE_ID : '^'? ('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'_'|'0'..'9')*;

RULE_INT : ('0'..'9')+;

RULE_STRING : ('"' ('\\' .|~(('\\'|'"')))* '"'|'\'' ('\\' .|~(('\\'|'\'')))* '\'');

RULE_ML_COMMENT : '/*' ( options {greedy=false;} : . )*'*/';

RULE_SL_COMMENT : '//' ~(('\n'|'\r'))* ('\r'? '\n')?;

RULE_WS : (' '|'\t'|'\r'|'\n')+;

RULE_ANY_OTHER : .;