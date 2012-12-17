# Themockerpush - iPhone push notifications as a service

**TheMockerPush** aims to be easy iphone notifications pushing.
This gems is a wrapper of the [REST API provided](http://www.themockerpush.com/documentation) by [themockerpush](http://www.themockerpush.com/).

## Installation

Add this line to your application's Gemfile:

    gem 'themockerpush'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install themockerpush

## Usage

You have to set your **SECRET_KEY** and your **API_KEY** that you can get on www.themockerpush.com
And you are ready to push ! 

```rb
Themockerpush::SECRET_KEY = '00000000000000000'
Themockerpush::API_KEY = '12345'

notification = Themockerpush::Notification.new(
  :message => "Welcome", 
  :badge => "12", 
  :recipients_list => 'new_subscribers',
  :scheduled_at_date => '2012-12-31',
  :scheduled_at_time => '20:35')
notification.push
```

## License

Copyright (c) 2012 Laurent Cobos, 11Factory. See LICENSE for details.