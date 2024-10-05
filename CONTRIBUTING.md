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
image works locally first. After making changes to the ``Dockerfile``, you can
build your image with:

```bash
docker build -t tiacsys/readourdocs-docker-images:local .
```

This will take quite a long time, mostly due to LaTeX dependencies. The
resulting image will be at least around 12GB.

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
docker builder prune --all --force
```

Releases
--------

These images are all built for our [GitHub Docker registry](
https://github.com/orgs/tiacsys/packages/container/package/readourdocs-docker-images).
The automated build rules include pattern matching on Git tags. We follow
[calendar versioning](https://calver.org/).
