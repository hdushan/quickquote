class Insurance
    include DataMapper::Resource
    
    property :id,             Serial
    property :userid,         String,   :required => true,  :format => :email_address
    property :quote,          Text,     :required => true
    property :createdtime,    DateTime, :required => true
    property :updatedtime,    DateTime, :required => true
    
    belongs_to :user
end