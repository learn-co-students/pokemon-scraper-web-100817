require 'pry'
class Pokemon

 attr_accessor :name, :type, :db, :id

  def initialize(id:, name:, type:, db:)
    @name = name
    @type = type
    @db = db
    @id = nil
  end

  def self.save(name, type, db)
    sql = <<-SQL
    INSERT INTO pokemon(name, type)
    VALUES(?,?)
    SQL
    db.execute(sql, name, type)
    # @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT *
      FROM pokemon
      WHERE id = ?
    SQL
    pokemon_data = db.execute(sql, id).flatten
    new_pokemon = Pokemon.new(id: pokemon_data[0], name: pokemon_data[1], type: pokemon_data[2], db: db)
    new_pokemon.id = pokemon_data[0]
    new_pokemon
    # binding.pry
  end

  # def alter_hp(hp, db)
  #   sql = ("ALTER TABLE pokemon ADD COLUMN hp TEXT";)
  #   DB[:conn].execute(sql)
  # end

end
