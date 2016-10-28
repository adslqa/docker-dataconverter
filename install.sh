set -ev

echo '--- installing pip install ----'
pip install --upgrade pip
pip install requests[security]
export PIP_DEFAULT_TIMEOUT=300

echo "-----------------Install WGRIB2-----------------"
cd /tmp
curl -o wgrib2.tgz http://www.ftp.cpc.ncep.noaa.gov/wd51we/wgrib2/wgrib2.tgz
tar xfz wgrib2.tgz
cd grib2
curl -L -o netcdf-4.3.3.tar.gz ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4.3.3.tar.gz
curl -L -o hdf5-1.8.16.tar.gz http://www.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8.16/src/hdf5-1.8.16.tar.gz
export CC=gcc && export FC=gfortran && make USE_IPOLATES=1 USE_NETCDF4=1 USE_NETCDF3=0
mv wgrib2 /usr/local/
ln -s /usr/local/wgrib2/wgrib2 /usr/local/bin/
cd "$BASEDIR"

echo "-----------------Install GRIB-API-----------------"
cd /tmp
curl -o grib_api_src.tar.gz https://software.ecmwf.int/wiki/download/attachments/3473437/grib_api-1.14.7-Source.tar.gz
tar xfz grib_api_src.tar.gz
cd grib_api-1.14.7-Source
./configure
make
make install

echo '--------------- installing proj ---------------'
cd /tmp
curl -L -O http://download.osgeo.org/proj/proj-4.9.3.tar.gz
tar zxvf proj-4.9.3.tar.gz && cd proj-4.9.3
./configure 2>&1 | tee configure.log
make 2>&1 | tee make.log
make check 2>&1 | tee check.log
make install 2>&1 | tee install.log
ldconfig

echo "-----------------Install CDO-----------------"
cd /tmp
curl -L -o cdo.tar.gz https://code.zmaw.de/attachments/download/12760/cdo-1.7.2.tar.gz
tar -zxf cdo.tar.gz
cd cdo-1.7.2
#./configure --with-netcdf=/usr --with-hdf5=/usr --prefix=/usr/local
./configure --with-netcdf=yes --with-hdf5=yes --with-grib_api=yes --with-proj=/usr/local/share/proj --prefix=/usr/local
make
make install
ldconfig

echo "-----------------Install pip / python stuff -----------------"
pip install --upgrade numpy
pip install --upgrade pyyaml
pip install --upgrade pyproj
pip install --upgrade pygrib
pip install --upgrade netcdf4
pip install --upgrade apscheduler

echo '--- cleaning up ----'
rm -rf /tmp/*
rm -rf ~/.cache/pip/*
