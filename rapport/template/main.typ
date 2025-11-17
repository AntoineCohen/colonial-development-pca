#import "../lib.typ": *

#set text(lang: "fr")

#show: ilm.with(
  title: [Analyse en Composantes Principales : Déterminants du Développement des Sociétés Coloniales],
  course: "Analyse de données",
  author: "Antoine C., Noah D.-G., Jules D., Hans P.",
  affiliation: [Faculté de Gestion, Économie & Sciences \ Université Catholique de Lille],
  professor: [Guillaume BOURGEOIS (cours magistraux), Joffrey STARY (travaux dirigés)],
  date: datetime(year: 2025, month: 12, day: 20),
  date-format: "Décembre [year repr:full]",
  abstract: [
    Ce rapport présente une analyse en composantes principales (ACP) réalisée sur un jeu de données portant sur 64 pays, visant à identifier les dimensions principales expliquant les différences de développement entre sociétés coloniales. L'analyse révèle quatre dimensions principales expliquant près de 80% de la variance totale, mettant en lumière les déterminants économiques, démographiques, géographiques et institutionnels du développement.
  ],
  paper-size: "a4",
  bibliography: bibliography("refs.bib", style: "apa"),
  figure-index: (enabled: true, title: "Index des Figures"),
  table-index: (enabled: true, title: "Index des Tableaux"),
  chapter-pagebreak: true,
)

= Introduction et objectifs

== Contexte

Ce travail s'inscrit dans la lignée des recherches fondatrices d'Acemoglu, Johnson et Robinson (2001) sur les origines coloniales du développement comparatif. Le jeu de données analysé combine des indicateurs institutionnels, économiques, démographiques et géographiques pour 64 pays, permettant une analyse multidimensionnelle des facteurs de développement.

== Justification de la méthode ACP

L'Analyse en Composantes Principales (ACP) est une méthode particulièrement adaptée à ce contexte pour plusieurs raisons :

- *Réduction de dimensionnalité :* Les 10 variables actives présentent des corrélations fortes (notamment entre variables institutionnelles, économiques et géographiques), créant de la redondance. L'ACP permet d'identifier les dimensions latentes qui structurent réellement les différences entre pays.

- *Synthèse multidimensionnelle :* L'ACP permet de synthétiser l'information contenue dans plusieurs variables en un nombre réduit de dimensions interprétables, facilitant la compréhension des structures de développement.

- *Visualisation :* Les plans factoriels permettent de visualiser la position relative des pays et d'identifier des groupes homogènes, ce qui est essentiel pour une analyse comparative.

- *Variables illustratives :* L'ACP permet d'intégrer des variables qualitatives et quantitatives illustratives sans qu'elles participent à la construction des axes, enrichissant ainsi l'interprétation sans biaiser l'analyse.

== Objectifs de l'analyse

Cette analyse vise à répondre aux questions opérationnelles suivantes :

- *Question 1 :* Quelles sont les dimensions principales qui structurent les différences de développement entre les pays ? Comment ces dimensions se hiérarchisent-elles en termes d'importance ?

- *Question 2 :* Quels sont les déterminants économiques, institutionnels et géographiques les plus influents dans l'explication de ces différences ? Quelles variables contribuent le plus à chaque dimension ?

- *Question 3 :* Comment les pays se positionnent-ils les uns par rapport aux autres sur ces dimensions ? Quels pays sont typiques de chaque pôle factoriel ?

- *Question 4 :* Quels pays sont atypiques ou mal représentés dans l'analyse ? Pourquoi et quelles sont les limites d'interprétation pour ces pays ?

- *Question 5 :* Quel est le rôle des variables illustratives (continent, hémisphère, esclavage, néo-Europe) dans la compréhension des résultats ? Comment enrichissent-elles l'interprétation sans biaiser l'analyse ?

= Méthodologie

== Description des données

L'analyse porte sur 64 pays décrits par 10 variables actives quantitatives :

*Variables institutionnelles et historiques :*
- `risk` : Indice de risque d'expropriation (0-10)
- `edes1975` : Part de la population descendants d'européens en 1975 (%)
- `malfal94` : Prévalence de la malaria en 1994 (%)
- `mort0` : Estimation de la mortalité des colons (pour 10 000)

*Variables économiques :*
- `gdp` : PIB par habitant en Parité de Pouvoir d'Achat en 1995

*Variables démographiques et géographiques :*
- `population` : Population en 2024 (valeur absolue)
- `land` : Taille du territoire en km² en 2024
- `density` : Densité de population par km²
- `latitude` : Latitude moyenne du pays (valeur absolue)
- `average_temperature` : Température moyenne (1991-2020)

*Variables illustratives :*
- Qualitatives : `continent`, `hemisphere`
- Quantitatives : `slave`, `neoeuro`

== Choix méthodologiques

=== Poids des individus

Dans cette analyse, tous les pays ont été considérés avec un poids uniforme. Ce choix méthodologique se justifie par plusieurs raisons :

- *Égalité de représentation :* Chaque pays, indépendamment de sa taille, de sa population ou de son poids économique, contribue de manière équivalente à la construction des axes factoriels.

- *Alternatives envisageables :* On pourrait envisager de pondérer par la population, le PIB ou la superficie, mais ces alternatives auraient pour effet de transformer l'analyse en une étude des grandes puissances plutôt qu'une analyse comparative équilibrée.

- *Cohérence avec l'objectif :* Notre objectif étant de comprendre les structures de développement plutôt que les poids relatifs des pays, le choix de poids uniformes est le plus approprié.

=== Centrage et réduction des données

*Le centrage et la réduction des données sont absolument nécessaires* pour plusieurs raisons :

- *Échelles de mesure hétérogènes :* Les variables présentent des échelles très différentes (PIB en milliers de dollars, population en millions, température en degrés).

- *Risque de domination :* Sans standardisation, les variables avec de grandes valeurs domineraient mécaniquement l'analyse.

- *Comparabilité :* Le centrage et la réduction permettent de comparer équitablement les contributions de chaque variable.

- *Interprétation :* La standardisation facilite l'interprétation en termes d'écarts-types plutôt qu'en valeurs absolues.

