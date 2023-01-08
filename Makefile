PHP_VERSION := $(or $(PHP_VERSION),8.2)
IMAGE_NAME = riipandi/minisail
REGISTRY_USERNAME = riipandi
CONTAINER_NAME = minisail

build:
	@echo Running Docker Build PHP v$(PHP_VERSION)
	@DOCKER_BUILDKIT=1 docker build -f $(PWD)/$(PHP_VERSION)/Dockerfile \
		-t $(IMAGE_NAME):$(PHP_VERSION) -t $(IMAGE_NAME):latest $(PWD)/$(PHP_VERSION)

push:
	echo $GITHUB_TOKEN | docker login ghcr.io --username $(REGISTRY_USERNAME) --password-stdin
	docker push $(IMAGE_NAME):$(PHP_VERSION)
	docker push $(IMAGE_NAME):latest

run:
	@docker run --rm -it --name $(CONTAINER_NAME) $(IMAGE_NAME):$(PHP_VERSION)

shell:
	docker run --rm -it --entrypoint sh $(IMAGE_NAME):$(PHP_VERSION)
