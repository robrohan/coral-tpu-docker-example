# TPU in Docker test

Basic example of how to use a Coral TPU from within docker. None of the code here is owned by me (see classify_image.py file). This is just the simplest thing I could get working to test if a TPU was usable from within a docker container.

## Running

Follow the [installation instructions](https://coral.ai/docs/) to get the TPU working on the host system. Then

```
make build
```

```
make run
```

Should yield:

```
docker run --rm \
-v /dev:/dev \
--privileged \
tputest
classify_image.py:79: DeprecationWarning: ANTIALIAS is deprecated and will be removed in Pillow 10 (2023-07-01). Use Resampling.LANCZOS instead.
  image = Image.open(args.input).convert('RGB').resize(size, Image.ANTIALIAS)
----INFERENCE TIME----
Note: The first inference on Edge TPU is slow because it includes loading the model into Edge TPU memory.
13.0ms
4.5ms
4.5ms
4.6ms
4.6ms
-------RESULTS--------
Ara macao (Scarlet Macaw): 0.75781
```

## Setup on the Host

Your best bet is to follow the steps on the [Coral home page](https://coral.ai/docs/). But I got it working with the following ansible tasks

```
- name: add the TPU source
  become: true
  ansible.builtin.shell: |
    echo "deb https://packages.cloud.google.com/apt coral-edgetpu-stable main" | sudo tee /etc/apt/sources.list.d/coral-edgetpu.list
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

- name: install c libs
  become: true
  ansible.builtin.apt:
    pkg:
      - libedgetpu1-std
    state: present
    update_cache: true
```
