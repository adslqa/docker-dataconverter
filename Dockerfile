FROM centos:centos7
MAINTAINER Greg Chalmers <g.chalmers@metocean.co.nz>


# install standard building tools and other tools i tend to use
RUN yum -y install epel-release &&\
    yum install -y deltarpm &&\
    yum update -y &&\
    yum install -y wget curl libcurl curl-devel subversion git tar gzip unzip \
                gcc gcc-c++ gfortran \
                make cmake cmake3 autoconf automake libtool \
                libgcc \
                glibc glibc-devel glibc-static \
                libstdc++ libstdc++-devel libstdc++-static \
                zlib zlib-static zlib-devel bzip2 bzip2-devel ncurses ncurses-devel \
                libjpeg libjpeg-devel expat expat-devel gettext gettext-devel openssl openssl-devel \
                freetype freetype-devel libpng libpng-devel libtiff libtiff-devel openjpeg openjpeg-devel \
                perl-devel python-devel libffi devel-libffi libpng12 \
                lsof net-tools sysstat  &&\
    yum install -y netcdf netcdf-devel hdf5 hdf hdf-devel \
               netcdf4-python geos-devel \
               openblas openblas-devel \
               lapack lapack-devel lapack-static \
               blas-devel blas-static \
               openssl-devel libffi-devel python-devel python-pip &&\
    yum clean all


USER root
ADD ./ /tmp/install
RUN /tmp/install/install.sh
