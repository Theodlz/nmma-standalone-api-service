FROM condaforge/mambaforge:4.9.2-5 as conda

COPY environment.yml .
RUN mamba env create -f environment.yml && conda clean -afy
RUN find -name '__pycache__' -type d -exec rm -rf '{}' '+'
RUN rm -rf /opt/conda/envs/nmma/lib/python3.9/site-packages/pip
RUN rm -rf /opt/conda/envs/nmma/lib/python3.9/i{dlelib, ensurepip}
RUN rm -rf /opt/conda/envs/nmma/lib{a,t,l,u}san.so
RUN find -name '*.a' -delete

FROM gcr.io/distroless/base-debian10

COPY --from=conda /opt/conda/envs/nmma /env
COPY app.py app.py
COPY /utils /utils
COPY /priors /priors
COPY --from=conda /usr/bin/cat /usr/bin/cat

CMD ["/env/bin/python", "app.py"]



