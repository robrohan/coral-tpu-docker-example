
build:
	docker build -t tputest .

##################
# Things I didn't need, but have heard you may need:
##################
#-v /var/run/docker.sock:/var/run/docker.sock 
#-v /usr/share/tpu/:/usr/share/tpu/
#-v /lib/libtpu.so:/lib/libtpu.so
#-e TPU_NAME=tpu_name
#-e TF_CPP_MIN_LOG_LEVEL=0
#-e XRT_TPU_CONFIG="localservice;0;localhost:51011"
#-e TF_XLA_FLAGS=--tf_xla_enable_xla_devices
##################
# "Priviledged" isn't a great idea. You might have a play with
# the above which might make the priviledged not needed
run:
	docker run --rm \
	-v /dev:/dev \
	--privileged \
	tputest
