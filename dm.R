# Purpose    : PCA on determinants of development across 64 formerly colonized
#              countries — produces figures written directly to the report's
#              assets folder and summary tables written to results/
# Data source: df_DM_2025_ADD.csv — cross-sectional dataset combining
#              institutional, economic, demographic and geographic indicators
#              drawn from Acemoglu, Johnson & Robinson (2001) and related sources
# Output     : 16 PNG figures → rapport/template/assets/images/
#              9 CSV tables   → results/
# Author     : Antoine C., Noah D.-G., Jules D., Hans P.
# Date       : 2025-12

# ----------------------------------------------------------------------------
# 1. LIBRAIRIES
# ----------------------------------------------------------------------------

library(corrplot)    # Visualisation de la matrice de corrélation
library(dplyr)       # Manipulation de données
library(FactoMineR)  # ACP
library(factoextra)  # Visualisation des résultats ACP
library(ggplot2)     # Graphiques supplémentaires
library(here)        # Chemins de fichiers relatifs
library(readr)       # Lecture des fichiers CSV

# ----------------------------------------------------------------------------
# 2. CHARGEMENT ET EXPLORATION DES DONNÉES
# ----------------------------------------------------------------------------

dossier_figures   <- here("rapport", "template", "assets", "images")
dossier_resultats <- here("results")
if (!dir.exists(dossier_resultats)) dir.create(dossier_resultats, recursive = TRUE)

df_brut <- read_csv(here("df_DM_2025_ADD.csv"), show_col_types = FALSE)

# Supprimer la colonne d'index automatique si présente
if (names(df_brut)[1] %in% c("...1", "")) {
  df_brut <- df_brut[, -1]
}

str(df_brut)
summary(df_brut)

cat("\nNombre d'individus:", nrow(df_brut), "\n")
cat("Nombre de variables:", ncol(df_brut), "\n")
cat("\nValeurs manquantes par variable:\n")
print(colSums(is.na(df_brut)))

# ----------------------------------------------------------------------------
# 3. SÉLECTION DES VARIABLES
# ----------------------------------------------------------------------------

variables_actives <- c(
  "risk", "latitude", "edes1975", "malfal94", "mort0",
  "gdp", "population", "land", "density", "average_temperature"
)

# Conserver uniquement les variables présentes dans le jeu de données
variables_actives <- variables_actives[variables_actives %in% names(df_brut)]
cat("\nVariables actives retenues:\n")
print(variables_actives)

variables_illustratives_quali  <- c("continent", "hemisphere")
variables_illustratives_quanti <- c("slave", "neoeuro")

variables_illustratives_quali  <- variables_illustratives_quali[
  variables_illustratives_quali %in% names(df_brut)
]
variables_illustratives_quanti <- variables_illustratives_quanti[
  variables_illustratives_quanti %in% names(df_brut)
]

df_acp               <- df_brut[, variables_actives]
df_illustratif_quali  <- df_brut[, variables_illustratives_quali,  drop = FALSE]
df_illustratif_quanti <- df_brut[, variables_illustratives_quanti, drop = FALSE]

# Forcer le type numérique (sécurité si import mixed-type)
df_acp <- df_acp |> mutate(across(everything(), as.numeric))

cat("\nValeurs manquantes dans les variables actives:\n")
print(colSums(is.na(df_acp)))

noms_pays <- df_brut$longname

# ----------------------------------------------------------------------------
# 4. STATISTIQUES DESCRIPTIVES
# ----------------------------------------------------------------------------

cat("\n=== STATISTIQUES DESCRIPTIVES ===\n")
summary(df_acp)

matrice_corr <- cor(df_acp, use = "complete.obs")
cat("\n=== MATRICE DE CORRÉLATION ===\n")
print(round(matrice_corr, 3))

png(here(dossier_figures, "01_matrice_correlation.png"),
    width = 1200, height = 1000, res = 150)
corrplot(matrice_corr,
         method = "color", type = "upper",
         order = "hclust", tl.cex = 0.8, tl.col = "black")
dev.off()

# ----------------------------------------------------------------------------
# 5. CENTRAGE ET RÉDUCTION
# ----------------------------------------------------------------------------

cat("\n=== DISCUSSION : CENTRAGE ET RÉDUCTION ===\n")
cat(
  "Les variables ont des échelles très hétérogènes (PIB en milliers de dollars,",
  "population en millions, température en degrés, etc.).",
  "Le centrage-réduction est donc nécessaire pour éviter qu'une variable à",
  "grande variance ne domine mécaniquement l'analyse.\n"
)

