import java.lang.reflect.*;
import java.util.*;

/** L'objectif est de faire un lanceur simple sans utiliser toutes les clases
  * de notre architecture JUnit.   Il permet juste de valider la compréhension
  * de l'introspection en Java.
  */
public class LanceurIndependant {
    private int nbTestsLances;
    private int nbErreurs;
    private int nbEchecs;
    private List<Throwable> erreurs = new ArrayList<>();

    public LanceurIndependant(String... nomsClasses) {
        System.out.println();

        // Lancer les tests pour chaque classe
        for (String nom : nomsClasses) {
            try {
                System.out.print(nom + " : ");
                this.testerUneClasse(nom);
                System.out.println();
            } catch (ClassNotFoundException e) {
                System.out.println(" Classe inconnue !");
            } catch (Exception e) {
                System.out.println(" Problème : " + e);
                e.printStackTrace();
            }
        }

        // Afficher les erreurs
        for (Throwable e : erreurs) {
            System.out.println();
            e.printStackTrace();
        }

        // Afficher un bilan
        System.out.println();
        System.out.printf("%d tests lancés dont %d échecs et %d erreurs.\n",
                nbTestsLances, nbEchecs, nbErreurs);
    }


    public int getNbTests() {
        return this.nbTestsLances;
    }


    public int getNbErreurs() {
        return this.nbErreurs;
    }


    public int getNbEchecs() {
        return this.nbEchecs;
    }


    private void testerUneClasse(String nomClasse)
        throws ClassNotFoundException, InstantiationException,
                          IllegalAccessException
    {
        // Récupérer la classe
        Class<?> t = Class.forName(nomClasse);
        Method[] methods = t.getMethods();

        // Instancier l'objet qui sera le récepteur des tests
        Constructor<?> c;
        Object objet = null;

        try {
            c = t.getConstructor();
            objet = c.newInstance();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Récupérer les méthodes "preparer" et "nettoyer"
        Method preparer = null;
        Method nettoyer = null;

        try {
            preparer = t.getMethod("preparer");
            nettoyer = t.getMethod("nettoyer");
        } catch (NoSuchMethodException nme) {
            nme.printStackTrace();
        }
        // Exécuter les méthods de test
        if (preparer != null) {
            try {
                preparer.invoke(objet);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        for (Method m : methods) {
            if (m.getName().startsWith("test")) {
                Class<?>[] typesParametres = m.getParameterTypes();
                Parameter[] parametres = m.getParameters();
                try {
                    m.invoke(objet, (Object[]) parametres);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        if (nettoyer != null) {
            try {
                nettoyer.invoke(objet);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public static void main(String... args) {
        LanceurIndependant lanceur = new LanceurIndependant(args);
    }

}