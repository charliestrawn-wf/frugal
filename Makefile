THIS_REPO := github.com/Workiva/frugal

all: unit

clean:
	@rm -rf /tmp/frugal
	@rm -rf /tmp/frugal-py3

unit: unit-python

unit-python: clean unit-py2 unit-py3

unit-py2:
	virtualenv -p /usr/bin/python /tmp/frugal && \
	source /tmp/frugal/bin/activate && \
	$(MAKE) -C $(PWD)/lib/python xunit-py2

unit-py3:
	virtualenv -p python3 /tmp/frugal-py3 && \
	source /tmp/frugal-py3/bin/activate && \
	$(MAKE) -C $(PWD)/lib/python xunit-py3

integration:
	@$(MAKE) -C test/integration test

.PHONY: \
	all \
	clean \
	unit \
	unit-py2 \
	unit-py3 \
	integration