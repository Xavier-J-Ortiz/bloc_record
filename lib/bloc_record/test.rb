def order(*args)
  args.map! {|arg| arg.is_a?(Hash) ? format_hash_to_order_SQL(arg) : arg} 
  if args.count > 1
    order = args.join(", ")
  else
    order = args.first.to_s
  end
  order 
end

def format_hash_to_order_SQL arg
  arg.map{|k, v| "#{k} #{v.to_s.upcase}"}.join(", ")
end

=begin
puts order("harry ASC", "potter DESC").to_s
puts order("harry ASC, potter DESC").to_s
puts order(:harry, :potter).to_s
puts order(harry: :desc, potter: :asc).to_s
puts order(:harry, potter: :asc).to_s
puts order(:harry, potter: :asc, dumbledore: :desc).to_s
test_array = order(:harry, potter: :asc, dumbledore: :desc)
puts "#{test_array}"
=end

@table = "article"
def join(*args)
  if args.count > 1
    joins = args.map { |arg| "INNER JOIN #{arg} ON #{arg}.#{@table}_id = #{@table}.id"}.join(" ")
  else
    case args.first
    when Hash
      joins = args.map {|arg| nested_join(arg) }.join(" ")
    end
  end
  joins
end

def nested_join arg
  arg.map {|k, v| "INNER JOIN #{k} ON #{k}.#{@table}_id = #{@table}.id\nINNER JOIN #{v} ON #{v}.#{k}_id = #{k}.id"}.join(" ")
end

puts join(:harry, :potter).to_s
puts join(comment: :guest).to_s
