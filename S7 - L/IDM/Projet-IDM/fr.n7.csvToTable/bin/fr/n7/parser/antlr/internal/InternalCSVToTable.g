/*
 * generated by Xtext 2.23.0
 */
grammar InternalCSVToTable;

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
import fr.n7.services.CSVToTableGrammarAccess;

}

@parser::members {

 	private CSVToTableGrammarAccess grammarAccess;

    public InternalCSVToTableParser(TokenStream input, CSVToTableGrammarAccess grammarAccess) {
        this(input);
        this.grammarAccess = grammarAccess;
        registerRules(grammarAccess.getGrammar());
    }

    @Override
    protected String getFirstRuleName() {
    	return "Tableau";
   	}

   	@Override
   	protected CSVToTableGrammarAccess getGrammarAccess() {
   		return grammarAccess;
   	}

}

@rulecatch {
    catch (RecognitionException re) {
        recover(input,re);
        appendSkippedTokens();
    }
}

// Entry rule entryRuleTableau
entryRuleTableau returns [EObject current=null]:
	{ newCompositeNode(grammarAccess.getTableauRule()); }
	iv_ruleTableau=ruleTableau
	{ $current=$iv_ruleTableau.current; }
	EOF;

// Rule Tableau
ruleTableau returns [EObject current=null]
@init {
	enterRule();
}
@after {
	leaveRule();
}:
	(
		{
			newCompositeNode(grammarAccess.getTableauAccess().getLigneNomParserRuleCall_0());
		}
		this_LigneNom_0=ruleLigneNom
		{
			$current = $this_LigneNom_0.current;
			afterParserOrEnumRuleCall();
		}
		(
			(
				{
					newCompositeNode(grammarAccess.getTableauAccess().getLinesLigneValeurParserRuleCall_1_0());
				}
				lv_lines_1_0=ruleLigneValeur
				{
					if ($current==null) {
						$current = createModelElementForParent(grammarAccess.getTableauRule());
					}
					add(
						$current,
						"lines",
						lv_lines_1_0,
						"fr.n7.CSVToTable.LigneValeur");
					afterParserOrEnumRuleCall();
				}
			)
		)
	)
;

// Entry rule entryRuleLigneNom
entryRuleLigneNom returns [EObject current=null]:
	{ newCompositeNode(grammarAccess.getLigneNomRule()); }
	iv_ruleLigneNom=ruleLigneNom
	{ $current=$iv_ruleLigneNom.current; }
	EOF;

// Rule LigneNom
ruleLigneNom returns [EObject current=null]
@init {
	enterRule();
}
@after {
	leaveRule();
}:
	(
		(
			(
				lv_colonnes_0_0=RULE_ID
				{
					newLeafNode(lv_colonnes_0_0, grammarAccess.getLigneNomAccess().getColonnesIDTerminalRuleCall_0_0());
				}
				{
					if ($current==null) {
						$current = createModelElement(grammarAccess.getLigneNomRule());
					}
					addWithLastConsumed(
						$current,
						"colonnes",
						lv_colonnes_0_0,
						"org.eclipse.xtext.common.Terminals.ID");
				}
			)
		)
		(
			otherlv_1=','
			{
				newLeafNode(otherlv_1, grammarAccess.getLigneNomAccess().getCommaKeyword_1_0());
			}
			(
				(
					lv_colonnes_2_0=RULE_ID
					{
						newLeafNode(lv_colonnes_2_0, grammarAccess.getLigneNomAccess().getColonnesIDTerminalRuleCall_1_1_0());
					}
					{
						if ($current==null) {
							$current = createModelElement(grammarAccess.getLigneNomRule());
						}
						addWithLastConsumed(
							$current,
							"colonnes",
							lv_colonnes_2_0,
							"org.eclipse.xtext.common.Terminals.ID");
					}
				)
			)
		)*
	)
;

// Entry rule entryRuleLigneValeur
entryRuleLigneValeur returns [EObject current=null]:
	{ newCompositeNode(grammarAccess.getLigneValeurRule()); }
	iv_ruleLigneValeur=ruleLigneValeur
	{ $current=$iv_ruleLigneValeur.current; }
	EOF;

// Rule LigneValeur
ruleLigneValeur returns [EObject current=null]
@init {
	enterRule();
}
@after {
	leaveRule();
}:
	(
		(
			(
				{
					newCompositeNode(grammarAccess.getLigneValeurAccess().getValeursDonneeParserRuleCall_0_0());
				}
				lv_valeurs_0_0=ruleDonnee
				{
					if ($current==null) {
						$current = createModelElementForParent(grammarAccess.getLigneValeurRule());
					}
					add(
						$current,
						"valeurs",
						lv_valeurs_0_0,
						"fr.n7.CSVToTable.Donnee");
					afterParserOrEnumRuleCall();
				}
			)
		)
		(
			otherlv_1=','
			{
				newLeafNode(otherlv_1, grammarAccess.getLigneValeurAccess().getCommaKeyword_1_0());
			}
			(
				(
					{
						newCompositeNode(grammarAccess.getLigneValeurAccess().getValeursDonneeParserRuleCall_1_1_0());
					}
					lv_valeurs_2_0=ruleDonnee
					{
						if ($current==null) {
							$current = createModelElementForParent(grammarAccess.getLigneValeurRule());
						}
						add(
							$current,
							"valeurs",
							lv_valeurs_2_0,
							"fr.n7.CSVToTable.Donnee");
						afterParserOrEnumRuleCall();
					}
				)
			)
		)*
	)
