class Pokemon

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?)
    SQL

    db.execute(sql, name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT )
      SQL

    DB[:conn].execute(sql)
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT *
      FROM pokemon
      WHERE id = ?
    SQL

    params = db.execute(sql, id)[0]
    self.new(id: params[0], name: params[1], type: params[2], hp: params[3], db: db)
  end

  def self.all(db)
    sql = "SELECT * FROM pokemon"
    db.execute(sql)
  end

  attr_accessor :name, :type, :db, :hp
  attr_reader :id

  def initialize(name:, type:, db:, id: nil, hp: 60)
    @name = name
    @type = type
    @db = db
    @id = id
    @hp = hp
  end

  def save(db)
    if self.id
      self.update(db)
    else
      sql = <<-SQL
        INSERT INTO pokemon (name, type)
        VALUES (?, ?)
        SQL

      db.execute(sql, self.name, self.type)
      @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end
  end

  def update(db)
    sql = "UPDATE pokemon SET name = ?, type = ?, hp = ? WHERE id = ?"
    db.execute(sql, self.name, self.type, self.hp, self.id)
  end

  def alter_hp(new_hp, db)
    self.hp = new_hp
    update(db)
  end

end