=== Nombre de dimensions à retenir

Plusieurs critères permettent de déterminer le nombre de dimensions :

- *Critère de Kaiser :* Conserver les axes avec valeur propre > 1. Selon ce critère, 4 axes doivent être retenus.

- *Critère du coude :* L'examen du graphique des valeurs propres révèle un coude net après le quatrième axe.

- *Critère du pourcentage d'inertie :* Les quatre premiers axes expliquent 79,68% de l'inertie totale, niveau très satisfaisant.

*Conclusion :* Nous retiendrons 4 dimensions principales pour l'analyse, expliquant près de 80% de la variance totale.

= Analyse des dimensions principales

== Valeurs propres et inertie

*Rappel théorique :* Les valeurs propres (eigenvalues) représentent la variance expliquée par chaque composante principale. Le pourcentage d'inertie associé à chaque axe indique quelle part de l'information totale est captée par cet axe.

Le nuage des individus est initialement dans un espace à 10 dimensions (une dimension par variable active). L'objectif de l'ACP est de fournir une image approchée de ce nuage dans un plan (2 dimensions), permettant de visualiser les ressemblances entre les profils des pays.

En réduisant l'espace à deux dimensions, nous perdons de la précision, mais les pourcentages d'inertie permettent de quantifier cette perte d'information.

#figure(
  table(
    columns: 4,
    align: (left, center, center, center),
    toprule,
    table.header([*Composante*], [*Valeur propre*], [*% d'inertie*], [*% cumulé*]),
    midrule,
    [Axe 1], [4.284], [42.84], [42.84],
    [Axe 2], [1.519], [15.19], [58.03],
    [Axe 3], [1.157], [11.57], [69.60],
    [Axe 4], [1.008], [10.08], [79.68],
    [Axe 5], [0.631], [6.31], [85.98],
    bottomrule
  ),
  caption: [Valeurs propres et inertie],
) <tab:eigenvalues>

Le @tab:eigenvalues présente les valeurs propres, les pourcentages d'inertie et les pourcentages cumulés pour les 10 premières composantes principales. Le pourcentage d'inertie représente la part de l'information totale captée par chaque axe. Le pourcentage cumulé indique la part d'information captée par les _n_ premiers axes.

#figure(
  image("assets/images/02_valeurs_propres.png", width: 85%),
  caption: [Graphique des valeurs propres (Scree Plot)]
) <fig:scree>

Le graphique des valeurs propres (@fig:scree) représente les valeurs propres de chaque composante principale. Ce graphique permet d'identifier le nombre optimal de dimensions à retenir selon le critère du coude : on cherche le point où la courbe "casse" (coude), indiquant une diminution marquée de l'inertie expliquée.

Dans notre cas, on observe un coude net après le quatrième axe, confirmant le choix de retenir 4 dimensions. Les valeurs propres supérieures à 1 (critère de Kaiser) sont également visibles sur ce graphique.

Le premier axe factoriel (première composante principale) capte toujours le plus d'information. Du fait de l'emboîtement des solutions, les axes suivants captent l'information qui n'a pas déjà été captée par les axes précédents.

#figure(
  image("assets/images/03_inertie_cumulee.png", width: 85%),
  caption: [Inertie cumulée]
) <fig:inertie>

Le graphique de l'inertie cumulée (@fig:inertie) représente le pourcentage d'inertie totale expliquée par les _n_ premières composantes. Ce graphique permet de visualiser rapidement le pourcentage d'information captée par les axes retenus.

La ligne rouge à 80% indique un seuil communément utilisé : les quatre premiers axes expliquent 79,68% de l'inertie totale. En limitant l'analyse aux quatre premiers axes, nous omettons donc 20,32% de l'information totale, ce qui paraît raisonnable.

Le premier plan factoriel (composé des deux premiers axes) capte 42,84% + 15,19% = 58,03% de l'inertie totale. Ce niveau est satisfaisant pour une analyse en composantes principales, permettant une visualisation et une interprétation fiable des structures principales dans les données.

= Interprétation des axes factoriels

*Rappel :* Pour interpréter un axe factoriel, nous analysons les contributions des variables à cet axe. Les variables avec une contribution élevée sont fortement corrélées à l'axe et participent activement à sa définition. Nous commentons également les positions relatives des projections des variables dans le plan factoriel, en priorité les variables qui ont la plus forte contribution sur chacun des axes.

== Premier axe factoriel : Dimension économique et institutionnelle

Le premier axe factoriel explique 42,84% de l'inertie totale et constitue la dimension la plus importante. Cet axe capture près de la moitié de l'information contenue dans les 10 variables actives, révélant une structure très forte dans les données. Cette dimension domine l'analyse et structure fortement les différences entre pays. Comme toujours en ACP, le premier axe factoriel est celui qui capte le plus d'information.

#figure(
  table(
    columns: 2,
    align: (left, right),
    toprule,
    table.header([*Variable*], [*Contribution (%)*]),
    midrule,
    [`gdp`], [16.58],
    [`edes1975`], [15.95],
    [`average_temperature`], [15.56],
    [`risk`], [13.27],
    [`latitude`], [12.84],
    [`malfal94`], [11.47],
    [`land`], [8.95],
    [`mort0`], [4.54],
    [`density`], [0.603],
    [`population`], [0.234],
    bottomrule
  ),
  caption: [Contributions des variables à l'axe 1],
) <tab:contrib-axe1>

Le @tab:contrib-axe1 présente les contributions des variables au premier axe factoriel, triées par ordre décroissant. Les contributions indiquent l'importance relative de chaque variable dans la construction de l'axe. Une contribution élevée signifie que la variable est fortement corrélée à l'axe et participe activement à sa définition.

La contribution totale de toutes les variables à un axe est de 100%. Une variable contribuant à plus de 10% est considérée comme fortement contributive. Les variables avec une contribution faible (< 5%) sont moins importantes pour l'axe mais peuvent néanmoins apporter des informations complémentaires.

// #figure(
//   image("assets/images/04_contributions_variables_12.png", width: 85%),
//   caption: [Contributions des variables aux axes 1 et 2]
// ) <fig:contrib-var>

