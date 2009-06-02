# spec/factory.rb
require 'active_record'
require 'active_record/fixtures'
require 'faker'

module Factory
  def self.included(base)
    base.extend(self)
  end

  def build_valid(params = {})
      obj = new(valid_hash(params))
      obj.save
      obj
  end

  def build_valid!(params = {})
    obj = build_valid(params)
    obj.save!
    obj
  end

  def valid_hash(params = {})
    if self.respond_to? "builder_#{self.name.underscore}"
      self.send("builder_#{self.name.underscore}", params)
    else
      fixture = "#{RAILS_ROOT}/test/fixtures/" + self.name.pluralize.underscore
      raise "There are no default data from #{fixture}[.yml|.csv]" unless File.exists?("#{fixture}.csv") or File.exists?("#{fixture}.yml")
      h = Fixtures.new(self.connection, self.name.tableize, self.name, "#{fixture}").first[1].to_hash
      h.delete_if { |k,v| %w(id created_at updated_at moduser_id).include? k }
      fake_hash(h).merge(params)
    end
  end

  def invalid_hash(params = {})
    valid_hash(params).keys.inject({}) { |h,k| h[k] = nil; h}
  end

  def builder_prizetype(params)
      { :name => 'Reconocimiento'
      }.merge(params)
  end

  def fake_hash(h)
    h.keys.each do |k| 
      if h[k].is_a? String and h[k].to_i == 0
        case k.to_s
        when 'name'          then h[k] = Faker::Lorem.words.join(' ')
        when 'description'   then h[k] = Faker::Lorem.paragraph
        when 'email'         then h[k] = Faker::Internet.email
        when /ip_addr/       then h[k] = '127.10.0.1'
        else                 h[k] = Faker::Lorem.words.join(' ')
        end
      elsif h[k].is_a? Integer and k !~ /_id$/
        h[k] = rand(100)
      elsif h[k].is_a? Float
        h[k] = ("%.2f" % (rand(100-10000)/rand(20).to_f))
      end
    end  
    h
  end
end

ActiveRecord::Base.class_eval do
  include Factory
end
