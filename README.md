electivity: Algorithms for electivity indices and measures of resource
use versus availability
================

[![DOI](https://zenodo.org/badge/201148710.svg)](https://zenodo.org/badge/latestdoi/201148710)

Desi Quintans (2019). *electivity: Algorithms for Electivity Indices.* R
package version 1.0.2. <https://github.com/DesiQuintans/electivity>

-----

This package is essentially Lechowicz (1982) turned into an R package.
It includes all algorithms that were described therein plus the example
data that was provided for gypsy moth resource utilisation.

Lechowicz, M.J., 1982. The sampling characteristics of electivity
indices. Oecologia 52, 22–30. <https://doi.org/10.1007/BF00349007>

Users are encouraged to read the original paper before deciding which
algorithm is most useful for them. Lechowicz recommended Vanderploeg and
Scavia’s E\* index (implemented in this package as `vs_electivity()`) as
“the single best, but not perfect, electivity index” because “E\*
embodies a measure of the feeder’s perception of a food’s value as a
function of both its abundance and the abundance of other food types
present.” In practice, he found that all indices returned nearly
identical rank orders of preferred hosts except for Strauss’ linear
index (L).

## Installing

``` r
# Installing from CRAN
install.packages(electivity)

# Installing from GitHub
install.packages(remotes)
remotes::install_github("DesiQuintans/electivity")

library(electivity)
```

## Built-in datasets

``` r
data(moth_distrib)  # Table 2 from Lechowicz (1982), raw data
data(moth_elect)    # Table 3 from Lechowicz (1982), calculated indices

head(moth_distrib)
```

    ##              binomen n_indiv dbh_cm_sum larva_mean_sum        r        p
    ## 1 Acer_pensylvanicum       1        8.5            0.5 2.86e-05 0.000566
    ## 2        Acer_rubrum       3       67.7            5.0 2.86e-04 0.004510
    ## 3     Acer_saccharum     158     2344.0         1342.0 7.68e-02 0.156000
    ## 4      Acer_spicatum       4       39.2           23.5 1.34e-03 0.002610
    ## 5     Amelanchier_sp       3       27.4           25.5 1.46e-03 0.001820
    ## 6  Betula_papyrifera      47      696.3           69.0 3.95e-03 0.046400

``` r
head(moth_elect)
```

    ##              binomen    E_i E_prime_i    D_i log_Q_i    L_i   W_i E_star_i
    ## 1 Acer_pensylvanicum -0.904     0.050 -0.904  -1.297 -0.001 0.006   -0.787
    ## 2        Acer_rubrum -0.881     0.063 -0.881  -1.199 -0.004 0.008   -0.739
    ## 3     Acer_saccharum -0.341     0.492 -0.380  -0.347 -0.079 0.061    0.075
    ## 4      Acer_spicatum -0.320     0.515 -0.321  -0.289 -0.001 0.064    0.098
    ## 5     Amelanchier_sp -0.111     0.800 -0.112  -0.097  0.000 0.099    0.308
    ## 6  Betula_papyrifera -0.843     0.085 -0.849  -1.089 -0.042 0.011   -0.665

## Examples

### Calculating food preference for a single animal

``` r
gypsy_moth_prefs <- vs_electivity(moth_distrib$r, moth_distrib$p)

names(gypsy_moth_prefs) <- moth_distrib$binomen

sort(gypsy_moth_prefs, decreasing = TRUE)
```

    ## Populus_grandidentata         Quercus_rubra     Ostrya_virginiana 
    ##            0.58107791            0.57940916            0.36470127 
    ##        Amelanchier_sp         Acer_spicatum       Juglans_cinerea 
    ##            0.30891287            0.09590718            0.08485274 
    ##        Acer_saccharum     Fagus_grandifolia       Tilia_americana 
    ##            0.07507596           -0.11166165           -0.17621830 
    ##         Pinus_strobus     Carya_cordiformis           Ulmus_rubra 
    ##           -0.32062903           -0.37337994           -0.50262587 
    ##   Prunus_pensylvanica     Betula_papyrifera    Fraxinus_americana 
    ##           -0.58618841           -0.66529208           -0.73713206 
    ##          Betula_lutea           Acer_rubrum    Acer_pensylvanicum 
    ##           -0.73883938           -0.73955078           -0.78682859 
    ##       Prunus_serotina 
    ##           -0.93239165

### Calculating food preference for many animals at many sites (Tidy approach)

``` r
library(tidyr)
library(dplyr)
library(purrr)

# Example data
df <- tibble::tribble(
           ~snail,     ~site,      ~food, ~pieces_eaten, ~pieces_present,
           "Bert", "outside",   "Carrot",             3,               7,
           "Bert", "outside", "Broccoli",             3,               8,
           "Bert", "outside",     "Kale",             1,               1,
           "Bert",  "inside",   "Carrot",             5,              11,
           "Bert",  "inside", "Broccoli",             7,               3,
           "Bert",  "inside",     "Kale",             2,               4,
          "Ernie", "outside",   "Carrot",             6,               7,
          "Ernie", "outside", "Broccoli",             4,               8,
          "Ernie", "outside",     "Kale",             1,               1,
          "Ernie",  "inside",   "Carrot",             3,              11,
          "Ernie",  "inside", "Broccoli",             1,               3,
          "Ernie",  "inside",     "Kale",             4,               4
          )


prefs <- 
    df %>% 
    # Nest the data for each snail x site pair
    nest(-snail, -site) %>% 
    # Apply vs_electivity() (or any other function) to each nested dataframe
    mutate(score = map(data, ~ vs_electivity(.$pieces_eaten, .$pieces_present))) %>% 
    # Expand the result (score) into new rows
    unnest(score, data) %>% 
    # Omit unwanted columns
    select(-pieces_eaten, -pieces_present) %>% 
    # Turn the sites into columns that show electivity for each snail x food pair.
    spread(key = site, value = score)

knitr::kable(prefs, format = "markdown")
```

| snail | food     |      inside |     outside |
| :---- | :------- | ----------: | ----------: |
| Bert  | Broccoli |   0.3608247 | \-0.2317073 |
| Bert  | Carrot   | \-0.4136808 | \-0.1676301 |
| Bert  | Kale     | \-0.3734177 |   0.2490706 |
| Ernie | Broccoli | \-0.2325581 | \-0.2222222 |
| Ernie | Carrot   | \-0.3250000 |   0.0434783 |
| Ernie | Kale     |   0.3026316 |   0.1200000 |

## Contributors

  - Desi Quintans <https://github.com/DesiQuintans>

Contributions are welcome\!