=== Interprétation

Le premier axe oppose principalement :

- *Pôle positif (droite) :* Pays avec un PIB élevé, une forte proportion de descendants d'Européens, un indice de risque d'expropriation élevé (institutions protectrices), une latitude élevée (pays tempérés), et une température moyenne plus basse. Ces caractéristiques correspondent aux pays développés et aux anciennes colonies de peuplement européen (ex. : Canada, USA, Australie, Nouvelle-Zélande).

- *Pôle négatif (gauche) :* Pays avec un PIB faible, une faible proportion de descendants d'Européens, un indice de risque d'expropriation faible (institutions fragiles), une latitude faible (pays tropicaux), une température moyenne élevée, et une prévalence élevée de la malaria. Ces caractéristiques correspondent aux pays en développement, souvent situés en zone tropicale (ex. : pays d'Afrique subsaharienne).

*Exemples de pays aux extrêmes :*

- _Pôle positif (extrême droite) :_ Canada, USA, Nouvelle-Zélande, Australie. Ces pays combinent toutes les caractéristiques du développement : PIB élevé, institutions solides, forte proportion de descendants d'Européens, latitude élevée.

- _Pôle négatif (extrême gauche) :_ Mali, Niger, Burkina Faso, Togo. Ces pays présentent les caractéristiques opposées : PIB faible, institutions fragiles, faible proportion de descendants d'Européens, forte prévalence de la malaria.

*Conclusion :* Le premier axe peut être interprété comme un axe de développement économique et institutionnel, opposant les pays développés aux institutions solides aux pays en développement aux institutions fragiles. Cette dimension confirme les travaux d'Acemoglu et al. (2001) sur l'importance des institutions dans le développement. L'axe révèle une cohérence forte entre développement économique, qualité des institutions, héritage colonial et géographie.

#figure(
  image("assets/images/06_cercle_correlations_12.png", width: 90%),
  caption: [Cercle des corrélations - Plan 1-2]
) <fig:cercle12>

Le cercle des corrélations (@fig:cercle12) représente les variables actives dans le plan défini par les axes 1 et 2. Les coordonnées des variables sur ce graphique correspondent à leurs corrélations avec les axes factoriels.

La longueur des flèches indique la qualité de représentation (cos²) : plus la flèche est longue, mieux la variable est représentée dans le plan. L'angle entre deux flèches reflète leur corrélation : un angle aigu indique une corrélation positive, un angle obtus une corrélation négative, et un angle droit une absence de corrélation.

Les variables proches du cercle unité sont bien représentées, celles proches du centre sont mal représentées. Ce graphique permet d'identifier les variables qui structurent chaque axe et leurs relations mutuelles. Les variables proches sont corrélées, les variables opposées sont négativement corrélées.

== Deuxième axe factoriel : Dimension démographique et géographique

Le deuxième axe factoriel explique 15,19% de la variance totale.

#figure(
  table(
    columns: 2,
    align: (left, right),
    toprule,
    table.header([*Variable*], [*Contribution (%)*]),
    midrule,
    [`density`], [49.73],
    [`land`], [11.24],
    [`gdp`], [9.49],
    [`average_temperature`], [5.96],
    [`latitude`], [5.63],
    [`mort0`], [4.05],
    [`malfal94`], [4.04],
    [`risk`], [3.69],
    [`edes1975`], [3.19],
    [`population`], [2.98],
    bottomrule,
  ),
  caption: [Contributions des variables à l'axe 2]
) <tab:contrib-axe2>

=== Interprétation

Le deuxième axe oppose principalement :

- *Pôle positif (haut) :* Pays avec une densité de population très élevée et une superficie réduite. Ces caractéristiques correspondent aux petits pays densément peuplés (ex. : Singapour, Hong Kong, Bangladesh).

- *Pôle négatif (bas) :* Pays avec une faible densité de population et une grande superficie. Ces caractéristiques correspondent aux grands pays faiblement peuplés (ex. : Canada, Australie, pays d'Afrique subsaharienne).

*Exemples de pays aux extrêmes :*

- _Pôle positif (extrême haut) :_ Singapore (densité très élevée, petite superficie), Hong Kong (similaire). Ces pays illustrent le modèle de développement urbain dense.

- _Pôle négatif (extrême bas) :_ Canada, Australie (faible densité, grande superficie). Ces pays illustrent le modèle de pays faiblement peuplés avec de vastes territoires.

*Conclusion :* Le deuxième axe peut être interprété comme un axe de densité démographique et de taille territoriale, opposant les petits pays densément peuplés aux grands pays faiblement peuplés. Cette dimension est indépendante du développement économique (axe 1), révélant que la densité démographique constitue une dimension structurelle distincte du niveau de développement.

#figure(
  image("assets/images/11_biplot_12.png", width: 95%),
  caption: [Biplot - Plan 1-2]
) <fig:biplot>

Le biplot (@fig:biplot) superpose la représentation des individus (pays) et des variables dans le même plan factoriel. Les points représentent les pays, les flèches représentent les variables.

La projection d'un pays sur une flèche indique approximativement la valeur de ce pays pour cette variable (en unités d'écart-type, du fait du centrage-réduction). Les pays proches ont des profils similaires sur l'ensemble des variables. Les variables proches sont corrélées.

Ce graphique permet de visualiser simultanément la position des pays et l'influence des variables, facilitant l'interprétation globale du plan factoriel. Il permet également de comprendre comment les pays se positionnent par rapport aux variables : un pays proche de l'extrémité d'une flèche a une valeur élevée pour cette variable.

= Analyse des individus

*Rappel des objectifs de l'analyse des individus :* Les individus sont ici les 64 pays. Nous cherchons à analyser le profil multidimensionnel des pays, et pas uniquement une seule variable. L'analyse des individus permet de mettre en évidence les pays dont les profils sont similaires et ceux dont les profils s'opposent.

Ainsi, cela va nous permettre de savoir si tel pays a un profil de développement similaire à tel autre pays, et un profil opposé à tel autre pays. Nous définissons la distance entre deux pays sur la base de leurs valeurs pour les 10 variables actives. L'ACP construit des variables synthétiques (les axes factoriels) qui résument l'information contenue dans le tableau de données.

