# How to Contribute

These are the build container images that we use to build our documentation.
They include all of the dependencies we require, and are a method of isolating
the build processes from the rest of our infrastructure.

If you are interested in contributing to the development of our build container
images, you can help in one of two ways:

If you would like to fix a bug or add a feature to our build images, see
**Testing Locally** for more information on how to build and test these images.

## Testing Locally

If you'd like to add a feature to any of the images, you'll need to verify the
image works locally first. To build multi-platform images, you first need to
make sure that your [Docker environment is set up to support it](
https://docs.docker.com/build/building/multi-platform/#prerequisites),
e.g. QEMU and a custom builder with self contained containerd image store.
To create such a custom builder, use the ``docker buildx create`` command:

```bash
docker buildx create --name rod-ctn-builder --driver docker-container \
                     --bootstrap --use
```

After making changes to the ``Dockerfile``, you can build your image with:

```bash
docker buildx build --tag tiacsys/readourdocs-docker-images:local \
                    --platform linux/amd64,linux/arm/v7 \
                    --builder rod-ctn-builder --load .
```

**ERROR: docker exporter does not currently support exporting manifest lists**

Unfortunately, it is impossible to run that multi-platform image as local
container. Container images with support for multiple architectures are part of
the [OCI specification](
https://github.com/opencontainers/image-spec/blob/main/image-index.md) and
Docker supports creating these as well. The image index (more commonly referred
to as the image manifest) contains some metadata about the image itself and an
array of actual manifests which specify the platform and the image layer
references. Docker supports creating these but only through the experimental
new builder, *buildx*.

Buildx has some nice new features like support for better caching between
images as well as cleaner output during builds. However, it runs completely
independently of your standard local docker registry. If you run ``docker ps``,
you’ll see a buildx builder running as a container on your local machine. This
is a virtual builder that we created using ``docker buildx create``.

**Simple build for native platform**

```bash
docker build --tag tiacsys/readourdocs-docker-images:local .
```

This will take quite a long time, mostly due to LaTeX dependencies and required
rebuilds of components from source code for different platforms. The resulting
images will be at least around 17GB.

Once your image is built, you can test your image locally by running a shell in
a container using your new image:

```bash
docker run --rm -t -i tiacsys/readourdocs-docker-images:local
```

This will put you into the root path in the container, as the ``docs`` user.
From here you can head to your home path (``cd ~docs``) and run normal
Python/Sphinx/etc operations to see if your changes have worked. For example:

```bash
cd ~docs
git clone https://github.com/readthedocs/tutorial-template.git
cd tutorial-template
```

```bash
pip install --upgrade pip setuptools
pip install --requirement docs/requirements.txt
pip install .
```

```bash
make -C docs html latexpdf
```

The locally created Docker image for tests and the Docker Builder cache can be
completely deleted at any time with:

```bash
docker image rm tiacsys/readourdocs-docker-images:local
docker buildx rm rod-ctn-builder
docker buildx prune --all --force
docker builder prune --all --force
```

Releases
--------

These images are all built for our [GitHub Docker registry](
https://github.com/orgs/tiacsys/packages/container/package/readourdocs-docker-images).
The automated build rules include pattern matching on Git tags. We follow
[calendar versioning](https://calver.org/).
