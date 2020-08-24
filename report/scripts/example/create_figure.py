#!/usr/bin/env python
# -*- coding: utf-8 -*-

# %%

import matplotlib.pyplot as plt
import matplotlib as mpl
import pandas as pd
from sklearn.linear_model import LinearRegression


def create_figure(input_file):
    # Warning: You may need to use the keyword clip_on=True on some
    # primitives to properly render in LaTeX. Example: use clip_on=True
    # on plt.text primitives because if LaTeX commands are used inside
    # the text, the width of the text may be modified when expanded in
    # LaTeX so bounding boxes may not be correct.

    # Import and format data
    data = pd.read_csv(input_file, sep=';')
    X = data[["fixed acidity"]].values.reshape(-1, 1)
    Y = data[["pH"]].values.reshape(-1, 1)

    # Linear regression
    linear_regressor = LinearRegression()
    linear_regressor.fit(X, Y)

    # Plot scatter and prediction
    Y_pred = linear_regressor.predict(X)
    plt.figure()
    plt.scatter(X, Y, marker='x', s=10, label='measurements')
    plt.plot(X, Y_pred, color='red',
             label='linear model (see \\eqref{eq:test})')

    # Add linear regression equation
    equation = "$y=\\num{{{coeff}}} x + \\num{{{intercept}}}$".format(
        coeff=linear_regressor.coef_[0, 0],
        intercept=linear_regressor.intercept_[0])
    plt.text(12, 2.77, equation, clip_on=True)

    # Add label
    plt.xlabel('Fixed acidity')
    plt.ylabel('pH')
    plt.legend(loc='upper right')

    # Log relevant information here...
    info = {"coeff": linear_regressor.coef_[0, 0],
            "intercept": linear_regressor.intercept_[0]}
    return info


if __name__ == "__main__":

    print("Using matplotlibrc in ", mpl.matplotlib_fname())

    # Create the figure and retrieve logged data
    info = create_figure("../../../data/winequality-red.csv")
    plt.show()

# %%
