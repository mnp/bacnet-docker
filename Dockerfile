FROM ubuntu:18.04
# Alpine preferred but glibc is needed and popular workarounds don't do enough.

ADD https://astuteinternet.dl.sourceforge.net/project/bacnet/bacnet-stack/bacnet-stack-0.8.6/bacnet-stack-0.8.6.tgz .
COPY bacnet-help /usr/local/bin

RUN apt-get update && apt-get -y install build-essential \
	&& tar zxf bacnet-stack-0.8.6.tgz \
	&& cd bacnet-stack-0.8.6 \
	&& make \
	&& rm -f bin/*.txt bin/*.bat \
        && mv bin/* /usr/local/bin \
        && chmod a+x /usr/local/bin/bacnet-help \
	&& cd / \
        && rm -rf /bacnet* \
	&& apt-get -y remove build-essential \
        && apt-get -y autoremove \
	&& apt-get -y autoclean

CMD ["bacnet-help"]
