#!/bin/bash

if [ -e raw/raw_data.xlsx ] # if converted raw file exists, start docker containers
then
    echo "\nStarting Postgres and Jupyter...\n"
    /usr/libexec/docker/cli-plugins/docker-compose up -d
else
    if [ -e raw/raw_data.xls ] # if only original raw file exists, convert file and start docker containers
    then
        echo "\nConverting file from old xls to xlsx...\n"
        soffice --headless --convert-to xlsx --outdir raw raw/raw_data.xls
        
        echo "\nStarting Postgres and Jupyter...\n"
        /usr/libexec/docker/cli-plugins/docker-compose up -d
    else # if none of the files exists, download, convert and start docker containers
        echo "\nDownloading raw file...\n"
        wget -O raw/raw_data.xls https://github.com/raizen-analytics/data-engineering-test/raw/master/assets/vendas-combustiveis-m3.xls
        
        echo "\nConverting file from old xls to xlsx...\n"
        soffice --headless --convert-to xlsx --outdir raw raw/raw_data.xls
        
        echo "\nStarting Postgres and Jupyter...\n"
        /usr/libexec/docker/cli-plugins/docker-compose up -d
   fi
fi

# get the url to open Jupyter Lab
jupyter_lab=$(docker logs $(docker ps -q --filter "ancestor=jupyter/minimal-notebook") 2>&1 | grep 'http://127.0.0.1' | tail -1 | grep 'or ' | awk '{print $2}')

echo "$jupyter_lab"

# open Jupyter Lab in Docker container
xdg-open "$jupyter_lab" >/dev/null
