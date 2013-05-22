#!/bin/sh
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -ex

usage() {
  echo "
usage: $0 <options>
  Required not-so-options:
     --build-dir=DIR             path to karafdist.dir
     --prefix=PREFIX             path to install into

  Optional options:
     --doc-dir=DIR               path to install docs into [/usr/share/doc/karaf]
     --lib-dir=DIR               path to install karaf home [/usr/lib/karaf]
     --bin-dir=DIR               path to install bins [/usr/bin]
     --examples-dir=DIR          path to install examples [doc-dir/examples]
     ... [ see source for more similar options ]
  "
  exit 1
}

OPTS=$(getopt \
  -n $0 \
  -o '' \
  -l 'prefix:' \
  -l 'doc-dir:' \
  -l 'lib-dir:' \
  -l 'bin-dir:' \
  -l 'examples-dir:' \
  -l 'log-dir:' \
  -l 'build-dir:' -- "$@")

if [ $? != 0 ] ; then
    usage
fi

eval set -- "$OPTS"

while true ; do
    case "$1" in
        --prefix)
        PREFIX=$2 ; shift 2
        ;;
        --build-dir)
        BUILD_DIR=$2 ; shift 2
        ;;
        --doc-dir)
        DOC_DIR=$2 ; shift 2
        ;;
        --lib-dir)
        LIB_DIR=$2 ; shift 2
        ;;
        --bin-dir)
        BIN_DIR=$2 ; shift 2
        ;;
        --examples-dir)
        EXAMPLES_DIR=$2 ; shift 2
        ;;
        --log-dir)
        LOG_DIR=$2 ; shift 2
        ;;
        --)
        shift ; break
        ;;
        *)
        echo "Unknown option: $1"
        usage
        exit 1
        ;;
    esac
done

for var in PREFIX BUILD_DIR ; do
  if [ -z "$(eval "echo \$$var")" ]; then
    echo Missing param: $var
    usage
  fi
done

MAN_DIR=${MAN_DIR:-/usr/share/man/man1}
DOC_DIR=${DOC_DIR:-/usr/share/doc/karaf}
LIB_DIR=${LIB_DIR:-/usr/lib/karaf}
BIN_DIR=${BIN_DIR:-/usr/lib/karaf/bin}
SHARE_DIR=${SHARE_DIR:-/usr/share/karaf}
KARAF_LIB=${KARAF_LIB:-/usr/share/karaf/lib}
ETC_DIR=${ETC_DIR:-/etc/karaf}
VAR_DIR=${VAR_DIR:-/var/lib/karaf}

LOG_DIR=${LOG_DIR:-/var/log/karaf}

install -d -m 0755 $PREFIX$LIB_DIR
install -d -m 0755 $PREFIX$BIN_DIR
cp -ra ${BUILD_DIR}/bin $PREFIX$BIN_DIR
ln -s $PREFIX$BIN_DIR/admin /usr/bin/karaf-admin
ln -s $PREFIX$BIN_DIR/client /usr/bin/karaf-client
ln -s $PREFIX$BIN_DIR/karaf /usr/bin/karaf-karaf
ln -s $PREFIX$BIN_DIR/setenv /usr/bin/karaf-setenv
ln -s $PREFIX$BIN_DIR/shell /usr/bin/karaf-shell
ln -s $PREFIX$BIN_DIR/start /usr/bin/karaf-start
ln -s $PREFIX$BIN_DIR/stop /usr/bin/karaf-stop

install -d -m 0755 $PREFIX$SHARE_DIR
cp -ra ${BUILD_DIR}/system $PREFIX$SHARE_DIR
cp -ra ${BUILD_DIR}/deploy $PREFIX$SHARE_DIR

install -d -m 0755 $PREFIX$KARAF_LIB
cp -ra ${BUILD_DIR}/lib $PREFIX$KARAF_LIB


install -d -m 0755 $PREFIX$SHARE_DIR
cp -ra ${BUILD_DIR}/etc $PREFIX$SHARE_DIR

install -d -m 0755 $PREFIX$ETC_DIR
ln -s $(echo $PREFIX${SHARE_DIR}/etc/*) $PREFIX${ETC_DIR}/

install -d -m 0755 $PREFIX$DATA_DIR
cp -ra ${BUILD_DIR}/data $PREFIX$VAR_DIR
