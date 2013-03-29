require_relative '../../db/config'

class Legislator < ActiveRecord::Base
  attr_accessible :first_name, :middle_name, :last_name, :name_suffix, 
                  :nickname, :district, :in_office, :gender, :phone,
                  :fax, :website, :webform, :congress_office, :bioguide_id,
                  :votesmart_id, :fec_id, :govtrack_id, :crp_id, :twitter_id,
                  :congresspedia_url, :youtube_url, :facebook_id, :official_rss,
                  :senate_class, :birthdate

   belongs_to :political_party

end
