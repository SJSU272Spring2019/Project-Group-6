FROM golang:1.12
RUN mkdir /fashion
ADD . /fashion/
WORKDIR /fashion
ENV GOPATH /fashion
RUN cd /fashion; go install fashion
CMD ["/fashion/bin/fashion"]                         