== Contributions des individus aux axes

=== Contributions à l'axe 1

#figure(
  table(
    columns: 2,
    align: (left, right),
    toprule,
    table.header([*Pays*], [*Contribution (%)*]),
    midrule,
    [Canada], [22.02],
    [USA], [15.25],
    [New Zealand], [7.37],
    [Australia], [7.33],
    [Mali], [3.91],
    [Malta], [2.99],
    [Chile], [2.98],
    [Argentina], [2.90],
    [Nigeria], [2.30],
    [Uruguay], [2.06],
    bottomrule,
  ),
  caption: [Top 10 des contributions individuelles à l'axe 1]
) <tab:contrib-ind1>

*Interprétation :* Le Canada et les USA sont les pays les plus contributeurs à l'axe 1, avec des contributions respectives de 22.02% et 15.25%. Ces pays sont typiques du pôle "développé" de l'axe 1.

=== Contributions à l'axe 2

#figure(
  table(
    columns: 2,
    align: (left, right),
    toprule,
    table.header([*Pays*], [*Contribution (%)*]),
    midrule,
    [Singapore], [45.34],
    [Hong Kong], [26.80],
    [Canada], [6.63],
    [Mali], [3.26],
    [USA], [1.96],
    [India], [1.51],
    [Nigeria], [1.32],
    [Argentina], [1.27],
    [Brazil], [1.12],
    [Malaysia], [1.02],
    bottomrule,
  ),
  caption: [Top 10 des contributions individuelles à l'axe 2]
) <tab:contrib-ind2>

*Interprétation :* Singapore est le pays le plus contributeur à l'axe 2 (45.34%), représentant le pôle "petit pays très densément peuplé et développé". Hong Kong contribue également fortement (26.80%), confirmant cette interprétation.

// #figure(
//   image("assets/images/08_contributions_individus_12.png", width: 85%),
//   caption: [Contributions des individus aux axes 1 et 2]
// ) <fig:contrib-ind>

== Qualité de représentation des individus

Les individus avec un cos² total supérieur à 0,5 sur le plan 1-2 sont considérés comme bien représentés. Les individus avec un cos² inférieur à 0,2 sont considérés comme mal représentés.

#figure(
  image("assets/images/09_individus_plan_12_cos2.png", width: 95%),
  caption: [Graphique des individus - Plan 1-2 (qualité de représentation)]
) <fig:ind-cos2>

Ce graphique (@fig:ind-cos2) représente les pays dans le plan factoriel 1-2, colorés selon leur qualité de représentation (cos²). Les pays en rouge/jaune ont un cos² élevé (bien représentés), ceux en bleu ont un cos² faible (mal représentés).

Seuls les pays avec cos² > 0,3 sont étiquetés pour améliorer la lisibilité. Ce graphique permet d'identifier visuellement les pays dont la position sur le plan 1-2 est fiable (bien représentés) et ceux pour lesquels l'interprétation doit être prudente (mal représentés). Les pays mal représentés nécessitent l'examen des axes 3 et 4 pour une compréhension complète.

#figure(
  image("assets/images/10_individus_plan_12_contrib.png", width: 95%),
  caption: [Graphique des individus - Plan 1-2 (contributions)]
) <fig:ind-contrib>

Ce graphique (@fig:ind-contrib) représente les pays dans le plan factoriel 1-2, colorés selon leur contribution aux axes. Les pays en rouge/jaune contribuent fortement à la construction des axes, ceux en bleu contribuent faiblement. Seuls les top 10 contributeurs sont étiquetés.

Ce graphique permet d'identifier les pays typiques de chaque pôle factoriel : les pays avec une contribution élevée sont représentatifs des structures identifiées par les axes. Ces pays peuvent être utilisés comme exemples pour illustrer l'interprétation des axes.

