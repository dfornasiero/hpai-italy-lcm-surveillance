# Integrating wild bird and environmental samples can strengthen avian influenza surveillance
Diletta Fornasiero¹˒²\*, Valentina Panzarin¹, Marika Crimaudo¹, Ilaria Zambon¹, Sabrina Marciano¹, Alessio Bortolami¹, Luca Martelli¹, Francesca Scolamacchia¹, Mariette Ducatez², Laetitia Montacq², Timothée Vergne², Claire Guinat², Paolo Mulatti¹

¹ Istituto Zooprofilattico Sperimentale delle Venezie, Viale dell’Università 10, 35020, Legnaro, Italy\
² Univ Toulouse, ENVT, INRAE, IHAP, Toulouse, France

\*Corresponding author: **Diletta Fornasiero** - `dfornasiero@izsvenezie.it`
------------------------------------------------------------------------

## Abstract
<small> Early detection of avian influenza (AI) relies on detecting virus circulation in wild birds and their environment, which contributes to infection pressure in poultry and regional dissemination. However, current European legislation primarily targets dead, sick, or hunted wild birds, while environmental sampling is not formally included. This study compares the sensitivity of wild bird and environmental sampling strategies for AI surveillance and evaluates the added value of environmental sampling.
During the 2024–2025 High Pathogenicity AI (HPAI) season in north-eastern Italy, samples were collected in high-risk wetlands from captured and hunted wild birds (oropharyngeal, cloacal, feather swabs, and brain samples) and the environment (faecal droppings and surface water via passive samplers). Bayesian latent class models were used to estimate the sensitivity (Se) of individual sample type (bird level) and surveillance strategies (field-visit level), and virus prevalence.
At the bird level, for HPAI detection, brain samples performed best (Se=0.82, 95% Credible Interval [95%CrI]=0.58-0.99), followed by oropharyngeal (Se=0.63, 95%CrI=0.25-0.98), cloacal (Se=0.05, 95%CrI=0.00-0.22) and feather swabs (Se=0.09, 95%CrI=0.00-0.32). At the field-visit level, environmental-based strategies showed the highest sensitivities for M gene detection (surface water, Se=0.77, 95%CrI=0.63-0.89; faeces, Se=0.71, 95%CrI=0.57-0.84). Estimated AI prevalence in hunted and captured wild birds was 5.20% (95%CrI=2.40-8.60%) for M gene, 3.10% (95%CrI=1.30-6.30%) for H5, and 2.70% (95%CrI=1.10-6.00%) for H5 HPAI.
Environmental sampling strategies showed higher sensitivity than bird-based samples and, although relying on M gene detection, can complement existing surveillance by enhancing early warning of AIV circulation and guiding targeted follow-up sampling in poultry. </small>

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
