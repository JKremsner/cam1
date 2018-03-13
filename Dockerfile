FROM resin/raspberrypi3-node:6

RUN apt-get update && apt-get install -yq libraspberrypi-bin

RUN git clone https://github.com/FFmpeg/FFmpeg.git && cd FFmpeg && sudo ./configure --arch=armel --target-os=linux --enable-gpl --enable-omx --enable-omx-rpi --enable-nonfree && sudo make -j4 && sudo make install && cd ..

WORKDIR usr/src/app

COPY package.json ./
RUN JOBS=MAX npm i --production

COPY . ./

CMD npm start