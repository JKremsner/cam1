FROM resin/raspberrypi3-node:6

RUN apt-get update && apt-get install -yq libraspberrypi-bin

RUN git clone https://github.com/FFmpeg/FFmpeg.git
RUN cd FFmpeg
RUN sudo ./configure --arch=armel --target-os=linux --enable-gpl --enable-omx --enable-omx-rpi --enable-nonfree
RUN sudo make -j4
RUN sudo make install

WORKDIR usr/src/app

COPY package.json ./
RUN JOBS=MAX npm i --production

COPY . ./

CMD npm start