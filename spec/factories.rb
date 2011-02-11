require 'spec_helper'

# This will guess the User class

Factory.define :user do |f|
    f.email 'John@doe.com'
    f.password  'Doe111'
end