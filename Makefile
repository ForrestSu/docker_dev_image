.PHONY: clean

# centos
centos7:
	docker build --target base -t sunquana/centos7:base .

# docker build --target mini -t sunquana/centos7:mini .
# docker build --target dev -t sunquana/centos7:latest .

# ubuntu
ubuntu_tesseract5:
	docker build -f Dockerfile_ubuntu --target tesseract5 -t sunquana/ubuntu:tesseract5 .
ubuntu:
	docker build -f Dockerfile_ubuntu --target dev -t sunquana/ubuntu .

## usage
# docker run -it --privileged --name tess sunquana/ubuntu:tesseract5 zsh

# archlinux
archlinux:
	docker build -f Dockerfile_archlinux  --platform linux/amd64 -t sunquana/archlinux .

## usage
# docker run -it --privileged --platform linux/amd64  --name arch archlinux/archlinux:latest bash
