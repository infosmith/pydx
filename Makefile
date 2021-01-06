build: clean
	# builds source and wheel package
	python setup.py sdist
	python setup.py bdist_wheel
	ls -l dist

clean: clean-build clean-bytecode

clean-build:
	# remove build artifacts
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

clean-bytecode:
	# remove common bytecode clutter
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

dependencies:
	# pin project dependencies
	find ./requirements/*.in | xargs -n 1 pip-compile --generate-hashes --allow-unsafe

environment:
	# Setup and activate Python environment.
	echo "Create and activate Python environment using conda, pipenv+pyenv, or poetry."

lint-free:
	# Brush off the lint from staged files.
	pre-commit run --all

local: environment
	# Bootstrap the development environment.
	pre-commit autoupdate
	pre-commit install
	pre-commit install --install-hooks

release: build
	# package and upload a release
	twine upload dist/*
