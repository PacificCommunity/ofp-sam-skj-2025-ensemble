# SKJ 2025 Model Ensemble

Download SKJ 2025 assessment report:

**Stock Assessment of Skipjack: 2025**\
**[WCPFC-SC21-2025/SA-WP-02](https://meetings.wcpfc.int/node/26679)**

Download SKJ 2025 diagnostic model:

- Clone the **[skj-2025-diagnostic](https://github.com/PacificCommunity/ofp-sam-skj-2025-diagnostic)** repository or download as **[main.zip](https://github.com/PacificCommunity/ofp-sam-skj-2025-diagnostic/archive/refs/heads/main.zip)** file

Download SKJ 2025 ensemble results:

- Clone the **[skj-2025-ensemble](https://github.com/PacificCommunity/ofp-sam-skj-2025-ensemble)** repository or download as **[main.zip](https://github.com/PacificCommunity/ofp-sam-skj-2025-ensemble/archive/refs/heads/main.zip)** file

## Uncertainty

The SKJ 2025 assessment uncertainty was estimated using a Monte Carlo model ensemble approach in which 271 models incorporated uncertainty in average natural mortality, stock-recruitment steepness and estimation error for individual models:

## Ensemble results

This repository contains all files necessary to browse the SKJ 2025 ensemble.

The final par and rep files are consistently named `11.par` and `plot-11.par.rep` to facilitate harvesting results from across the 271 ensemble models.

## Estimating uncertainty

See also Section 9, Section 11.6 and Table 5 in the SKJ 2025 stock assessment report.

The `estimate_uncertainty.R` script requires two R packages that are available on GitHub:

```
install_github("flr/FLCore")
install_github("PacificCommunity/FLR4MFCL")
```
