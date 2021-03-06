FROM ruby:2.4.1

RUN set -ex \
    && apt-get update \
    && apt-get -y install \
                  wget \
                  unzip \
                  fonts-ipafont \
                  --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# chrome
RUN set -ex \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update \
    && apt-get -y install \
                  google-chrome-stable \
                  google-chrome-beta \
                  --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# chrome driver
RUN set -ex \
    && CHROME_DRIVER_VERSION=`curl -s https://chromedriver.storage.googleapis.com/LATEST_RELEASE` \
       bash -c 'wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/${CHROME_DRIVER_VERSION}/chromedriver_linux64.zip' \
    && unzip /tmp/chromedriver.zip chromedriver -d /usr/bin/ \
    && chmod ugo+rx /usr/bin/chromedriver \
    && rm /tmp/chromedriver.zip

RUN gem install \
        bundler \
        selenium-webdriver \
        pry \
        pry-byebug \
        nokogiri

CMD ['bash']