cat("\nÉcarts-types des variables actives:\n")
print(round(apply(df_acp, 2, sd, na.rm = TRUE), 3))

# ----------------------------------------------------------------------------
# 6. POIDS DES INDIVIDUS
# ----------------------------------------------------------------------------

cat("\n=== DISCUSSION : POIDS DES INDIVIDUS ===\n")
cat(
  "Poids uniformes retenus : chaque pays contribue équitablement à la",
  "construction des axes, ce qui est cohérent avec l'objectif de comparer",
  "les structures de développement plutôt que les poids relatifs des pays.\n"
)

# ----------------------------------------------------------------------------
# 7. RÉALISATION DE L'ACP
# ----------------------------------------------------------------------------

cat("\n=== ACP PRINCIPALE ===\n")

# scale.unit = TRUE : centrage-réduction automatique
# ncp = 5 : 5 composantes conservées (les 4 retenues + 1 de marge)
# graph = FALSE : graphiques produits manuellement via factoextra
res.pca <- PCA(df_acp,
               scale.unit = TRUE,
               ncp = 5,
               graph = FALSE,
               quali.sup = NULL)

print(res.pca)

# ----------------------------------------------------------------------------
# 8. VALEURS PROPRES ET INERTIE
# ----------------------------------------------------------------------------

cat("\n=== VALEURS PROPRES ET INERTIE ===\n")

valeurs_propres <- res.pca$eig
print(round(valeurs_propres, 3))

# Critère de Kaiser : axes avec valeur propre > 1
axes_kaiser <- sum(valeurs_propres[, 1] > 1)
cat("\nNombre d'axes selon le critère de Kaiser:", axes_kaiser, "\n\n")

for (i in seq_len(min(5, nrow(valeurs_propres)))) {
  cat(sprintf(
    "Axe %d : %.2f%% d'inertie (cumulé : %.2f%%)\n",
    i, valeurs_propres[i, 2], cumsum(valeurs_propres[, 2])[i]
  ))
}

png(here(dossier_figures, "02_valeurs_propres.png"),
    width = 1000, height = 800, res = 150)
fviz_eig(res.pca,
         addlabels = TRUE,
         ylim = c(0, 50),
         main = "Graphique des valeurs propres (Scree Plot)",
         xlab = "Composantes principales",
         ylab = "Pourcentage d'inertie expliquée")
dev.off()

png(here(dossier_figures, "03_inertie_cumulee.png"),
    width = 1000, height = 800, res = 150)
inertie_cum <- cumsum(valeurs_propres[, 2])
plot(seq_along(inertie_cum), inertie_cum,
     type = "b",
     main = "Inertie cumulée",
     xlab = "Nombre de composantes",
     ylab = "Pourcentage d'inertie cumulée (%)",
     pch = 19, col = "steelblue")
grid()
abline(h = 80, col = "red", lty = 2, lwd = 2)
text(length(inertie_cum), 80, "80%", pos = 3, col = "red")
dev.off()

# ----------------------------------------------------------------------------
# 9. CONTRIBUTIONS DES VARIABLES
# ----------------------------------------------------------------------------

cat("\n=== CONTRIBUTIONS DES VARIABLES ===\n")

contrib_var_12 <- res.pca$var$contrib[, 1:2]
cat("\nContributions aux axes 1 et 2:\n")
print(round(contrib_var_12, 2))
write.csv2(round(contrib_var_12, 3),
           here(dossier_resultats, "contributions_variables_12.csv"),
           row.names = TRUE)

if (ncol(res.pca$var$contrib) >= 4) {
  contrib_var_34 <- res.pca$var$contrib[, 3:4]
  cat("\nContributions aux axes 3 et 4:\n")
  print(round(contrib_var_34, 2))
  write.csv2(round(contrib_var_34, 3),
             here(dossier_resultats, "contributions_variables_34.csv"),
             row.names = TRUE)
}

png(here(dossier_figures, "04_contributions_variables_12.png"),
    width = 1200, height = 1000, res = 150)
fviz_contrib(res.pca,
             choice = "var", axes = 1:2, top = 10,
             title = "Contributions des variables aux axes 1 et 2")
dev.off()

