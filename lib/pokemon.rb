class Pokemon

  attr_accessor :name, :type, :db, :id, :hp

  def initialize(attributes)
    @id = attributes[0]
    @name = attributes[1]
    @type = attributes[2]
    @hp = attributes[3]
  end

  def self.save(name, type, db)
    sql = <<-SQL
    INSERT INTO pokemon (name, type)
    VALUES (?,?)
    SQL

    db.execute(sql, name, type)
    @id = db.execute("SELECT last_insert_rowid()")[0][0]
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT * FROM pokemon WHERE id = ?
    SQL
    db.execute(sql, id).map do |pokemon|
      new_pokemon = Pokemon.new(pokemon)
    end.first
  end

  def alter_hp(new_hp, db)
    sql = <<-SQL
    UPDATE pokemon
    SET hp = ? WHERE id = ?
    SQL
    db.execute(sql, new_hp, self.id)
  end


end
