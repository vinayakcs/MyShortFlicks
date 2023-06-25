module Discoverable
 extend ActiveSupport::Concern

 included do
  def self.get_trending(params,normalize_power )
    order(Arel.sql("power((("+ params.map {|param| "#{param}"}.join('+')+")/(current_timestamp-#{self.table_name}.created_at)),#{normalize_power}) desc"))
  end

  def self.get_most_interacted(params)
   order(Arel.sql("("+params.map {|param| "#{param}"}.join(',')+") desc"))
  end
 end

end