#figure(
  grid(
    columns: 2,
    column-gutter: 1em,
    
    // Colonne de gauche
    table(
      columns: (auto, auto, auto, auto),
      align: (left, right, right, right),
      stroke: 0.5pt + gray,
      inset: 6pt,
      
      table.header(
        [*Pays*], [*Dim.1*], [*Dim.2*], [*cos²*]
      ),
      
      [Canada], [0.820], [0.088], [0.908],
      [Singapore], [0.052], [0.837], [0.890],
      [Sierra Leone], [0.859], [0.008], [0.867],
      [USA], [0.819], [0.037], [0.856],
      [Hong Kong], [0.123], [0.723], [0.846],
      [Burkina Faso], [0.778], [0.009], [0.787],
      [Ghana], [0.777], [0.004], [0.781],
      [New Zealand], [0.774], [0.002], [0.776],
      [Argentina], [0.669], [0.104], [0.773],
      [Australia], [0.698], [0.014], [0.712],
      [Chile], [0.685], [0.017], [0.702],
      [Uganda], [0.687], [0.010], [0.697],
      [Niger], [0.692], [0.075], [0.767],
      [Guinea], [0.679], [0.010], [0.688],
      [Senegal], [0.687], [0.000], [0.687],
      [Kenya], [0.681], [0.000], [0.682],
      [Guyana], [0.626], [0.033], [0.659],
      [Togo], [0.648], [0.000], [0.649],
      [Cameroon], [0.646], [0.003], [0.649],
      [Madagascar], [0.471], [0.160], [0.631],
      [Mexico], [0.618], [0.002], [0.620],
      [Cote d'Ivoire], [0.603], [0.003], [0.606],
      [Malta], [0.553], [0.030], [0.584],
      [Angola], [0.451], [0.122], [0.573],
      [Congo], [0.534], [0.045], [0.579],
      [Vietnam], [0.567], [0.002], [0.569],
      [Zaire], [0.493], [0.070], [0.563],
      [Sudan], [0.497], [0.067], [0.563],
      [South Africa], [0.530], [0.028], [0.558],
      [Uruguary], [0.532], [0.026], [0.557],
      [Sri Lanka], [0.397], [0.157], [0.554],
      [Ethiopia], [0.485], [0.027], [0.512],
    ),
    
    // Colonne de droite
    table(
      columns: (auto, auto, auto, auto),
      align: (left, right, right, right),
      stroke: 0.5pt + gray,
      inset: 6pt,
      
      table.header(
        [*Pays*], [*Dim.1*], [*Dim.2*], [*cos²*]
      ),
      
      [Haiti], [0.484], [0.025], [0.509],
      [Tanzania], [0.455], [0.018], [0.473],
      [Nigeria], [0.337], [0.069], [0.405],
      [Mali], [0.269], [0.079], [0.348],
      [Bahamas], [0.159], [0.150], [0.309],
      [Brazil], [0.233], [0.065], [0.298],
      [Malaysia], [0.031], [0.264], [0.295],
      [Gabon], [0.203], [0.048], [0.251],
      [Gambia], [0.243], [0.002], [0.246],
      [Trinidad], [0.050], [0.180], [0.230],
      [Costa Rica], [0.007], [0.219], [0.226],
      [Venezuela], [0.033], [0.193], [0.226],
      [Nicaragua], [0.192], [0.002], [0.195],
      [Panama], [0.063], [0.125], [0.187],
      [Morocco], [0.167], [0.013], [0.181],
      [Jamaica], [0.002], [0.147], [0.149],
      [Bangladesh], [0.093], [0.046], [0.138],
      [Algeria], [0.108], [0.029], [0.138],
      [El Salvador], [0.109], [0.023], [0.133],
      [Paraguay], [0.126], [0.002], [0.128],
      [Colombia], [0.007], [0.110], [0.116],
      [Pakistan], [0.003], [0.108], [0.111],
      [Tunisia], [0.097], [0.002], [0.100],
      [Bolivia], [0.047], [0.052], [0.099],
      [Honduras], [0.084], [0.003], [0.086],
      [Peru], [0.050], [0.012], [0.061],
      [Egypt], [0.048], [0.005], [0.053],
      [Indonesia], [0.043], [0.002], [0.046],
      [Dominican Re], [0.006], [0.039], [0.045],
      [Ecuador], [0.001], [0.042], [0.043],
      [Guatemala], [0.032], [0.007], [0.039],
      [India], [0.010], [0.026], [0.036],
    ),
  ),
  caption: [Qualité de représentation (cos²) des individus sur le plan 1-2]
)

#text(size: 9pt)[
*Interprétation :* Le cos² mesure la qualité de représentation d'un pays sur le plan 1-2. 33 pays (51.6%) sont bien représentés (cos² > 0.5), 14 pays (21.9%) moyennement représentés (0.2 < cos² < 0.5), et 17 pays (26.6%) mal représentés (cos² < 0.2). Le tableau est trié par ordre décroissant de cos².
]


*Pays bien représentés (cos² > 0,5) :* 33 pays (51,6%)

Ces pays sont typiques des structures identifiées par les deux premiers axes et peuvent être interprétés avec confiance. Leur position sur le plan 1-2 reflète fidèlement leur profil multidimensionnel. Ces pays illustrent bien les pôles factoriels et peuvent servir d'exemples pour l'interprétation des axes.

*Pays mal représentés (cos² < 0,2) :* 20 pays (31,3%)

Exemples de pays mal représentés :

- India (cos² = 0,036), Guatemala (cos² = 0,039), Ecuador (cos² = 0,043), Dominican Republic (cos² = 0,045), Indonesia (cos² = 0,046) : Ces pays présentent un profil atypique qui ne correspond pas aux structures identifiées par les deux premiers axes. Leurs position sur le plan 1-2 doit être interprétée avec prudence, car une part importante de leur variance n'est pas capturée par ces axes.

*Analyse qualitative des pays mal représentés :*

Les pays mal représentés présentent généralement des caractéristiques qui les distinguent des structures typiques : soit ils combinent des traits contradictoires (ex. : pays avec certaines caractéristiques de développement mais d'autres caractéristiques de sous-développement), soit ils présentent des spécificités nationales fortes non capturées par les dimensions principales.

Pour ces pays, il est nécessaire d'examiner les axes 3 et 4 pour mieux comprendre leur position, ou de considérer qu'ils nécessitent une analyse spécifique.

*Limites d'interprétation :*

La position de ces pays sur le plan 1-2 ne reflète qu'une partie de leur profil. Il faut se méfier de toute interprétation trop catégorique concernant ces pays atypiques. Ces pays peuvent présenter des trajectoires de développement particulières ou des combinaisons de caractéristiques rares qui échappent aux dimensions principales identifiées.

== Analyse des variables mal représentées

Tout comme les individus, les variables peuvent être plus ou moins bien représentées sur les axes factoriels. Une variable mal représentée (cos² faible) n'est pas bien capturée par les axes retenus et apporte peu d'information pour l'interprétation. L'analyse du cos² des variables permet d'identifier les variables qui structurent réellement les axes et celles qui sont moins pertinentes.

*Variables bien représentées (cos² > 0,5) : 8 variables*

Ces variables sont fortement corrélées aux axes 1 et 2 et participent activement à leur interprétation. Elles structurent réellement les dimensions identifiées. 

*Variables mal représentées (cos² < 0,3) : 2 variables*

Ces variables sont faiblement corrélées aux axes 1 et 2 et apportent peu d'information pour l'interprétation de ces axes. Elles peuvent être mieux représentées sur les axes 3 et 4, ou nécessiter une analyse spécifique. 

#figure(
  image("assets/images/13_individus_par_continent.png", width: 95%),
  caption: [Graphique des individus par continent]
) <fig:ind-continent>

Ce graphique (@fig:ind-continent) représente les pays dans le plan factoriel 1-2, colorés et symbolisés selon leur continent. Les ellipses de confiance (à 95%) entourent les groupes de pays par continent, permettant de visualiser leur distribution et leur chevauchement.

Ce graphique révèle des structurations géographiques : les pays d'Afrique tendent à se regrouper dans le quadrant inférieur gauche (faible développement), tandis que les pays d'Amérique du Nord et d'Océanie se situent dans le quadrant supérieur droit (développement élevé). Les ellipses permettent d'identifier visuellement les continents homogènes et ceux présentant une grande variabilité interne.

