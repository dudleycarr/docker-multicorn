FROM postgres:9.6.3

RUN apt-get update && apt-get install -y build-essential python-dev python-pip postgresql-server-dev-9.6
RUN apt-get clean
RUN pip install pgxnclient
RUN pgxn install multicorn

RUN apt-get install -y wget bzip2 ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh && \
    /bin/bash /Miniconda2-latest-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda2-latest-Linux-x86_64.sh && \
    /opt/conda/bin/conda install --yes conda=4.3.21

ENV PATH /opt/conda/bin:$PATH
ENV PYTHONPATH /usr/local/lib/python2.7/dist-packages/multicorn-1.3.3-py2.7-linux-x86_64.egg:$PYTHONPATH
VOLUME /src

COPY docker-entrypoint.sh /
RUN chmod a+x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]
