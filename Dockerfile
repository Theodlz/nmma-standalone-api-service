FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y curl

RUN apt install -y make python3 python-is-python3 python3-pip

RUN apt install -y git

RUN git clone https://git.ligo.org/lscsoft/bilby.git && cd bilby && pip install -r requirements.txt && pip install .

RUN git clone https://github.com/Theodlz/nmma-standalone-api-service.git

RUN cd nmma-standalone-api-service && pip3 install -r requirements.txt

EXPOSE 6901

RUN cd nmma-standalone-api-service && python3 app.py