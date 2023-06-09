# Leafcutter snakemake

## Necessary packages/tools
- [snakemake](https://snakemake.readthedocs.io/en/stable/getting_started/installation.html) (6.8.1)
- [leafcutter](https://davidaknowles.github.io/leafcutter/articles/Installation.html) (both leafcutter scripts & R package) (commit: 63b347a316cc214808b8c734ba181c602e950f06, R pckg version: 0.2.9)
- [regtools](https://github.com/griffithlab/regtools#installation) (0.5.2)
- [optparse](https://cran.r-project.org/web/packages/optparse/readme/README.html) (1.7.3)
- [data.table](https://github.com/Rdatatable/data.table#installation) (1.14.6)
- [dplyr](https://www.r-project.org/nosvn/pandoc/dplyr.html) (1.1.0)

### Leafcutter installation

For leafcutter quantifications (junction counts for each splicing cluster), you will require the python scripts in `scripts` and `clustering` directories:
```
git clone https://github.com/davidaknowles/leafcutter
```
For differential splicing analysis, the leafcutter R package is required:
```
devtools::install_github("davidaknowles/leafcutter/leafcutter")
```
Detailed installation instructions can be found [here](https://davidaknowles.github.io/leafcutter/articles/Installation.html).

## Setting up

1. Upload the `design.csv` experimental design file into the `input` directory as follows:

| sample | design  |
| ------ | ------  |
| F2014	 | control |
| F2011	 | control |
| F2003	 | control |
| F2001	 | treatment |
| F2010	 | treatment |
| F2002	 | treatment |

2. Open the `prep.R` file and change the following parameters to suit your experimental design:
```
setwd("/mnt/cbis/home/yongshan/leafcutter_snakemake") # leafcutter snakemake directory
experiment_name <- "WT_IgG2A_WT_O9_CTX" # set your own experiment name
design <- read.csv("./input/design.csv") # experimental design csv file
regtools_strand <- "1" # Note that: 0 = unstranded, 1 = first-strand/RF, 2, = second-strand/FR
gene_annotation <- "/mnt/gtklab01/linglab/mmusculus_annotation_files/gencode.vM29.primary_assembly.annotation.gtf.gz" # location of annotation gtf.gz file
bam_dir <- "/mnt/gtklab01/linglab/external_datasets/tdp43_Q331K_rescue_rubychen/STAR/" # directory with bam files
leafcutter_dir <- "/mnt/cbis/home/yongshan/leafcutter/" # directory of leafcutter installation
```

3. Open the `Snakefile` in `workflow` and change the first line to point to your config file location:
```
 configfile: "<your_snakemake_dir>/config/config.yaml"
 ...
```

4. Run `prep.R` on command line with
```
Rscript prep.R
```
in order to populate the directories with the necessary helper files. The following files should be successfully created:
- `config/config.yaml`
- `config/juncs_file.tsv`
- `config/output_junc.tsv`
- `config/samples.tsv`
- `config/<experiment_name>_groups_file.txt`
- `config/<experiment_name>_groups_junc.txt`

## Running Snakemake

Once the above finishes running successfully and the necessary helper files are created, execute a Snakemake dry run with
```
snakemake -np
```
to check the parameters of the run. Once ready to run, execute
```
snakemake --cores 24
```

## Output files

In the `results` directory, you should see the following output files:
- `<experiment_name>_cluster_significance.txt`
- `<experiment_name>_effect_sizes.txt`

All alternative splicing results are found in the above 2 files. 

`<experiment_name>_cluster_significance.txt` (significance of AS events):

<p align="left">
  <img src="../images/leafcutter_significance.PNG">
</p>

`<experiment_name>_effect_sizes.txt` (deltaPSI of AS events):

<p align="left">
  <img src="../images/leafcutter_effect_size.PNG">
</p>

## Other useful tools
- [Leafcutter vignette](https://davidaknowles.github.io/leafcutter/articles/Usage.html)

