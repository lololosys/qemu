#!/usr/local/bin/bash
#
# Copyright (C) 2008 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# This script is used to transform the dependency files generated by GCC
# For example, a typical .d file will have a line like:
#
#    source.o: /full/path/to/source.c other.h headers.h
#    ...
#
# the script is used to replace 'source.o' to a full path, as in
#
#    objs/intermediates/emulator/source.o: /full/path/to/source.c other.h headers.h
#
# parameters
#
# $1: object file (full path)
# $2: source dependency file to modify (erased on success)
# $3: target source dependency file
#

# quote the object path. we change a single '.' into
# a '\.' since this will be parsed by sed.
#
OBJECT=`echo $1 | sed -e s/\\\\./\\\\\\\\./g`
#echo OBJECT=$OBJECT

OBJ_NAME=`basename $OBJECT`
#echo OBJ_NAME=$OBJ_NAME

# we replace $OBJ_NAME with $OBJECT only if $OBJ_NAME starts the line
# that's because some versions of GCC (e.g. 4.2.3) already produce
# a correct dependency line with the full path to the object file.
# In this case, we don't want to touch anything
#
cat $2 | sed -e s%^$OBJ_NAME%$OBJECT%g > $3 && rm -f $2



