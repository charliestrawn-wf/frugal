THIS_REPO      := github.com/Workiva/frugal
GO             := go/gen
PYTHON         := python/vanilla/gen_py
PYTHON_TORNADO := python/tornado/gen_py_tornado
PYTHON_ASYNCIO := python/asyncio/gen_py_asyncio
DART           := dart/gen-dart
JAVA           := java/frugal-integration-test/gen-java

all: generate

test: 
	@echo "hello from integration dir"

setup: setup-java

setup-java:
	mv ../../lib/java/target/frugal-$(VERSION).jar

clean:
	@-rm -rf $(GO)
	@-rm -rf $(JAVA)/v1/music/
	@-rm -rf $(PYTHON)
	@-rm -rf $(PYTHON_TORNADO)
	@-rm -rf $(PYTHON_ASYNCIO)
	@-rm -rf $(DART)

generate: clean
	find . -type f -name 'frugalTest.frugal' \
		-exec frugal -r -out $(GO) --gen go:package_prefix=$(THIS_REPO)/ {} \; \
		-exec frugal -r -out $(JAVA) --gen java:generated_annotations=undated {} \; \
		-exec frugal -r -out 'python/tornado/gen_py' --gen py {} \; \
		-exec frugal -r -out $(PYTHON_TORNADO) --gen py:tornado {} \; \
		-exec frugal -r -out $(PYTHON_ASYNCIO) --gen py:asyncio {} \; \
		-exec frugal -r -out $(DART) --gen dart:use_enums=true {} \;

gnatsd:
	gnatsd&

.PHONY: \
	all \
	clean \
	generate \
	gnatsd