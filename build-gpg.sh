#!/bin/bash

set -e

BASE_DIR=$(pwd)

PREFIX=/Users/huylinhdo/groot

mkdir build
mkdir $PREFIX

# curl -O https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.2.27.tar.bz2
# curl -O https://gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.42.tar.bz2
# curl -O https://gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.9.2.tar.bz2
# curl -O https://gnupg.org/ftp/gcrypt/libksba/libksba-1.5.0.tar.bz2
# curl -O https://gnupg.org/ftp/gcrypt/libassuan/libassuan-2.5.5.tar.bz2
# curl -O https://gnupg.org/ftp/gcrypt/ntbtls/ntbtls-0.2.0.tar.bz2
# curl -O https://gnupg.org/ftp/gcrypt/npth/npth-1.6.tar.bz2

# curl -O https://gnupg.org/ftp/gcrypt/pinentry/pinentry-1.1.1.tar.bz2
# curl -O https://gnupg.org/ftp/gcrypt/gpgme/gpgme-1.15.1.tar.bz2
# curl -O https://gnupg.org/ftp/gcrypt/scute/scute-1.7.0.tar.bz2
# curl -O https://gnupg.org/ftp/gcrypt/gpa/gpa-0.10.0.tar.bz2

echo "Extracting files ..."

for FILE in *
do
    if [[ $FILE == *.tar.bz2 ]]
    then
        echo "Extracting $FILE"
        tar xzf $FILE -C build/
    fi
done

cd $BASE_DIR/build/libgpg-error-1.42
./configure --prefix=$PREFIX
make install

cd $BASE_DIR/build/libgcrypt-1.9.2
./configure --prefix=$PREFIX --with-libgpg-error-prefix=$PREFIX
make install

cd $BASE_DIR/build/libassuan-2.5.5
./configure --prefix=$PREFIX --with-libgpg-error-prefix=$PREFIX
make install

cd $BASE_DIR/build/libksba-1.5.0
./configure --prefix=$PREFIX --with-libgpg-error-prefix=$PREFIX
make install

cd $BASE_DIR/build/npth-1.6
./configure --prefix=$PREFIX
make install

cd $BASE_DIR/build/gnupg-2.2.27
./configure --prefix=$PREFIX --with-libgpg-error-prefix=$PREFIX --with-libgcrypt-prefix=$PREFIX --with-libassuan-prefix=$PREFIX --with-ksba-prefix=$PREFIX --with-npth-prefix=$PREFIX
make install

cd $BASE_DIR/build/pinentry-1.1.1
./configure --prefix=$PREFIX --with-libgpg-error-prefix=$PREFIX --with-libassuan-prefix=$PREFIX
make install