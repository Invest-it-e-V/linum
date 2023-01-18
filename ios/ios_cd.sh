#!/bin/bash

cd ./ios

gem install bundler:1.17.2
bundle install

openssl aes-256-cbc -d -in .encrypted -k $AUTH_KEY_ENCRYPTION_KEY >> ./AuthKey.p8

echo $CERTS_PRIVATE_KEY > ./CertsPrivateKey
chmod 400 ./CertsPrivateKey

flutter build ios --release --no-codesign

export GIT_TERMINAL_PROMPT=1

cd ./ios

if [$1 -eq "release"]
then
  bundle exec fastlane release
else
  bundle exec fastlane beta
fi