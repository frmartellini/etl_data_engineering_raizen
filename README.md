# Raízen Data Engineering Test - ANP Fuel Sales ETL

This is my solution for the Data Engineering Test that is part of the hiring process at Raízen. The code extract the data, make the transformation process and load in a Postgres DB inside a docker container.

For more information about the test goes to [ANP Fuel Sales ETL Test specifications](https://github.com/raizen-analytics/data-engineering-test)

## How to run:

1) Run the shell script *start.sh* to load Postegres and Jupyter as Docker containers.

2) Open Jupyter Notebook and run the file *etl_pipeline.ipynb*

3) Jupyter Notebook will start automatically, but if not, run the comand bellow to get the link to run:

```
docker logs $(docker ps -q --filter "ancestor=jupyter/minimal-notebook") 2>&1 | grep 'http://127.0.0.1' | tail -1 | grep 'or ' | awk '{print $2}'
```

## Future improvements:

The raw data is an old xls file that cannot be read by pandas, so is necessary convert the file to xlsx format. This can be done using the code below:

```
soffice --headless --convert-to xlsx --outdir raw raw/raw_data.xls
```

The code can be loaded in jupyter notebook using subprocess:

```
from subprocess import Popen

response = Popen(['soffice', '--headless', '--convert-to', 'xls', '--outdir', 'raw', 'raw_data.xls'])
```

However, I find some problems to using my local installation of Libre Office inside the Jupyter container. A possible solution is use some docker image for Libre Office, meanwhile, the extract and convert process is made by shell script, using my local installation to generate the file that will be loaded to the Jupyter Notebook.

Another improvement is use Airflow to automate the ETL process. This change will be added soon, as part of my self-learning process from Airflow.

