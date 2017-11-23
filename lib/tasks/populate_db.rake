task :create_categories => :environment do
  puts 'create categories'

  i = 0
  5.times do |n|
    category = Category.new({
                                :name => "Category name ##{n+1}",
                                :alias => "category-#{n+1}",
                            })
    i += 1 if category.save
  end

  puts "#{i} categories created"
end

task :create_items => :create_categories do
  puts 'create items'

  i = 0
  Category.where(:alias => 'category-1'..'category-5').find_each do |category|
    5.times do |n|
      item = Item.new({
                          :category => category,
                          :name => "Item ##{i}",
                          :price => rand(9999),
                          :description => ''
                      })
      i += 1 if item.save
    end
  end

  puts "#{i} items created"
end

task :populate_db => :create_items do
  puts 'populate db'
end
