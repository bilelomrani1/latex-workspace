#!/usr/bin/env python
# -*- coding: utf-8 -*-

# %%

import os
import sys
import pandas as pd

from scripts.utils import post_process_table


def create_table(input_file,
                 column_format,
                 width=r"\\linewidth",
                 caption=None,
                 label=None,
                 buf=None,
                 show_index=False,
                 na_rep="na"):

    df = pd.DataFrame({'Name': ['John', 'Peter', 'Eva'],
                       'GPA': ['3.89', '2.85', '3.67']})

    with pd.option_context("max_colwidth", None):

        s = df.to_latex(longtable=True,
                        index=show_index,
                        na_rep=na_rep,
                        caption=caption,
                        label=label,
                        column_format=column_format)
        post_process_table(s,
                           width=width,
                           buf=buf,
                           custom_column_format=column_format)

    # Log relevant information
    info = {}

    return info, df


if __name__ == "__main__":

    # Create the table and retrieve logged data
    info, df = create_table(None, "RRR", caption="Test", label="tab:test")
    print(df)

# %%
