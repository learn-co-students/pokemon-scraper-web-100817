  require "pry"

class Pokemon
  attr_accessor :name, :type, :id, :db, :hp

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
  end

  def self.find(id,db)
      pokemon_info = db.execute("SELECT * FROM pokemon WHERE id = ?", id).flatten
      Pokemon.new(id: pokemon_info[0], name: pokemon_info[1], type: pokemon_info[2], hp: pokemon_info[3], db: db,)
  end

  def initialize (id:, name:, type:, hp: nil, db:)
    @id = id
    @name = name
    @type = type
    @db = db
    @hp = hp
  end

  def alter_hp(hp,db)
    db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", hp, self.id)
  end

end
