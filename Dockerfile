from python:3.8

COPY . .

USER root
RUN apt update && \
	apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev

RUN echo "deb https://packages.cloud.google.com/apt coral-edgetpu-stable main" | tee /etc/apt/sources.list.d/coral-edgetpu.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

RUN apt update && \
	apt install -y libedgetpu1-std

RUN python -m pip install --extra-index-url https://google-coral.github.io/py-repo/ pycoral~=2.0

RUN pip install -r requirements.txt

CMD ["python", "classify_image.py", "--model", "test_data/mobilenet_v2_1.0_224_inat_bird_quant_edgetpu.tflite", "--labels", "test_data/inat_bird_labels.txt", "--input", "test_data/parrot.jpg"]