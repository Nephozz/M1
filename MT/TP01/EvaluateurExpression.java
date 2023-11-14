import java.util.HashMap;

public class EvaluateurExpression implements VisiteurExpression<Integer> {
    private HashMap<String, Integer> environnement;
    private Integer OperandeG, OperandeD, Operande;

    public EvaluateurExpression(HashMap<String, Integer> environnement) {
        this.environnement = environnement;
        this.Operande = 0;
        this.OperandeG = 0;
        this.OperandeD = 0;
    }
    
    public Integer visiterAccesVariable(AccesVariable v) {
        return environnement.get(v.getNom());
    };

	public Integer visiterConstante(Constante c) {
        return c.getValeur();
    };

	public Integer visiterExpressionBinaire(ExpressionBinaire e) {
        this.OperandeG = e.getOperandeGauche().accepter(this);
        this.OperandeD = e.getOperandeDroite().accepter(this);

        return e.getOperateur().accepter(this);
    };

	public Integer visiterAddition(Addition a) {
        return this.OperandeG + this.OperandeD;
    };

	public Integer visiterMultiplication(Multiplication m) {
        return this.OperandeG * this.OperandeD;
    };

    public Integer visiterSoustraction(Soustraction s) {
		return this.OperandeG - this.OperandeD;
	}
	
	public Integer visiterExpressionUnaire(ExpressionUnaire e) {
        this.Operande = e.getOperande().accepter(this);
        
        return e.getOperande().accepter(this);
    };

	public Integer visiterNegation(Negation n) {
        return - this.Operande;
    };
}
