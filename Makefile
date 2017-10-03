THIS_REPO := github.com/Workiva/frugal
VERSION := 2.9.1

all: unit

clean:
	@rm -rf /tmp/frugal
	@rm -rf /tmp/frugal-py3

unit: clean unit-cli unit-go unit-java unit-py2 unit-py3

unit-cli:
	go test ./test -race

unit-go:
	cd lib/go && glide install && go test -v -race 

unit-java:
	mvn -f lib/java/pom.xml checkstyle:check clean verify

unit-py2:
	virtualenv -p /usr/bin/python /tmp/frugal && \
	source /tmp/frugal/bin/activate && \
	$(MAKE) -C $(PWD)/lib/python xunit-py2 &&\
	deactivate

unit-py3:
	virtualenv -p python3 /tmp/frugal-py3 && \
	source /tmp/frugal-py3/bin/activate && \
	$(MAKE) -C $(PWD)/lib/python xunit-py3 && \
	deactivate

integration: setup-it
	$(MAKE) -C $(PWD)/test/integration generate && \
	cd test/integration && \
	go run main.go --tests tests.json --outDir log

setup-it: setup-it-go setup-it-java setup-it-py2 setup-it-py3

setup-it-go:
	if [ ! -e "lib/go/glide.lock" ]; then \
    	cd lib/go && glide install ; \
	fi ; \
	rm -rf test/integration/go/testclient && \
	rm -rf test/integration/go/testserver && \
	cd test/integration/go && \
	glide install && \
	go build testclient.go && \
	go build testserver.go

setup-it-java:
	$(eval TEST_DIR = test/integration/java/frugal-integration-test)
	mvn -f lib/java/pom.xml clean package -DskipTests=true -Dsource.skip=true -Dmaven.javadoc.skip=true && \
	mv lib/java/target/frugal-$(VERSION).jar $(TEST_DIR) && \
	mvn -f $(TEST_DIR)/pom.xml clean install:install-file -Dfile=frugal-$(VERSION).jar -U -q && \
	mvn -f $(TEST_DIR)/pom.xml clean compile assembly:single -U -q

setup-it-py2:
	pip install -e "lib/python[tornado]"

setup-it-py3:
	pip3 install -e "lib/python[asyncio]"

.PHONY: \
	all \
	clean \
	unit \
	unit-cli \
	unit-go \
	unit-java \
	venv-py2 \
	venv-py3 \
	unit-py2 \
	unit-py3 \
	setup-it-go \
	setup-it-java \
	setup-it-py2 \
	setup-it-py3 \
	integration