module PaperTrail
  module UuidHelper

    def self.included(base)
      base.primary_key = 'uuid'
      base.before_create :assign_uuid
    end

    private
    def assign_uuid
      if self.uuid.blank?
        self.uuid = loop do
          uuid_based_on_timestamp = ::UUIDTools::UUID.timestamp_create().to_s.downcase
          break uuid_based_on_timestamp unless self.class.exists?(uuid: uuid_based_on_timestamp)
        end
      end
    end

  end
end