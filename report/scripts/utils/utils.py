#!/usr/bin/env python
# -*- coding: utf-8 -*-

import re


def get_begin(table_str):
    return table_str.split('\n')[0]+'\n'


def get_end(table_str):
    return table_str.split('\n')[-2]+'\n'


def get_head(table_str):
    pattern = re.search(
        r'\\toprule\n(.|\n)*\\\\\n\\midrule\n\\endhead\n', table_str)
    return pattern.group(0)


def get_header(table_str):
    pattern = re.search(
        r'(?<=\\toprule\n)(.|\n)*(?=\\\\\n\\midrule\n\\endhead\n)', table_str)
    return pattern.group(0)


def get_foot(table_str):
    pattern = re.search(
        r'(?<=\\midrule\n\\endhead\n)\\midrule\n(.|\n)*\\\\\n\\midrule\n\\endfoot\n', table_str)
    return pattern.group(0)


def get_last_foot(table_str):
    return '\n\\bottomrule\n\\endlastfoot\n'


def get_body(table_str):
    pattern = re.search(r'(?<=\\endlastfoot\n)(.|\n)*(?=\\end{)', table_str)
    return pattern.group(0)


def get_header_lines(table_str):
    header = get_header(table_str)
    return list(map(lambda string: string.strip(), re.split('\\\\\\\\\n', header)))


def get_header_heads(table_str, num):
    header_line = get_header_lines(table_str)[num]
    return list(map(lambda string: string.strip(), header_line.split('&')))


def _insert_thead_in_line(table_str, num):
    header_line = get_header_heads(table_str, num)
    new_header = []
    inserted_cmidrule = []
    index_col = 0
    multicol_pattern = r'(?<=\d}{[A-Za-z]}{)[A-Za-z.\s_-]*(?=}\Z)'
    num_col_pattern = r'(?<=\\multicolumn{)\d+(?=})'
    multicol_command_pattern = r'\\multicolumn{\d+}{[A-Za-z]+}'

    for header in header_line:
        head_multicolumn = re.search(multicol_pattern, header)
        num_col = re.search(num_col_pattern, header)

        if num_col is not None:
            nbr_col = int(num_col.group(0))
            inserted_cmidrule.append(
                '\\cmidrule(lr){{{left}-{right}}}'.format(left=index_col+1, right=index_col+nbr_col))
            index_col += nbr_col
        else:
            index_col += 1

        if head_multicolumn is not None:
            s = re.sub(multicol_pattern,
                       r'\\thead{'+head_multicolumn.group(0)+'}', header)
            new_header.append(re.sub(multicol_command_pattern,
                                     r'\\mcx{'+str(nbr_col)+'}', s))

        else:
            new_header.append('{\\thead{'+header.strip()+'}}')

    return new_header, inserted_cmidrule


def _reformat_head(table_str):
    head_lines = get_header_lines(table_str)
    new_head_lines = []
    for num in range(len(head_lines)):
        new_header, inserted_cmidrule = _insert_thead_in_line(table_str, num)
        new_head_line = ' & '.join(new_header) + \
            '\\\\'+''.join(inserted_cmidrule)+'\n'
        new_head_lines.append(new_head_line)

    new_head = ''.join(new_head_lines).replace('\\', '\\\\')
    table_str = re.sub(
        r'(?<=\\toprule\n)(.|\n)*(?=\\midrule\n\\endhead\n)', new_head, table_str)

    return table_str


def _reformat_see_next_page(table_str):
    return re.sub(r'(?<=\{r\}\{)\{Continued on next page\}', r'\\seenextpagename', table_str)


def _reformat_columns(table_str, width=None, custom_column_format=None):
    if width is None:
        def convert(string): return string
    else:
        def convert(string): return string.upper()

    # Convert l to S column
    def l_to_S(string): return ''.join(
        ['S' if column == 'r' else convert(column) for column in string])

    if custom_column_format is None:
        # transform column
        pattern = re.search(
            r'(?<=\\begin{longtable}{)[r|c|l]*(?<!})', table_str)
        table_str = re.sub(
            r'(?<=\\begin{longtable}{)[r|c|l]*(?<!})', l_to_S(pattern.group(0)), table_str)

    return table_str


def _reformat_package(table_str, width=None):
    if width is not None:
        # replace longtable by xltabular
        table_str = re.sub(r'\\begin{longtable}',
                           r'\\begin{xltabular}{'+width+'}', table_str)
        table_str = re.sub(r'\\end{longtable}', r'\\end{xltabular}', table_str)
    return table_str


def post_process_table(table_str, width=None, custom_column_format=None, buf=None):
    table_str = _reformat_head(table_str)
    table_str = _reformat_see_next_page(table_str)
    table_str = _reformat_columns(table_str, width, custom_column_format)
    table_str = _reformat_package(table_str, width)
    if buf is not None:
        with open(buf, 'w') as f:
            f.write(table_str)
    else:
        return table_str
