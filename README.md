# PCA on Determinants of Development in Colonial Societies

Principal Component Analysis applied to 64 formerly colonized countries to identify the structural dimensions of comparative development, interpreted through Acemoglu, Johnson & Robinson's (2001) institutional framework.

---

## Research question

What are the main dimensions that explain differences in economic development across formerly colonized countries, and to what extent do institutional, geographic, and historical factors structure these differences?

---

## Data

**Source:** Cross-sectional dataset assembled from Acemoglu, Johnson & Robinson (2001) and related sources (`df_DM_2025_ADD.csv`).

**Coverage:** 64 countries, one observation per country (circa 1995–2016).

**Active variables (10):**

| Variable | Description |
|---|---|
| `risk` | Expropriation risk index (0–10, higher = better institutions) |
| `edes1975` | Share of population with European descent in 1975 (%) |
| `malfal94` | Malaria prevalence in 1994 (%) |
| `mort0` | Estimated settler mortality (per 10,000) |
| `gdp` | GDP per capita at PPP, 1995 (USD) |
| `population` | Population size, 2024 |
| `land` | Territory area (km²) |
| `density` | Population density (inhabitants/km²) |
| `latitude` | Absolute mean latitude of country |
| `average_temperature` | Mean temperature 1991–2020 (°C) |

**Illustrative variables (4):** `continent`, `hemisphere` (qualitative); `slave`, `neoeuro` (quantitative). These are projected onto PCA axes without influencing their construction.

**Transformations:** All active variables standardized (zero mean, unit variance) prior to PCA, given the heterogeneous units of measurement.

---

## Methodology

**Method:** Principal Component Analysis (PCA) via `FactoMineR::PCA()`, with standardization (`scale.unit = TRUE`). All countries receive equal weight, consistent with the objective of a balanced comparative analysis rather than a size-weighted study.

**Number of components retained:** 4 axes, selected on three converging criteria:
- Kaiser criterion (eigenvalue > 1): 4 axes
- Scree plot: elbow clearly visible after axis 4
- Cumulative inertia: 79.68% explained by the first four axes

Qualitative illustrative variables (continent, hemisphere) were introduced via the `quali.sup` argument; quantitative illustratives (slave, neoeuro) via `quanti.sup`.

---

## Results

Four principal components account for 79.68% of total variance:

| Component | Eigenvalue | % Inertia | Cumulative % |
|---|---|---|---|
| PC1 | 4.284 | 42.84 | 42.84 |
| PC2 | 1.519 | 15.19 | 58.03 |
| PC3 | 1.157 | 11.57 | 69.60 |
| PC4 | 1.008 | 10.08 | 79.68 |

**PC1 — Economic and institutional development (42.84%).**
Dominated by GDP (`gdp`, 16.6%), European settler share (`edes1975`, 16.0%), temperature (`average_temperature`, 15.6%), expropriation risk (`risk`, 13.3%), and latitude (12.8%). This axis opposes settler colonies with strong institutions (Canada, USA, Australia, New Zealand — high GDP, low malaria, temperate climate) to extractive colonies with fragile institutions (Mali, Niger, Burkina Faso — low GDP, high malaria, tropical climate). The result corroborates Acemoglu et al. (2001): institutional quality is the primary predictor of comparative development.

**PC2 — Demographic density (15.19%).**
Driven almost entirely by `density` (49.7%). Opposes small, densely populated territories (Singapore, Hong Kong) to large, sparsely populated ones (Canada, Australia). This dimension is structurally independent of PC1: high development can coexist with either high or low density.

**PC3 — Absolute population size (11.57%).**
Dominated by `population` (63.6%). Distinguishes demographically large countries (India, Indonesia, Nigeria, Pakistan) from smaller ones, independently of density — revealing governance challenges specific to demographic scale.

**PC4 — Colonial sanitary legacy (10.08%).**
Driven by settler mortality `mort0` (53.7%) and malaria prevalence `malfal94` (15.1%). Countries with historically high settler mortality (tropical West and Central Africa, tropical Latin America) established extractive institutions; those with low settler mortality (Canada, USA, Australia) established inclusive ones. This dimension shows that colonial-era health conditions continue to structure development more than 150 years later.

**Illustrative variables:** The `neoeuro` variable projects firmly into the high-development quadrant of PC1, confirming the "Neo-Europe" model. Continent and hemisphere overlay onto PC1 as expected: African countries cluster in the low-development pole, North American and Oceanian countries in the high-development pole.

**Representation quality:** 33 countries (51.6%) are well-represented on the PC1–PC2 plane (cos² > 0.5); 17 (26.6%) are poorly represented (cos² < 0.2), notably India, Guatemala, Ecuador, and Indonesia — countries whose development trajectories are atypical and require axes 3–4 for fuller interpretation.

---

## Limitations

- PCA identifies correlational structure, not causal mechanisms. The institutional interpretation draws on external theory (Acemoglu et al., 2001) and cannot be inferred from the PCA alone.
- The 64-country sample covers formerly colonized societies; results are not generalizable to non-colonial development trajectories.
- Data represent a single cross-section and do not capture convergence dynamics or structural breaks.
- Several potentially relevant variables are absent: human capital, trade openness, natural resource endowments, and contemporary political stability.
- 26.6% of countries are poorly represented on the main factorial plane, indicating that four dimensions do not fully capture development heterogeneity.
- The analysis reduces each country's history to its colonial experience, ignoring pre-colonial structures.

---

## Repository structure

```
.
├── README.md                        # This file
├── .gitignore
├── dm.R                             # Full PCA analysis script
├── df_DM_2025_ADD.csv               # Dataset (64 countries × 17 variables)
├── results/                         # Numerical output (created by dm.R)
│   ├── valeurs_propres.csv
│   ├── coordonnees_variables.csv
│   ├── contributions_variables_12.csv
│   ├── contributions_variables_34.csv
│   ├── cos2_variables_12.csv
│   ├── coordonnees_individus_12.csv
│   ├── contributions_individus_12.csv
│   ├── cos2_individus_12.csv
│   └── cos2_individus_34.csv
└── rapport/
    ├── lib.typ                      # Typst template library ('Ilm)
    ├── typst.toml                   # Typst package configuration
    └── template/
        ├── main.typ                 # Report source (Typst)
        ├── refs.bib                 # Bibliography
        ├── rapport.pdf              # Compiled report
        └── assets/images/          # Figures — written here by dm.R,
                                    #   referenced directly by main.typ
```

---

## How to reproduce

**R version:** 4.3 or later
**Required packages:**

```r
install.packages(c("corrplot", "dplyr", "FactoMineR", "factoextra",
                   "ggplot2", "here", "readr"))
```

**Run order:**

1. Open an R session with the working directory set to the project root (or use RStudio with the project file).
2. Source `dm.R`. The script will create `RésultatsDM/` and populate it with all figures and tables.

```r
source("dm.R")
```

The written report (`rapport/template/main.typ`) is compiled with [Typst](https://typst.app). With Typst installed:

```sh
typst compile rapport/template/main.typ rapport/template/rapport.pdf
```

---

*Data analysis project — Université Catholique de Lille, S5, December 2025. Group project: Antoine C., Noah D.-G., Jules D., Hans P.. Grade: 19/20.*
