FROM debian:buster

RUN apt-get update && apt-get install -y wget gnupg
RUN cd /tmp/ && wget -O key.asc "http://teharris.net/mx19repo.asc" && apt-key add key.asc && rm key.asc
RUN echo \
    "deb http://mxrepo.com/mx/repo buster main non-free" | tee /etc/apt/sources.list.d/mx.list > /dev/null

RUN apt-get update && apt-get install -y \
    libboost-dev libboost-thread-dev libboost-program-options-dev libboost-system-dev libboost-math-dev libboost-test-dev zlib1g-dev cmake g++ \
    libflatbuffers-dev \
    libboost-python-dev \
    python3-pip python-pip
ADD . /vowpal_wabbit/
WORKDIR /vowpal_wabbit/

RUN python3 setup.py install
RUN python setup.py install
