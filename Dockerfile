FROM condaforge/mambaforge:4.9.2-5 as conda

COPY environment.yml .
RUN mamba env create -f environment.yml && conda clean -afy && \
        find -name '__pycache__' -type d -exec rm -rf '{}' '+' && \
        rm -rf /opt/conda/envs/nmma/lib/python3.9/site-packages/pip && \
        rm -rf /opt/conda/envs/nmma/lib/python3.9/i{dlelib, ensurepip} && \
        rm -rf /opt/conda/envs/nmma/lib{a,t,l,u}san.so && \
        find -name '*.a' -delete

FROM gcr.io/distroless/base-debian10

COPY --from=conda /opt/conda/envs/nmma /env
COPY app.py /nmma/app.py
COPY /utils /nmma/utils
COPY /priors /nmma/priors
COPY --from=conda /usr/bin/cat /usr/bin/cat

ENTRYPOINT ["/env/bin/python", "/nmma/app.py"]



