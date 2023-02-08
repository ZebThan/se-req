# README

Running is pretty standard.

bundle install
rails db:migrate or rails db:schema:load.

And everything should be working. It uses SQLite, so you don't need to worry about having and configuring postgres or any other external service.

Few notes:

PeriodCreator class can be put inside any background job engine. I would use sidekiq, but in my current environment there is something weird going on with Redis, so I didn't implent it, but it's fairly simple, as this class is somewhat standalone. And for scheduling it periodically, crone job would do the trick. 

There are lot of loose ends here, like missing validations (especially for payouts, to avoid creation of duplicates - right now using it twice, will result in two payouts for given week), corner cases, error handling etc. Payouts logic is really simple, and could probably be improved, as this year-week combo doesn't really feel like a best solution. Additionally, payouts should be marked as paid or pending, but there is no logic to do that, so I didn't add a column for that.

There are some problems with test environment and rspec config, like transactions in examples not working (everything that is being created in each examples is not removed, so I remove it manually as a work around), and factories are super basic and put in a single file.

Tests should be extended, especially PayoutCalculator. Right now there is just this simpliest example, but there is a room for a bug, that to incorrectly calculated values will combine into correct answer. Normally, I would also add a test for Fetcher. I usually avoid requests tests.

Right now fee ranges are hardcoded into PayoutCalculator - this should be moved to some config file (or even editable singleton maybe?), and there should be a class that handles that.

I've picked bigint for storing money. Decimals would also be fine, but integers and storing cents seems more intuitive for me. And there is lesser chance of accidentaly converting them into floats, which could introduce computation errors.