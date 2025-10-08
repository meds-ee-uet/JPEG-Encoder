import os
import sys
sys.path.insert(0, os.path.abspath('..'))

project = 'JPEG Encoder'
author = 'Maktab-e-Digital Systems Lahore'
release = '1.0'

extensions = [
    'myst_parser',  # enable Markdown (.md) support
]

source_suffix = {
    '.rst': 'restructuredtext',
    '.md': 'markdown',
}

master_doc = 'index'  # your index.md inside docs/
html_theme = 'sphinx_rtd_theme'
