# Default keyword to be searched for
KEYWORD=FIXED

# Builds the script before running it with the default keyword
run: build
	docker run --rm keyword-release-action $(KEYWORD)

# Uses our docker file to compile the docker image and tags it with a name
build:
	docker build --tag keyword-release-action .

# Runs the entrypoint script with the test keyword
test:
	./entrypoint.sh $(KEYWORD)
