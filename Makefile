.PHONY: docs test

help:
	@echo "  env         create a development environment using virtualenv"
	@echo "  clean       remove unwanted stuff"
	@echo "  lint        check style with flake8"
	@echo "  test        run tests"
	@echo "  build       generate source and wheel dist files"
	@echo "  upload      generate source and wheel dist files and upload them"

env:
	sudo easy_install pip && \
	pip install virtualenv && \
	virtualenv env && \
	. env/bin/activate && \
	pip install .

clean:
	rm -fr build
	rm -fr dist
	find . -name '*.pyc' -exec rm -f {} \;
	find . -name '*.pyo' -exec rm -f {} \;
	find . -name '*~' -exec rm -f {} \;

lint:
	flake8 twitter > violations.flake8.txt

test:
	python run_tests.py

build: clean
	python setup.py sdist upload
	python setup.py bdist_wheel upload

upload: clean
	python setup.py sdist upload
	python setup.py bdist_wheel upload
