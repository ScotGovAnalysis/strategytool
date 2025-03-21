FROM "rocker/r-ver:4.4.2"

LABEL maintainer="<Maintainer name>, <Maintainer email>"

RUN apt-get update && apt-get install -y gnupg

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9

# system libraries of general use
RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    libssl3 \
    libxml2-dev

# basic shiny functionality
RUN R -e "install.packages(c('shiny'), repos='https://cloud.r-project.org/')"

# install dependencies of the dashboard_app
RUN R -e "install.packages(c('jsonlite','magrittr','r2d3','readxl','pkgload','markdown'), repos='https://cloud.r-project.org/')"

COPY NZST.tar.gz .

RUN R -e "install.packages('NZST.tar.gz', repos=NULL, type='source', lib='/usr/local/lib/R/site-library')"

# copy the app to the image
RUN mkdir /root/<username>
RUN mkdir /root/<username>/systemstool
COPY systemstool /root/<username>/systemstool

EXPOSE 3937

CMD ["R", "-e", "shiny::runApp('/root/<username>/systemstool',host='0.0.0.0',port=3937)"]
