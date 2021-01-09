dependencies:
	# pin project dependencies
	find ./requirements/*.in | xargs -n 1 pip-compile --generate-hashes --allow-unsafe

