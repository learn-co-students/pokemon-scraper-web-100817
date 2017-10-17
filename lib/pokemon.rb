require "pry"
class Pokemon

  attr_accessor :name, :type, :db, :hp
  attr_reader :id

  def initialize(id:, name:, type:, db:, hp: 60)
    @id = id
    @name = name
    @type = type
    @db = db
    @hp = hp
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?,?);
    SQL
    db.execute(sql, name, type)
    #id = db.execute("SELECT last_insert_rowid() FROM pokemon;")
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT * FROM pokemon WHERE pokemon.id = ?;
    SQL
    poke_arr = db.execute(sql, id).first
    pokemon = Pokemon.new(id: poke_arr[0], name: poke_arr[1], type: poke_arr[2], db: db, hp: poke_arr[3])
  end

  def alter_hp(hp, db)
    sql = <<-SQL
       UPDATE pokemon SET hp = ? WHERE id = ?;
    SQL

    db.execute(sql, hp, self.id)
    #binding.pry
  end


end
