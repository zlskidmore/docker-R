# work from latest LTS ubuntu release
FROM ubuntu:16.04

# run update
RUN apt-get update -y && apt-get install -y \
  gfortran \
  libreadline-dev \
  libpcre3-dev \
  libcurl4-openssl-dev \
  build-essential \
  zlib1g-dev \
  libbz2-dev \
  liblzma-dev \
  openjdk-8-jdk \
  wget \
  libssl-dev \
  libxml2-dev

# change working dir
WORKDIR /usr/local/bin

# install R
RUN wget https://cran.r-project.org/src/base/R-3/R-3.5.1.tar.gz
RUN tar -zxvf R-3.5.1.tar.gz
WORKDIR /usr/local/bin/R-3.5.1
RUN ./configure --prefix=/usr/local/ --with-x=no
RUN make
RUN make install

# install R packages
RUN R --vanilla -e 'install.packages(c("devtools", "BiocManager"), repos="http://cran.us.r-project.org")'
RUN R --vanilla -e 'install.packages(c("ggplot2", "data.table", "sequenza"), repos = "http://cran.us.r-project.org")'
RUN R --vanilla -e 'BiocManager::install(c("biomaRt"))'
