

# Task 2 : Mutation Testing    

## Obtention des scores initiaux    

Pour obtenir les scores initiaux, j'ai effectué le test suivant.   
En plus des optimisations usuelles, j'ai demandé à effectuer le test sur 3 minutes.    
J'ai cherché certaines méthodes en analysant l'objet "MTAnalysis" et en regardant l'onglet Meta.    

```

testPackages := {'Myg-Chess-Tests'.}.
packagesToMutate := {'Myg-Chess-Core'}.

analysis := MTAnalysis new
    testPackages: testPackages;
    packagesToMutate:  packagesToMutate;
    testSelectionStrategy: MTSelectingFromCoverageTestSelectionStrategy new;
    stopOnErrorOrFail: true;
    budget: (MTTimeBudget for: 3 minutes).

analysis run.
analysis generalResult mutationScore.
```

Pour obtenir les mutants survivants j'effectue le code suivant.   
Seule la dernière ligne est modifiée.    

```
testPackages := {'Myg-Chess-Tests'.}.
packagesToMutate := {'Myg-Chess-Core'}.

analysis := MTAnalysis new
    testPackages: testPackages;
    packagesToMutate:  packagesToMutate;
    testSelectionStrategy: MTSelectingFromCoverageTestSelectionStrategy new;
    stopOnErrorOrFail: true;
    budget: (MTTimeBudget for: 3 minutes).

analysis run.
analysis generalResult.
``` 



## Scores initiaux    

En plus du score de mutation, je vais indiquer les taux de coverage. Et cela car un taux de     
mutation très éloigné du taux de coverage indique souvent un soucis, car dans le test les      
assertions ne sont pas assez fines.    

Je vais effectuer les tests sur mon code refactoré pour le kata "Restrict legal moves".      

**Warning: Bug coverage Dr Test**     

J'arrive à faire buguer Dr Test sur le coverage, et passer pour "Myg-Chess-Core" de 54.61%    
de coverage à 32.89%, et de 9/78 méthodes couvertes à 4/106. Pour éviter ce bug, je réimporte     
100% depuis github juste avant de lancer les tests. Surprenant, mais cela marche. Assez long.        

**Score initial:**     

Taux de couverture: 54.61 % pour le package "Myg-Chess-Core".     
Score de mutation: 37%                     
Chance que un mutant couvert soit tué:  37 / 54.61 soit 67.8 %

Note: Comme le TP fourni un jeu volontairement bugué, et que j'ai 3 tests "yellow", car le    
refactoring total était compliqué, cela baisse aussi les chances de tuer un mutant couvert.   


##  Strategie 

-----------------

**TODO** Ne pas oublier de selectionner 3 mutants specifiques à tuer... Le décrire dans la stratégie ?    
**TODO** Description strategy pour savoir quels tests ajouter      
Description des tests ajoutés     

**TO DO** ATTENTION ici rappeller le principe "Right BICEPS" quand je parle des tests que je n'ai pas écrit (ex: Performance)     
           Et comme ca il y aura à dire    

**TODO** your mutation score after adding tests    
what test you did not write and why    
an in-detail explanation of 3 mutants you killed and how you killed them     
an in-detail explanation of 3 equivalent mutants, explaining why they are equivalent     

-----------------