# Tangerine

Tangerine is a gem that uses ActiveResource to wrap the Ooyala API. Currently in its infancy, so YMMV.

## Installation

  gem install tangerine

[Tangerine on RubyGems](http://rubygems.org/gems/tangerine)

## Usage

The following is only a proposed usage -- most of this is not yet implemented since the gem is still in development:

### Authorization with your Ooyala Account

You can find your Partner and Secret codes under the Developers area of the Backlot Account tab.

  OOYALA_CREDENTIALS = {
      :pcode => **<YOUR PCODE HERE>**,
      :signature => **<YOUR SIGNATURE HERE>**
    }
  tangerine_client = Tangerine::Backlot.new(OOYALA_CREDENTIALS)

### Queries

  tangerine_client.query(:status => 'live')

* TODO: Make certain queries a bit more like a DSL (eg: tangerine_client.live instead of tangerine_client.query(:status => 'live'))

[Ooyala Backlot Query API](http://www.ooyala.com/support/docs/backlot_api#query)

### Thumbnails

  Feature pending.

[Ooyala Backlot Thumbnail Query API](http://www.ooyala.com/support/docs/backlot_api#thumbnail)

### Attribute Updates

  Feature pending.

[Ooyala Backlot Attribute Update API](http://www.ooyala.com/support/docs/backlot_api#attribute)

### Custom Metadata

  Feature pending.

[Ooyala Custom Metadata API](http://www.ooyala.com/support/docs/backlot_api#metadata)

### Label Management

  Feature pending.

[Ooyala Label Management API](http://www.ooyala.com/support/docs/backlot_api#label)

### Player Management

  Feature pending.

[Ooyala Player Management API](http://www.ooyala.com/support/docs/backlot_api#player)

### Channel

  Feature pending.

[Ooyala Channel API](http://www.ooyala.com/support/docs/backlot_api#channel)

### Channel Set

  Feature pending.

[Ooyala Channel Set API](http://www.ooyala.com/support/docs/backlot_api#channel_set)

### Dynamic Channel

  Feature pending.

[Ooyala Dynamic Channel API](http://www.ooyala.com/support/docs/backlot_api#dynamic_channel)

### High Performance

  Feature pending.

[Ooyala High Performance API](http://www.ooyala.com/support/docs/backlot_api#high_performance)

## Contribute

The gem has an .rvmrc file, and is currently associated with ree 1.8.7 with its own [RVM](http://rvm.beginrescueend.com/) gemset.

If you don't have 'rvm_install_on_use_flag' turned on in your system/user .rvmrc file, just add the proper ree and gemset when prompted after cd'ing into the project.

[GitHub Repository](http://github.com/factorylabs/tangerine/tree/master)

## Copyright

Copyright (c) 2011 Anthony Navarre. Released under the MIT license. See LICENSE.txt for
further details.

