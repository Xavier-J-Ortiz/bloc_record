def order(*args)
    args.map! {|arg| arg.is_a?(Hash) ? format_hash_to_SQL(arg) : arg} 
  if args.count > 1
    order = args.join(", ")
  else
    order = args.first.to_s
  end
 order 
end

def format_hash_to_SQL arg
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
