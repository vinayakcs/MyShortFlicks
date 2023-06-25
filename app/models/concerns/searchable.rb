module Searchable
 extend ActiveSupport::Concern

 included do
  def self.db_search(query, join,searchParams )
    where(query.split(/\s+/).map do |word|
      '(' + searchParams.map { |col| "#{col} LIKE #{sanitize('%' + word.to_s + '%')}" }.join(' OR ') + ')'
    end.join(" #{join} "))
  end
 end

end