;

// Entry rule entryRuleDonnee
entryRuleDonnee returns [String current=null]:
	{ newCompositeNode(grammarAccess.getDonneeRule()); }
	iv_ruleDonnee=ruleDonnee
	{ $current=$iv_ruleDonnee.current.getText(); }
	EOF;

// Rule Donnee
ruleDonnee returns [AntlrDatatypeRuleToken current=new AntlrDatatypeRuleToken()]
@init {
	enterRule();
}
@after {
	leaveRule();
}:
	(
		{
			newCompositeNode(grammarAccess.getDonneeAccess().getValeurParserRuleCall_0());
		}
		this_Valeur_0=ruleValeur
		{
			$current.merge(this_Valeur_0);
		}
		{
			afterParserOrEnumRuleCall();
		}
		    |
		{
			newCompositeNode(grammarAccess.getDonneeAccess().getDateParserRuleCall_1());
		}
		this_Date_1=ruleDate
		{
			$current.merge(this_Date_1);
		}
		{
			afterParserOrEnumRuleCall();
		}
	)
;

// Entry rule entryRuleDate
entryRuleDate returns [String current=null]:
	{ newCompositeNode(grammarAccess.getDateRule()); }
	iv_ruleDate=ruleDate
	{ $current=$iv_ruleDate.current.getText(); }
	EOF;

// Rule Date
ruleDate returns [AntlrDatatypeRuleToken current=new AntlrDatatypeRuleToken()]
@init {
	enterRule();
}
@after {
	leaveRule();
}:
	(
		(
			this_ID_0=RULE_ID
			{
				$current.merge(this_ID_0);
			}
			{
				newLeafNode(this_ID_0, grammarAccess.getDateAccess().getIDTerminalRuleCall_0_0());
			}
			kw='-'
			{
				$current.merge(kw);
				newLeafNode(kw, grammarAccess.getDateAccess().getHyphenMinusKeyword_0_1());
			}
			this_ID_2=RULE_ID
			{
				$current.merge(this_ID_2);
			}
			{
				newLeafNode(this_ID_2, grammarAccess.getDateAccess().getIDTerminalRuleCall_0_2());
			}
		)
		    |
		(
			this_ID_3=RULE_ID
			{
				$current.merge(this_ID_3);
			}
			{
				newLeafNode(this_ID_3, grammarAccess.getDateAccess().getIDTerminalRuleCall_1_0());
			}
			kw='/'
			{
				$current.merge(kw);
				newLeafNode(kw, grammarAccess.getDateAccess().getSolidusKeyword_1_1());
			}
			this_ID_5=RULE_ID
			{
				$current.merge(this_ID_5);
			}
			{
				newLeafNode(this_ID_5, grammarAccess.getDateAccess().getIDTerminalRuleCall_1_2());
			}
		)
	)
;

// Entry rule entryRuleValeur
entryRuleValeur returns [String current=null]:
	{ newCompositeNode(grammarAccess.getValeurRule()); }
	iv_ruleValeur=ruleValeur
	{ $current=$iv_ruleValeur.current.getText(); }
	EOF;

// Rule Valeur
ruleValeur returns [AntlrDatatypeRuleToken current=new AntlrDatatypeRuleToken()]
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
			newLeafNode(this_ID_0, grammarAccess.getValeurAccess().getIDTerminalRuleCall_0());
		}
		    |
		{
			newCompositeNode(grammarAccess.getValeurAccess().getFlottantParserRuleCall_1());
		}
		this_Flottant_1=ruleFlottant
		{
			$current.merge(this_Flottant_1);
		}
		{
			afterParserOrEnumRuleCall();
		}
	)
;

// Entry rule entryRuleFlottant
entryRuleFlottant returns [String current=null]:
	{ newCompositeNode(grammarAccess.getFlottantRule()); }
	iv_ruleFlottant=ruleFlottant
	{ $current=$iv_ruleFlottant.current.getText(); }
	EOF;

// Rule Flottant
ruleFlottant returns [AntlrDatatypeRuleToken current=new AntlrDatatypeRuleToken()]
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
			newLeafNode(this_ID_0, grammarAccess.getFlottantAccess().getIDTerminalRuleCall_0());
		}
		(
			kw='.'
			{
				$current.merge(kw);
				newLeafNode(kw, grammarAccess.getFlottantAccess().getFullStopKeyword_1_0());
			}
			this_ID_2=RULE_ID
			{
				$current.merge(this_ID_2);
			}
			{
				newLeafNode(this_ID_2, grammarAccess.getFlottantAccess().getIDTerminalRuleCall_1_1());
			}
		)+
	)
;

RULE_ID : '^'? ('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'_'|'0'..'9')*;

RULE_INT : ('0'..'9')+;

RULE_STRING : ('"' ('\\' .|~(('\\'|'"')))* '"'|'\'' ('\\' .|~(('\\'|'\'')))* '\'');

RULE_ML_COMMENT : '/*' ( options {greedy=false;} : . )*'*/';

RULE_SL_COMMENT : '//' ~(('\n'|'\r'))* ('\r'? '\n')?;

RULE_WS : (' '|'\t'|'\r'|'\n')+;

RULE_ANY_OTHER : .;