#figure(
  image("assets/images/14_individus_par_hemisphere.png", width: 95%),
  caption: [Graphique des individus par hémisphère]
) <fig:ind-hemisphere>

Ce graphique (@fig:ind-hemisphere) représente les pays dans le plan factoriel 1-2, colorés et symbolisés selon leur hémisphère. Les ellipses de confiance entourent les groupes de pays par hémisphère.

Ce graphique révèle une structuration selon la latitude : les pays de l'hémisphère Nord (majoritairement tempérés) tendent à avoir un meilleur développement que ceux de l'hémisphère Sud (majoritairement tropicaux). Cette structuration est cohérente avec l'importance de la latitude et de la température dans l'axe 1, confirmant l'impact de la géographie sur le développement.

= Analyse des axes secondaires et variables illustratives

== Troisième et quatrième axes factoriels

Bien que les axes 3 et 4 expliquent une part plus faible de l'inertie totale (respectivement 11,57% et 10,08%), leur analyse apporte des informations complémentaires importantes.

#figure(
  table(
    columns: 3,
    align: (left, right, right),
    toprule,
    table.header([*Variable*], [*Contribution axe 3 (%)*], [*Contribution axe 4 (%)*]),
    midrule,
    [`risk`], [7.14], [0.84],
    [`latitude`], [2.08], [0.51],
    [`edes1975`], [3.94], [1.20],
    [`malfal94`], [2.15], [15.11],
    [`mort0`], [2.96], [53.73],
    [`gdp`], [0.39], [7.93],
    [`population`], [63.55], [12.56],
    [`land`], [11.58], [2.44],
    [`density`], [3.82], [5.35],
    [`average_temperature`], [2.39], [0.34],
    bottomrule,
  ),
  caption: [Contributions des variables aux axes 3 et 4]
) <tab:contrib-axes34>

=== Interprétation de l'axe 3

Cet axe oppose les pays très peuplés aux pays faiblement peuplés. La variable `population` contribue à 63,55%, confirmant que cet axe capture la dimension démographique. La variable `land` contribue également (11,58%), indiquant que cet axe capture également la dimension de taille territoriale.

Cet axe révèle une dimension indépendante de la densité : certains grands pays sont très peuplés (Inde, Indonésie, Pakistan, Bangladesh) tandis que d'autres sont faiblement peuplés (Canada, Australie, pays d'Afrique centrale).

Cette dimension est distincte de l'axe 2 (qui oppose densité élevée vs faible) : l'axe 3 oppose population absolue élevée vs faible, indépendamment de la densité.

*Exemples de pays aux extrêmes de l'axe 3 :*

- _Pôle positif (extrême) :_ Inde, Indonésie, Pakistan, Bangladesh - Pays très peuplés avec de grandes populations absolues.

- _Pôle négatif (extrême) :_ Canada, Australie, pays d'Afrique centrale - Pays faiblement peuplés malgré de grandes superficies.

=== Interprétation de l'axe 4

Cet axe oppose les pays où la mortalité des colons était élevée (zones tropicales hostiles, forte prévalence de la malaria) aux pays où la mortalité était faible (zones tempérées). Cette dimension capture un aspect historique important lié aux conditions de colonisation.

La variable `mort0` contribue à 53,73%, suivie de `malfal94` (15,11%), confirmant le lien entre conditions sanitaires historiques et développement contemporain.

Cet axe révèle que les conditions de colonisation (mortalité des colons, prévalence de la malaria) continuent d'influencer la structure du développement, même après plusieurs décennies. Cette dimension historique est cohérente avec le modèle @acemoglu2001 : les zones où la mortalité était élevée ont développé des institutions extractives, tandis que les zones où la mortalité était faible ont développé des institutions inclusives.

*Exemples de pays aux extrêmes de l'axe 4 :*

- _Pôle positif (mortalité élevée) :_ Pays d'Afrique de l'Ouest et centrale, pays d'Amérique latine tropicale - Zones où les colons européens ont rencontré des conditions sanitaires hostiles, menant à des institutions extractives.

- _Pôle négatif (mortalité faible) :_ Canada, USA, Australie, Nouvelle-Zélande - Zones tempérées où les colons ont pu s'établir durablement, développant des institutions inclusives.

#figure(
  image("assets/images/07_cercle_correlations_34.png", width: 90%),
  caption: [Cercle des corrélations - Plan 3-4]
) <fig:cercle34>

Le cercle des corrélations pour le plan 3-4 (@fig:cercle34) représente les variables actives dans le plan défini par les axes 3 et 4. Bien que ces axes expliquent une part plus faible de l'inertie (21,65% au total), ils révèlent des dimensions complémentaires importantes : l'axe 3 est dominé par la population (63,55% de contribution), l'axe 4 par la mortalité des colons (53,73%).

Ce graphique permet d'identifier les variables qui structurent ces axes secondaires et de comprendre les dimensions supplémentaires capturées par l'analyse.

#figure(
  image("assets/images/12_individus_plan_34.png", width: 95%),
  caption: [Graphique des individus - Plan 3-4]
) <fig:ind-plan34>

Ce graphique (@fig:ind-plan34) représente les pays dans le plan factoriel 3-4, colorés selon leur qualité de représentation (cos²). Ce plan capture des dimensions complémentaires à celles du plan 1-2 : la dimension démographique (population) pour l'axe 3 et la dimension historique (mortalité des colons) pour l'axe 4.

Ce graphique est particulièrement utile pour comprendre la position des pays mal représentés sur le plan 1-2, car ces pays peuvent être mieux représentés sur les axes 3 et 4. L'examen de ce plan permet d'identifier des structures supplémentaires non capturées par les deux premiers axes.

#figure(
  image("assets/images/15_variables_avec_illustratives_quanti.png", width: 95%),
  caption: [Variables avec illustratives quantitatives]
) <fig:var-illustratives>

Ce graphique (@fig:var-illustratives) superpose les variables actives (flèches noires) et les variables illustratives quantitatives (flèches colorées) dans le plan factoriel 1-2. Les variables illustratives (`slave`, `neoeuro`) sont projetées sur les axes sans participer à leur construction.

