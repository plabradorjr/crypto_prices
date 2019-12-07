class CryptoPrices::Crypto

  attr_accessor :name, :price, :p_change, :volume, :m_cap

  @@all = []

  def initialize(crypto_hash)
    crypto_hash.each do |k, v|
      self.send("#{k}=", v)
    end
    @@all << self
  end

  def self.create_objects_from_array(crypto_array)
    crypto_array.each do |crypto_hash|
      CryptoPrices::Crypto.new(crypto_hash)
    end
  end

  def self.all
    @@all
  end

  def self.clear_all
    @@all = []
  end

end
