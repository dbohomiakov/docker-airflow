default: all

all: build tag push

build:
	docker build -t airflow .

run:
	docker run --env-file=.env airflow

tag:
	docker tag airflow:latest

push:
	docker push somewhere:latest

isort:
	isort -rc --check-only .

flake:
	flake8 .

clean:
	@rm -rf `find . -name __pycache__`
	@rm -f `find . -type f -name '*.py[co]' `
	@rm -f `find . -type f -name '*~' `
	@rm -f `find . -type f -name '.*~' `
	@rm -f `find . -type f -name '@*' `
	@rm -f `find . -type f -name '#*#' `
	@rm -f `find . -type f -name '*.orig' `
	@rm -f `find . -type f -name '*.rej' `
	@rm -f .coverage
	@rm -rf build
	@rm -rf cover
	@rm -f .flake

.PHONY: all