Il permet de visualiser comment ces variables historiques se positionnent par rapport aux variables actives, révélant leur corrélation avec les dimensions identifiées. La variable `neoeuro` se positionne clairement dans le quadrant supérieur droit, confirmant le modèle des colonies de peuplement d'Acemoglu et al. (2001).

// #figure(
//   image("assets/images/16_categories_illustratives.png", width: 95%),
//   caption: [Catégories des variables illustratives qualitatives]
// ) <fig:categories>

== Analyse des variables illustratives

Les variables illustratives permettent d'enrichir l'interprétation des axes factoriels sans participer à leur construction.

=== Variables illustratives qualitatives

*Continent :* Permet de visualiser la distribution géographique des pays sur les axes factoriels. Les graphiques montrent que les pays d'Afrique tendent à se regrouper dans le quadrant inférieur gauche (faible développement, institutions fragiles), tandis que les pays d'Amérique du Nord et d'Océanie se situent dans le quadrant supérieur droit (développement élevé, institutions solides).

*Hémisphère :* Révèle une structuration selon la latitude. Les pays de l'hémisphère Nord (majoritairement tempérés) tendent à avoir un meilleur développement que ceux de l'hémisphère Sud (majoritairement tropicaux), confirmant l'importance de la géographie dans le développement.

=== Variables illustratives quantitatives

*Slave (présence d'esclavage) :* Cette variable illustre l'impact historique de l'esclavage sur le développement. Les pays ayant connu l'esclavage tendent à se positionner différemment sur les axes, révélant des traces durables de cette institution. Cependant, cette variable est fortement corrélée avec d'autres variables historiques et géographiques, limitant son apport indépendant.

*Neoeuro (Nouvelle Europe) :* Cette variable binaire identifie les pays considérés comme des "Nouvelles Europe" (USA, Canada, Australie, Nouvelle-Zélande). Ces pays se positionnent clairement dans le quadrant supérieur droit du plan 1-2, confirmant leur statut de pays développés aux institutions solides. Cette variable illustre parfaitement le modèle d'Acemoglu et al. (2001) sur les colonies de peuplement.

=== Limites et précautions d'interprétation

*Corrélations évidentes :* Certaines variables illustratives sont fortement corrélées avec les variables actives. Par exemple, l'hémisphère est corrélé avec la latitude et la température. Le continent est également corrélé avec plusieurs variables géographiques et institutionnelles. Il faut éviter de surinterpréter ces variables comme des causes indépendantes.

*Effets d'aubaine :* Certains pays peuvent apparaître comme des exceptions au modèle général (ex. : pays d'Asie avec un développement élevé malgré une faible proportion de descendants d'Européens). Ces cas méritent une analyse spécifique.

*Variables catégorielles :* Les variables qualitatives (continent, hémisphère) permettent une visualisation claire mais doivent être interprétées avec prudence car elles masquent la variabilité intra-catégorie.

= Synthèse et conclusions

Cette analyse en composantes principales, menée sur 64 pays anciennement colonisés, visait à identifier les dimensions structurantes du développement comparatif. L'analyse de 10 variables actives révèle quatre dimensions principales expliquant près de 80% de la variance totale.

== Quatre dimensions structurantes du développement

*Dimension 1 : Le primat du développement économico-institutionnel (42,84%).* La qualité des institutions héritées de la colonisation constitue le déterminant principal des différences de développement. Cette dimension oppose les colonies de peuplement (Canada, Australie, USA) – PIB élevé, institutions solides, localisation tempérée – aux anciennes colonies extractives (Mali, Niger) – PIB faible, institutions fragiles, forte malaria. Ce résultat confirme la thèse d'Acemoglu et al. (2001).

*Dimension 2 : L'indépendance de la densité démographique (15,19%).* La densité constitue un facteur structurel indépendant du développement. Des pays développés existent parmi les territoires denses (Singapour, Hong Kong) comme parmi les territoires peu peuplés (Canada, Australie).

*Dimension 3 : La taille démographique absolue (11,57%).* Cette dimension distingue les très grands pays peuplés (Inde, Indonésie, Pakistan, Nigeria > 100M habitants) des petits pays, révélant des défis de gouvernance spécifiques à l'échelle démographique.

*Dimension 4 : La persistance de l'héritage sanitaire colonial (10,08%).* La mortalité des colons, liée à la malaria, a déterminé le type d'institutions établies (inclusives vs extractives). Cet héritage perdure aujourd'hui, plus de 150 ans après.

== Schémas synthétiques des profils de développement

=== Plan factoriel 1-2 : Développement et Densité

#figure(
  table(
    columns: 2,
    align: center + horizon,
    stroke: 0.5pt + gray,
    inset: 12pt,
    
    [*"En haut à gauche"*\
    #text(style: "italic", size: 0.95em)[Pays en développement densément peuplés,\ défis institutionnels et sanitaires]

    #v(0.5em)
    #text(weight: "semibold")[Bangladesh, certains pays d'Asie du Sud]
    
    #v(0.5em)
    PIB faible\
    Institutions fragiles\
    Forte densité de population\
    Petite superficie\
    Forte prévalence de la malaria\
    Température élevée
    ],
    
    [*"En haut à droite"*\
    #text(style: "italic", size: 0.95em)[Cités-États développées,\ modèle urbain dense et prospère]

    #v(0.5em)
    #text(weight: "semibold")[Singapour, Hong Kong]
    
    #v(0.5em)
    PIB très élevé\
    Institutions solides\
    Très forte densité\
    Très petite superficie\
    Faible prévalence de la malaria\
    Climat tempéré/tropical urbanisé
    ],
    
    [*"En bas à gauche"*\
    #text(style: "italic", size: 0.95em)[Pays en développement à faible densité,\ héritages coloniaux extractifs,\ défis majeurs de développement]
    
    #v(0.5em)
    #text(weight: "semibold")[Mali, Niger, Burkina Faso,\ pays d'Afrique subsaharienne]
    
    #v(0.5em)
    PIB très faible\
    Institutions très fragiles\
    Faible densité de population\
    Grande superficie\
    Très forte prévalence de la malaria\
    Température très élevée\
    Faible proportion de descendants d'Européens
    ],
    
    [*"En bas à droite"*\
    #text(style: "italic", size: 0.95em)[Colonies de peuplement, « Nouvelles Europe »,\ vastes territoires peu peuplés et prospères]
    
    #v(0.5em)
    #text(weight: "semibold")[Canada, Australie, Nouvelle-Zélande, USA]
    
    #v(0.5em)
    PIB très élevé\
    Institutions très solides\
    Très faible densité\
    Très grande superficie\
    Absence de malaria\
    Température basse/tempérée\
    Forte proportion de descendants d'Européens
    ],
  ),
  caption: [Typologie des pays selon les axes 1 et 2 (Développement et Densité)]
)

