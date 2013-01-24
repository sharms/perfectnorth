module JsonCompare
  def json_eql_object(body, obj)
      json_hash = JSON.parse(body)
      json_hash.keys.each do |key|
        if obj.send(key).instance_of? ActiveSupport::TimeWithZone
          json_hash[key].should eql(obj.send(key).to_json[1 .. -2])
        else
          json_hash[key].should eql(obj.send(key))
        end
      end
  end
end

