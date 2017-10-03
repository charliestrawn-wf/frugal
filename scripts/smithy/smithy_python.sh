#!/usr/bin/env bash
set -e

virtualenv -p /usr/bin/python /tmp/frugal
source /tmp/frugal/bin/activate
pip install -U pip
make -C $FRUGAL_HOME/lib/python xunit-py2

# Write dependencies out so that RM is able to track them
# The name of this file is hard coded into Rosie and RM console
pip freeze > $SMITHY_ROOT/python2_pip_deps.txt
$FRUGAL_HOME/scripts/smithy/codecov.sh $FRUGAL_HOME/lib/python/unit_tests_py2.xml python_two
deactivate

virtualenv -p /usr/bin/python3.5 /tmp/frugal-py3
source /tmp/frugal-py3/bin/activate
pip install -U pip
make -C $FUGAL_HOME/lib/python xunit-py3

# RM deps again
pip freeze > $SMITHY_ROOT/python3_pip_deps.txt

# get coverage report in correct format
coverage xml
mv $FRUGAL_HOME/lib/python/coverage.xml $FRUGAL_HOME/lib/python/coverage_py3.xml
$FRUGAL_HOME/scripts/smithy/codecov.sh $FRUGAL_HOME/lib/python/coverage_py3.xml python_three

deactivate

make install
mv dist/frugal-*.tar.gz $SMITHY_ROOT