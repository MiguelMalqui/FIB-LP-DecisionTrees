# Pràctica haskell Decision Trees
 
El programa crea un arbre de decisió a partir del conjunt de dades [Mushroom](https://archive.ics.uci.edu/ml/datasets/Mushroom) per després poder classificar bolets.


## Índex

  - [Prerequisits](#prerequisits)
  - [Instal·lació](#instal·lació)
  - [Usage](#usage)
  - [Heurístic](#heurístic)
  - [Crèdits](#crèdits)


## Prerequisits

Tenir instal·lat Glasgow Haskell Compiler (GHC)

## Instal·lació

El programa es compila de la següent forma:
```bash
ghc dts.hs
```

## Usage

El programa s'ha d'executar a la mateixa carpeta on es troba l'arxiu agaricus-lepiota.data.
```bash
./dts
```

Exemple d'execució
```bash
<system> Which odor? [musty, spicy, fishy, creosote, foul, none, anise, almond, pungent]                             
<user> none                                                                                                             
<system> Which spore-print-color? [buff, yellow, orange, green, chocolate, white, black, brown]                         
<user> green                                                                                                            
<system> Prediction: poisonous
```


## Heurístic

Considero que un arbre de decisió és millor que un altre si dona una predicció en menys passos.
Per tant, mirarem la seva profunditat i nombre d'arcs.

L'heurístic utilitzat en cas d'empat entre dos atributs és agafar l'últim vist.
Vaig provar altres heurístics com l'atribut amb mes/menys classes o l'atribut amb classe de més freqüència per la seva moda més freqüent, però cap va donar millor resultat.

Aquest és l'arbre resultant:

```bash
odor
  musty
    poisonous
  spicy
    poisonous
  fishy
    poisonous
  creosote
    poisonous
  foul
    poisonous
  none
    spore-print-color
      buff
        edible
      yellow
        edible
      orange
        edible
      green
        poisonous
      chocolate
        edible
      white
        habitat
          paths
            edible
          grasses
            edible
          woods
            population
              solitary
                edible
              several
                poisonous
          leaves
            population
              clustered
                poisonous
              several
                edible
          waste
            edible
      black
        edible
      brown
        edible
  anise
    edible
  almond
    edible
  pungent
    poisonous
```

## Crèdits
 - Miguel Angel Malqui Cruz