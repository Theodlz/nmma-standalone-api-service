FROM continuumio/miniconda3

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get -y install gcc mono-mcs && \
    rm -rf /var/lib/apt/lists/*


ADD . /nmma
WORKDIR /nmma

RUN conda env create -f environment.yml
# Initialize conda in bash config fiiles:

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "nmma", "/bin/bash", "-c"]

EXPOSE 6901

ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "nmma", "python", "app.py"]

