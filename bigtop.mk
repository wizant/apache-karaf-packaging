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

MAINTAINER_NAME=Alexandru Zbarcea
MAINTAINER_EMAIL=zbarcea.a@gmail.com

# KARAF
KARAF_NAME=karaf
KARAF_RELNOTES_NAME=Karaf User Experience
KARAF_PKG_NAME=apache-karaf
KARAF_BASE_VERSION=2.3.0
KARAF_PKG_VERSION=2.3.0
KARAF_RELEASE_VERSION=1
KARAF_TARBALL_DST=apache-$(KARAF_NAME)-$(KARAF_BASE_VERSION).tar.gz
KARAF_TARBALL_SRC=apache-$(KARAF_NAME)-$(KARAF_BASE_VERSION)-src.tar.gz
KARAF_DOWNLOAD_PATH=/karaf/$(KARAF_BASE_VERSION)
KARAF_SITE=$(APACHE_MIRROR)$(KARAF_DOWNLOAD_PATH)
KARAF_ARCHIVE=$(APACHE_ARCHIVE)$(KARAF_DOWNLOAD_PATH)
$(eval $(call PACKAGE,karaf,KARAF))
