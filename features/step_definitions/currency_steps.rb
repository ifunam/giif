Given /^a currency with valid params$/ do
  @currency = Currency.new(:name => 'World currency')
end
When /^I save currency it will validate params$/ do
  if @currency.valid? then @currency.save end
  @currency.valid? == true
end
Then /^currency will saved$/ do
  @currency.save
end