=== Plan factoriel 3-4 : Population et Héritage colonial

#figure(
  table(
    columns: 2,
    align: center + horizon,
    stroke: 0.5pt + gray,
    inset: 12pt,
    
    [*"En haut à gauche"*\
    #text(style: "italic", size: 0.95em)[Grands pays peuplés avec\ héritage colonial extractif,\ conditions sanitaires\ historiquement difficiles]
    
    #v(0.5em)
    #text(weight: "semibold")[Inde, Indonésie, Pakistan, Nigeria]
    
    #v(0.5em)
    Population très élevée (> 100M)\
    Mortalité des colons élevée\
    Forte prévalence historique de la malaria\
    Institutions coloniales extractives\
    Zones tropicales hostiles
    ],
    
    [*"En haut à droite"*\
    #text(style: "italic", size: 0.95em)[Rare : grands pays peuplés\ issus de colonies de\ peuplement réussies]
    
    #v(0.5em)
    #text(weight: "semibold")[USA (cas limite)]
    
    #v(0.5em)
    Population élevée\
    Mortalité des colons faible\
    Faible prévalence de la malaria\
    Institutions coloniales inclusives\
    Zones tempérées favorables
    ],
    
    [*"En bas à gauche"*\
    #text(style: "italic", size: 0.95em)[Petits pays avec conditions\ coloniales très défavorables,\ développement limité]
    
    #v(0.5em)
    #text(weight: "semibold")[Pays d'Afrique centrale,\ certains pays d'Amérique\ latine tropicale]
    
    #v(0.5em)
    Population faible (< 20M)\
    Mortalité des colons très élevée\
    Très forte prévalence de la malaria\
    Institutions extractives persistantes\
    Sous-développement marqué
    ],
    
    [*"En bas à droite"*\
    #text(style: "italic", size: 0.95em)[Colonies de peuplement à\ faible population, modèle\ « Nouvelle Europe »,\ développement optimal]
    
    #v(0.5em)
    #text(weight: "semibold")[Canada, Australie,\ Nouvelle-Zélande, Uruguay]
    
    #v(0.5em)
    Population faible à modérée\
    Mortalité des colons très faible\
    Absence de malaria\
    Institutions inclusives héritées\
    Zones tempérées\
    Forte proportion de\ descendants d'Européens
    ],
  ),
  caption: [Typologie des pays selon les axes 3 et 4 (Population et Héritage colonial)]
)

== Messages principaux à retenir

*Les institutions sont le déterminant fondamental du développement.* La qualité institutionnelle explique 42,84% des différences de développement. Ce ne sont pas les ressources naturelles ou la géographie qui expliquent prioritairement le développement, mais les institutions économiques et politiques.

*L'héritage colonial persiste avec une force remarquable.* Plus de 150 ans après la colonisation, la distinction entre colonies de peuplement et colonies extractives reste l'un des meilleurs prédicteurs du développement, révélant l'extraordinaire inertie des structures institutionnelles.

*La géographie n'est pas un destin.* Bien que la géographie apparaisse importante, son influence est principalement indirecte et historique. Singapour et Hong Kong démontrent que les handicaps géographiques peuvent être surmontés par des institutions exceptionnelles.

== Limites de l'analyse

*Limites méthodologiques :* L'ACP révèle des corrélations mais ne peut établir la causalité. 31,3% des pays sont mal représentés sur le plan 1-2, notamment l'Inde, l'Indonésie et le Guatemala, indiquant des trajectoires atypiques non capturées.

*Limites des données :* L'échantillon de 64 pays ne représente qu'une partie de la diversité mondiale. Les données représentent un snapshot temporel ne capturant pas les dynamiques récentes. Plusieurs variables importantes sont omises : capital humain, ouverture commerciale, ressources naturelles, stabilité politique contemporaine.

*Limites interprétatives :* L'analyse ignore les dynamiques précoloniales et réduit l'histoire des sociétés à leur seule expérience coloniale.

== Perspectives et prolongements

*Approfondissements méthodologiques :* Analyses temporelles pour identifier les pays en convergence, analyses causales avec variables instrumentales, études qualitatives des cas atypiques (Singapour, Botswana).

*Enrichissements empiriques :* Intégration d'autres variables (capital humain, ressources naturelles), analyses intra-nationales pour capturer l'hétérogénéité des grands pays, comparaisons entre colonisateurs.

*Extensions théoriques :* Intégration des facteurs précoloniaux, analyse des mécanismes de transformation institutionnelle (facteurs déclencheurs, obstacles, acteurs du changement).

== Conclusion

Cette analyse confirme l'importance centrale des institutions dans le développement et la persistance des structures coloniales. Cependant, des cas atypiques (Singapour, Hong Kong) démontrent que l'héritage colonial ne détermine pas systématiquement le développement futur.

Cela nous invite à *reconnaître le poids de l'histoire* sans tomber dans le déterminisme, et *croire en la possibilité du changement* sans non plus, se montrer naîfs. Les institutions persistent, mais elles peuvent être transformées. Cette tension entre persistance et changement constitue l'un des enjeux centraux du développement au XXIe siècle.

// Cache les citations (taille de texte à 0pt)
#set text(size: 0pt)
@bourgeois_cours_acp @bourgeois_guide_acp
#set text(size: 10pt) // Réinitialise la taille du texte