# LaTeX workspace

This repository contains an example of project code for automatic dependencies management and perfect integration of results in LaTeX. The goals are twofolds:

1. Automating the build, from raw data to final document.
2. Getting rid of the tedious process of manually regenerating results, figures, tables when they get outdated.

## Introduction

In a typical project, the general workflow is given by the following chart.

![organizational_chart](https://i.ibb.co/b6xSVyq/organizational-chart.png)

1. A numerical experiment is set up based on some input data (e.g. training dataset, experimental measurements etc.) and configuration files (e.g. hyperparameters).
2. Scripts produce intermediate files (e.g. checkpoints etc.) that can be used by other scripts. Final figures and tables are also scripted for reproducibility and automatic management purposes.
3. The final document is produced using LaTeX.

Ideally, the whole pipeline should have the following properties:

- **Scripted management:** Every arrow in the chart should be automated and a modification somewhere in the pipeline should trigger the built of all dependencies. This allows consistency and minimum human intervention in case of modifications in the pipeline.
- **Integration:** The style of the final artifacts (figures, tables etc.) should match exactly the style of the document (font, sizes etc.)

This project is an attempt to obtain such properties. It relies on Makefiles to manage and build dependencies and on the PythonTeX package to call Python within LaTeX.

## Installation

1. Clone the project

    ```bash
    git clone --recurse-submodules https://github.com/bilelomrani1/latex-workspace.git
    cd latex-workspace
    ````

2. Create a new virtual environment (recommended), for example with conda

    ```bash
    conda create -n latex python=3.8
    conda activate latex
    ```

3. Set your environment variables

    ```bash
    conda env config vars set MATPLOTLIBRC=$(cd report; pwd)
    conda env config vars set TEXINPUTS=.:$(cd report; pwd):$TEXINPUTS
    conda env config vars set PATH=$PATH:$(cd report; pwd)
    conda activate latex
    ```

4. Install dependencies

    ```bash
    pip install -r requirements.txt
    ```

5. Install the custom pygments color scheme

    ```bash
    cd report/pygments-style-workspace
    sudo python setup.py install
    ```

6. Follow the instructions on [Latexmk website](https://mg.readthedocs.io/latexmk.html) to install `latexmk`.

## Usage

### Recipes

Use the Makefile to manage dependencies and set up the pipeline. In the `report/` directory, use `make` to automatically build the PDF report. Additionally, you can use the following recipes:

- `make draft` to create a draft version of the report
- `make revision` to create a revision version
- `make print` to create a printable version of the report
- `make clean` to clean auxiliary files
- `make cleanall` to clean more aggressively.

### Subfiles

To create a new subfile directory, run the following command in the `tex/` directory

```bash
cookiecutter new_subfile/
```

A subfile can be compiled separately with its own Makefile.

## Advanced features

The `minionpro` option of the class file `workspace.cls` requires a valid installation of Adobe MinionPro font, along with LaTeX package [`minionpro`](https://www.ctan.org/pkg/minionpro).
