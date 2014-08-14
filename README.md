Spree Extra Promotion Coupons
==========================

#### The current master branch uses Spree 2-2-stable

This extension includes some of the coupons that I have already develop
for some sites the list about coupon codes are:

#### Promotion coupon for product with option values

This means that you can apply for example a discount to all the products
that have a specific option values if you know a little about Spree you
know that an option value can be the size(small, large, extra large,
etc) or a color also can be an option value maybe for women or men and now you can give a discount to
all the products that include one of those option values that you select
from the admin section

#### New calculator action to set a price for products promotion

Now if you select this new action type 'Set a price for the product' now
if the rules for the coupon apply for a product now you can specify the
exact price you wan to offer that product or those products

#### If you want to how you can use it take a look at this video:

<iframe width="560" height="315" src="//www.youtube.com/embed/1syikOrPDtk" frameborder="0" allowfullscreen></iframe>

Installation
------------

Add spree_extra_promotion_coupons to your Gemfile:

```ruby
gem 'spree_extra_promotion_coupons'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_extra_promotion_coupons:install
```

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

```shell
bundle
bundle exec rake test_app
bundle exec rspec spec
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_extra_promotion_coupons/factories'
```

Copyright (c) 2014 [name of extension creator], released under the New BSD License
