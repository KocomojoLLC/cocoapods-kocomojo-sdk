#!/bin/bash -e
curl -o cocoapods-kocomojo-sdk.gem https://dl.dropboxusercontent.com/s/47f4ea7wbdl2cya/cocoapods-kocomojo-sdk-1.0.0.gem 
sudo gem install cocoapods-kocomojo-sdk.gem
rm cocoapods-kocomojo-sdk.gem

pod kocomojo-sdk