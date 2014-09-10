class User
    include DataMapper::Resource
    include BCrypt
    
    property :username, String,     :key => true,     :required => true, :format => :email_address
    property :password, BCryptHash, :required => true, :length => 4..255
    property :name,     String,     :required => true
    property :role,     Enum[:admin, :user], :default => :user,     :required => true
    
    has n, :policies
    
    def authenticate(attempted_password)
      if self.password == attempted_password
        true
      else
        false
      end
    end
    
end