# ----------------------------------------------------------------------------
# 10. QUALITÉ DE REPRÉSENTATION DES VARIABLES (COS²)
# ----------------------------------------------------------------------------

cat("\n=== COS² DES VARIABLES ===\n")

cos2_var_12     <- res.pca$var$cos2[, 1:2]
cos2_plan12     <- rowSums(cos2_var_12)
cos2_var_export <- cbind(cos2_var_12, cos2_plan12 = cos2_plan12)

cat("\nCos² sur le plan 1-2:\n")
print(round(cos2_var_export, 3))
write.csv2(round(cos2_var_export, 3),
           here(dossier_resultats, "cos2_variables_12.csv"),
           row.names = TRUE)

png(here(dossier_figures, "05_cos2_variables_12.png"),
    width = 1200, height = 1000, res = 150)
fviz_pca_var(res.pca,
             col.var = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE,
             title = "Variables — qualité de représentation (cos²)")
dev.off()

# ----------------------------------------------------------------------------
# 11. CERCLE DES CORRÉLATIONS
# ----------------------------------------------------------------------------

png(here(dossier_figures, "06_cercle_correlations_12.png"),
    width = 1200, height = 1000, res = 150)
fviz_pca_var(res.pca,
             axes = c(1, 2),
             col.var = "contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE,
             title = "Cercle des corrélations — Plan 1-2")
dev.off()

if (ncol(res.pca$var$coord) >= 4) {
  tryCatch({
    png(here(dossier_figures, "07_cercle_correlations_34.png"),
        width = 1200, height = 1000, res = 150)
    print(fviz_pca_var(res.pca,
                       axes = c(3, 4),
                       col.var = "contrib",
                       gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
                       repel = TRUE,
                       title = "Cercle des corrélations — Plan 3-4"))
    dev.off()
  }, error = function(e) {
    cat("Erreur graphique 07:", e$message, "\n")
    if (dev.cur() != 1) dev.off()
  })
}

# ----------------------------------------------------------------------------
# 12. COORDONNÉES ET CONTRIBUTIONS DES INDIVIDUS
# ----------------------------------------------------------------------------

cat("\n=== COORDONNÉES DES INDIVIDUS ===\n")

coord_ind_12 <- res.pca$ind$coord[, 1:2]
rownames(coord_ind_12) <- noms_pays
print(round(head(coord_ind_12, 10), 3))
write.csv2(round(coord_ind_12, 3),
           here(dossier_resultats, "coordonnees_individus_12.csv"),
           row.names = TRUE)

cat("\n=== CONTRIBUTIONS DES INDIVIDUS ===\n")

contrib_ind_12 <- res.pca$ind$contrib[, 1:2]
rownames(contrib_ind_12) <- noms_pays
print(round(head(contrib_ind_12[order(contrib_ind_12[, 1], decreasing = TRUE), ], 10), 2))
write.csv2(round(contrib_ind_12, 3),
           here(dossier_resultats, "contributions_individus_12.csv"),
           row.names = TRUE)

png(here(dossier_figures, "08_contributions_individus_12.png"),
    width = 1200, height = 1000, res = 150)
fviz_contrib(res.pca,
             choice = "ind", axes = 1:2, top = 15,
             title = "Contributions des individus aux axes 1 et 2")
dev.off()

# ----------------------------------------------------------------------------
# 13. QUALITÉ DE REPRÉSENTATION DES INDIVIDUS (COS²)
# ----------------------------------------------------------------------------

cat("\n=== COS² DES INDIVIDUS ===\n")

cos2_ind_12     <- res.pca$ind$cos2[, 1:2]
cos2_plan12_ind <- rowSums(cos2_ind_12)
rownames(cos2_ind_12) <- noms_pays

cat("\nIndividus bien représentés sur le plan 1-2 (cos² > 0.5):\n")
print(round(cos2_plan12_ind[cos2_plan12_ind > 0.5], 3))

cat("\nIndividus mal représentés sur le plan 1-2 (cos² < 0.2):\n")
print(round(cos2_plan12_ind[cos2_plan12_ind < 0.2], 3))

cos2_ind_export <- cbind(cos2_ind_12, cos2_plan12 = cos2_plan12_ind)
write.csv2(round(cos2_ind_export, 3),
           here(dossier_resultats, "cos2_individus_12.csv"),
           row.names = TRUE)

