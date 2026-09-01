# Integrating wild bird and environmental samples can strengthen avian influenza surveillance
Diletta Fornasiero¹˒²\*, Valentina Panzarin¹, Marika Crimaudo¹, Ilaria Zambon¹, Sabrina Marciano¹, Alessio Bortolami¹, Luca Martelli¹, Francesca Scolamacchia¹, Mariette Ducatez², Laetitia Montacq², Timothée Vergne², Claire Guinat², Paolo Mulatti¹

¹ Istituto Zooprofilattico Sperimentale delle Venezie, Viale dell’Università 10, 35020, Legnaro, Italy\
² Univ Toulouse, ENVT, INRAE, IHAP, Toulouse, France

\*Corresponding author: **Diletta Fornasiero** - `dfornasiero@izsvenezie.it`
------------------------------------------------------------------------

## Abstract

1.	Early detection of avian influenza virus circulation in wild birds is important for anticipating infection pressure on poultry and regional virus dissemination. Current European legislation primarily targets dead, sick, or hunted wild birds, whereas environmental sampling is not formally integrated into surveillance programmes. In this study, we compare the sensitivity of wild bird and environmental sampling strategies for avian influenza surveillance and evaluate the added value of environmental sampling.
2.	During the 2024–2025 high pathogenicity avian influenza season in north-eastern Italy, we sampled wild birds and their environment in high-risk wetlands in north-eastern Italy. Captured and hunted wild birds were tested using oropharyngeal, cloacal, feather swabs, and brain samples; environmental sampling included fresh faecal droppings and surface water collected using passive samplers. Bayesian latent class models were used to estimate the sensitivity of individual sample type (bird level) and surveillance strategies (field-visit level), and virus prevalence.
3.	At the bird level, for estimated sensitivity for H5 high pathogenicity avian influenza detection was highest for brain samples (0.82, 95% credible interval=0.58-0.99), followed by oropharyngeal (0.63, 95% credible interval=0.25-0.98), whereas cloacal (0.05, 95% credible interval=0.00-0.22) and feather swabs (0.09, 95% credible interval=0.00-0.32) had substantially lower sensitivity.
4.	At the field-visit level, environmental-based strategies had the highest estimated sensitivities for M-gene detection: 0.77 (95% credible interval=0.63-0.89) for surface water and 0.71 (95% credible interval=0.57-0.84) for faecal sampling. Estimated prevalence among hunted and captured wild birds was 5.20% (95% credible interval=2.40-8.60%) for M gene, 3.10% (95% credible interval=1.30-6.30%) for H5, and 2.70% (95% credible interval=1.10-6.00%) for H5 high pathogenicity avian influenza.
5.	**Synthesis and applications**: Environmental sampling strategies showed higher sensitivity than bird-based samples and, although relying on M-gene detection, can complement wild-bird sampling by increasing opportunities to detect avian influenza virus circulation at high-risk wetlands without depending on access to infected birds. Integrating rapid environmental screening with targeted follow-up sampling in birds could strengthen early-warning systems, improve spatial targeting of surveillance and support more timely measures to reduce the risk of virus introduction into poultry populations.

------------------------------------------------------------------------

# Overview

This repository contains the code used to fit Bayesian latent class models (LCMs) for the analysis of Italian avian influenza surveillance data.
Three models were developed to jointly estimate the latent infection status of sampled wild birds and the diagnostic performance of different sample types, in the absence of a perfect reference test. Separate models were fitted for three molecular targets:
- **Influenza A matrix (M) gene**
- **H5 subtype**
- **H5 highly pathogenic avian influenza (H5 HPAI)**

An additional model was developed for the **M-gene analysis at the field-visit level**, with the latent state representing whether a surveillance visit was contaminated with influenza A virus. This model was used to evaluate the ability of the different bird- and environmental-based surveillance strategies to detect virus circulation at a sampled site and visit.

Analyses are implemented in **Stan** and run from **R**.

## Repository contents

```text
.
├── models/           # Stan code for the latent class models
├── model_fitting/    # R scripts for model fitting
├── plots/            # R scripts used to process model outputs and produce figures
└── README.md
---
