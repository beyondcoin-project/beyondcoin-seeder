FROM ubuntu:18.04
RUN sudo apt-get update && sudo apt-get install -y build-essential libboost-essential libboost-all-dev libssl-dev
RUN sudo mkdir -p /usr/src/beyondcoin-seeder
ADD . /usr/src/beyondcoin-seeder
WORKDIR /usr/src/beyondcoin-seeder
RUN sudo make
EXPOSE 53
ENTRYPOINT ["/usr/src/beyondcoin-seeder/dnsseed"]