# ----------------------------------------------------------------------------
# 14. GRAPHIQUES DES INDIVIDUS
# ----------------------------------------------------------------------------

png(here(dossier_figures, "09_individus_plan_12_cos2.png"),
    width = 1200, height = 1000, res = 150)
fviz_pca_ind(res.pca,
             axes = c(1, 2),
             col.ind = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE,
             select.ind = list(cos2 = 0.3),
             title = "Individus — Plan 1-2 (qualité de représentation)")
dev.off()

png(here(dossier_figures, "10_individus_plan_12_contrib.png"),
    width = 1200, height = 1000, res = 150)
fviz_pca_ind(res.pca,
             axes = c(1, 2),
             col.ind = "contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE,
             select.ind = list(contrib = 10),
             title = "Individus — Plan 1-2 (contributions)")
dev.off()

png(here(dossier_figures, "11_biplot_12.png"),
    width = 1400, height = 1200, res = 150)
fviz_pca_biplot(res.pca,
                axes = c(1, 2),
                repel = TRUE,
                col.var = "#2E9FDF",
                col.ind = "#696969",
                title = "Biplot — Plan 1-2")
dev.off()

if (ncol(res.pca$ind$coord) >= 4) {
  tryCatch({
    png(here(dossier_figures, "12_individus_plan_34.png"),
        width = 1200, height = 1000, res = 150)
    print(fviz_pca_ind(res.pca,
                       axes = c(3, 4),
                       col.ind = "cos2",
                       gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
                       repel = TRUE,
                       select.ind = list(cos2 = 0.2),
                       title = "Individus — Plan 3-4"))
    dev.off()
  }, error = function(e) {
    cat("Erreur graphique 12:", e$message, "\n")
    if (dev.cur() != 1) dev.off()
  })
}

# ----------------------------------------------------------------------------
# 15. AXES 3 ET 4
# ----------------------------------------------------------------------------

if (ncol(res.pca$var$contrib) >= 4) {
  cat("\n=== INERTIE DES AXES 3 ET 4 ===\n")
  cat("Axe 3:", round(valeurs_propres[3, 2], 2), "%\n")
  cat("Axe 4:", round(valeurs_propres[4, 2], 2), "%\n")
  cat("Cumulé axes 3-4:", round(sum(valeurs_propres[3:4, 2]), 2), "%\n")

  cos2_ind_34     <- res.pca$ind$cos2[, 3:4]
  cos2_plan34_ind <- rowSums(cos2_ind_34)
  rownames(cos2_ind_34) <- noms_pays

  cat("\nIndividus bien représentés sur le plan 3-4 (cos² > 0.3):\n")
  print(round(cos2_plan34_ind[cos2_plan34_ind > 0.3], 3))

  cos2_ind_34_export <- cbind(cos2_ind_34, cos2_plan34 = cos2_plan34_ind)
  write.csv2(round(cos2_ind_34_export, 3),
             here(dossier_resultats, "cos2_individus_34.csv"),
             row.names = TRUE)
}

# ----------------------------------------------------------------------------
# 16. VARIABLES ILLUSTRATIVES
# ----------------------------------------------------------------------------

cat("\n=== VARIABLES ILLUSTRATIVES ===\n")
cat("Qualitatives :", paste(variables_illustratives_quali,  collapse = ", "), "\n")
cat("Quantitatives :", paste(variables_illustratives_quanti, collapse = ", "), "\n")

# Convertir les variables illustratives qualitatives en facteurs
for (var in variables_illustratives_quali) {
  if (!is.factor(df_illustratif_quali[[var]])) {
    df_illustratif_quali[[var]] <- as.factor(df_illustratif_quali[[var]])
  }
}

# ACP avec variables illustratives qualitatives projetées sur les axes
df_acp_avec_quali <- cbind(df_acp, df_illustratif_quali)
quali_sup_indices  <- which(names(df_acp_avec_quali) %in% variables_illustratives_quali)

if (length(quali_sup_indices) > 0) {
  res.pca_illustratif <- PCA(df_acp_avec_quali,
                             scale.unit = TRUE,
                             ncp = 5,
                             graph = FALSE,
                             quali.sup = quali_sup_indices)
} else {
  res.pca_illustratif <- res.pca
}

