FROM ruby:3.1

RUN gem sources --remove https://rubygems.org/ \
    && gem sources --add https://gems.ruby-china.com/ \
    && gem install bundler -v 2.3.18

WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY . /myapp
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 9292

# Configure the main process to run when running the image
CMD ["bundle", "exec", "rackup"]
