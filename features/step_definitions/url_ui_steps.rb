def create_url(args = {})
  args.reverse_merge!(
    'Title' => 'Page',
    'URL' => 'http://example.com',
    'Seconds' => 234235
  )
  steps %{
    When I go to the page where I can add a URL
    And I fill in the following:
      | Title   | #{args['Title']}   |
      | URL     | #{args['URL']}     |
      | Seconds | #{args['Seconds']} |
  }
  if args['HTTP method']
    And %{I select "#{args['HTTP method']}" from "HTTP method"}
  end
  And %{I press "Add URL"}
end

##################################################

When /^I create a URL$/ do
  create_url
end

When /^I create the URL:$/ do |table|
  create_url(table.rows_hash)
end

When /^I create the URLs:$/ do |table|
  table.hashes.each do |args|
    create_url(args)
  end
end

Then /^I should see the URLs table:$/ do |expected_table|
  actual_table = tableish('#locations table tr', 'td,th')
  diff_tables!(actual_table, expected_table)
end

When /^I change the seconds for that URL to (\d+)$/ do |seconds|
  steps %{
    When I go to the edit page for that URL
    And I fill in the following:
      | Seconds | #{seconds} |
    And I press "Save URL"
  }
end