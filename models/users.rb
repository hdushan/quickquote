class User
    include DataMapper::Resource
    
    property :id, Serial
    property :username, String, :required => true, :format => :email_address
    property :password, String, :required => true, :length => 4..255
    property :role,     String, :required => true, :default => "USER"
    
end