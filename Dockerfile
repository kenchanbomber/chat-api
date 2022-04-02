FROM ruby:2.7.5

# list update for yarn
RUN curl https://deb.nodesource.com/setup_12.x | bash && \
    curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y \
    nodejs \
    yarn \
    postgresql-client

WORKDIR /chat-api
COPY Gemfile Gemfile.lock /chat-api/

# add gems to image layer
RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]

CMD [ "rails", "s", "-b", "0.0.0.0" ]