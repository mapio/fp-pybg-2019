#!/bin/bash

mkdocs build
rsync -zPav site/ mercurio:public_html/pybg/
