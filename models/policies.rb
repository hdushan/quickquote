class Policy
    include DataMapper::Resource
    
    property :policynum,      Serial,   :key => true
    property :type,           Enum[:car, :life],   :required => true
    property :quote,          Object,   :required => true
    property :created_at,     DateTime, :required => true,  :default => Time.now
    property :updated_at,     DateTime, :required => true,  :default => Time.now
    
    belongs_to :user
end