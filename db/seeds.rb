Dir[File.join(Rails.root, 'db', 'seeds', '*seed.rb')].sort.each { |seed| load seed }
