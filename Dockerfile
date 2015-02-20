FROM rails:4.2
RUN mkdir /usr/src/atks
WORKDIR /usr/src/atks
ADD Gemfile* /usr/src/atks/
RUN bundle install

ADD . /usr/src/atks
