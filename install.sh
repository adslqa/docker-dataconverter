set -ev

echo "-----------------Install fcron ------------------------------"
cd /tmp
curl -L -o fcron.tar.gz http://fcron.free.fr/archives/fcron-3.2.0.src.tar.gz
tar -zxf fcron.tar.gz
cd fcron-3.2.0
./configure --prefix=/usr --sysconfdir=/etc --without-sendmail
make
make install


echo "-----------------Install WGRIB2-----------------"
cd /tmp
curl -o wgrib2.tgz http://www.ftp.cpc.ncep.noaa.gov/wd51we/wgrib2/wgrib2.tgz
tar xfz wgrib2.tgz
cd grib2
curl -L -o netcdf-4.3.3.tar.gz ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4.3.3.tar.gz
curl -L -o hdf5-1.8.16.tar.gz http://www.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8.16/src/hdf5-1.8.16.tar.gz
export CC=gcc && export FC=gfortran && make USE_IPOLATES=1 USE_NETCDF4=1 USE_NETCDF3=0
mv wgrib2 /usr/local/
ln -s /usr/local/wgrib2/wgrib2 /usr/bin/
cd "$BASEDIR"

echo '--- cleaning up ----'
rm -rf /tmp/*
