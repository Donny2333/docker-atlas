docker rm -f java8
docker run -d \
	-it \
	-p 21000:21000 \
	-p 8983:8983 \
	-p 61510:61510 \
	--name java8 \
	-v $(pwd)/home:/root \
	--privileged=true \
	openjdk:8 \
	bash -c "/root/start.sh; bash"