# ACP avec variables illustratives quantitatives
if (length(variables_illustratives_quanti) > 0) {
  df_acp_avec_quanti <- cbind(df_acp, df_illustratif_quanti)
  quanti_sup_indices  <- (ncol(df_acp) + 1):ncol(df_acp_avec_quanti)

  res.pca_quanti_illustratif <- PCA(df_acp_avec_quanti,
                                    scale.unit = TRUE,
                                    ncp = 5,
                                    graph = FALSE,
                                    quanti.sup = quanti_sup_indices)

  tryCatch({
    png(here(dossier_figures, "15_variables_avec_illustratives_quanti.png"),
        width = 1200, height = 1000, res = 150)
    print(fviz_pca_var(res.pca_quanti_illustratif,
                       axes = c(1, 2),
                       col.var = "contrib",
                       gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
                       repel = TRUE,
                       title = "Cercle des corrélations avec variables illustratives quantitatives"))
    dev.off()
  }, error = function(e) {
    cat("Erreur graphique 15:", e$message, "\n")
    if (dev.cur() != 1) dev.off()
  })
}

# Individus colorés par continent
if ("continent" %in% names(df_illustratif_quali)) {
  tryCatch({
    png(here(dossier_figures, "13_individus_par_continent.png"),
        width = 1200, height = 1000, res = 150)
    print(fviz_pca_ind(res.pca,
                       axes = c(1, 2),
                       habillage = df_illustratif_quali$continent,
                       addEllipses = TRUE,
                       repel = TRUE,
                       title = "Individus — colorés par continent"))
    dev.off()
  }, error = function(e) {
    cat("Erreur graphique 13:", e$message, "\n")
    if (dev.cur() != 1) dev.off()
  })
}

# Individus colorés par hémisphère
if ("hemisphere" %in% names(df_illustratif_quali)) {
  tryCatch({
    png(here(dossier_figures, "14_individus_par_hemisphere.png"),
        width = 1200, height = 1000, res = 150)
    print(fviz_pca_ind(res.pca,
                       axes = c(1, 2),
                       habillage = df_illustratif_quali$hemisphere,
                       addEllipses = TRUE,
                       repel = TRUE,
                       title = "Individus — colorés par hémisphère"))
    dev.off()
  }, error = function(e) {
    cat("Erreur graphique 14:", e$message, "\n")
    if (dev.cur() != 1) dev.off()
  })
}

# Catégories des variables illustratives qualitatives
if (length(quali_sup_indices) > 0 && exists("res.pca_illustratif")) {
  tryCatch({
    png(here(dossier_figures, "16_categories_illustratives.png"),
        width = 1200, height = 1000, res = 150)
    print(fviz_pca_ind(res.pca_illustratif,
                       axes = c(1, 2),
                       habillage = df_illustratif_quali[[1]],
                       addEllipses = TRUE,
                       repel = TRUE,
                       title = "Catégories des variables illustratives qualitatives"))
    dev.off()
  }, error = function(e) {
    cat("Erreur graphique 16:", e$message, "\n")
    if (dev.cur() != 1) dev.off()
  })
}

# ----------------------------------------------------------------------------
# 17. SYNTHÈSE
# ----------------------------------------------------------------------------

cat("\n=== SYNTHÈSE ===\n")
cat("\nTop 5 des variables contribuant à l'axe 1:\n")
print(round(head(sort(res.pca$var$contrib[, 1], decreasing = TRUE), 5), 2))

cat("\nTop 5 des variables contribuant à l'axe 2:\n")
print(round(head(sort(res.pca$var$contrib[, 2], decreasing = TRUE), 5), 2))

cat("\nTop 5 des individus contribuant à l'axe 1:\n")
print(round(head(sort(res.pca$ind$contrib[, 1], decreasing = TRUE), 5), 2))

cat("\nTop 5 des individus contribuant à l'axe 2:\n")
print(round(head(sort(res.pca$ind$contrib[, 2], decreasing = TRUE), 5), 2))

# ----------------------------------------------------------------------------
# 18. EXPORT DES RÉSULTATS
# ----------------------------------------------------------------------------

write.csv2(round(valeurs_propres, 3),
           here(dossier_resultats, "valeurs_propres.csv"),
           row.names = TRUE)

write.csv2(round(res.pca$var$coord, 3),
           here(dossier_resultats, "coordonnees_variables.csv"),
           row.names = TRUE)

cat("\n=== EXPORT TERMINÉ ===\n")
cat("Figures     →", dossier_figures,  "\n")
cat("Tableaux    →", dossier_resultats, "\n")
