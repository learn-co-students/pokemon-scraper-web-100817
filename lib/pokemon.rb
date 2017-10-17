require 'pry'
class Pokemon
  attr_accessor :id,:name,:type,:db, :hp
  def initialize(name, hp=nil)
    @name = name
    @hp = hp

  end


def self.save(name,type,db,*hp)
    sql= <<-SQL
    INSERT INTO pokemon (name,type)
    VALUES (?,?)
    SQL
    db.execute(sql,name,type)
    @id = db.execute("SELECT last_insert_rowid()FROM pokemon")[0][0]
end


  def self.find(id, db)
    sql = <<-SQL
    SELECT *
    FROM pokemon
    WHERE id = ?
    SQL
    self.create(db.execute(sql, id)[0])
  end


  def self.create(row)
    new_pokemon = Pokemon.new(row[1])
    new_pokemon.id = row[0]
    new_pokemon.type = row[2]
    row.size < 4 ? new_pokemon.hp = 60 : new_pokemon.hp = row[3]
    new_pokemon
  end



  def alter_hp(hp, db)
    self.hp = hp
    sql= <<-SQL
    UPDATE pokemon SET hp = ? WHERE id = ?
    SQL
    db.execute(sql, hp, self.id)
  end


end
