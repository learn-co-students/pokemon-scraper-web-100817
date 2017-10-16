class Pokemon

 attr_accessor :name, :type, :db, :id

 def initialize(id: nil, name: 'null', type: 'nil', db: 'nil')
    @name = name
    @type = type
    @db = db
    @id = id


 end

 def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)",name, type)
  end

 def self.find(id, db)
    sql = "SELECT * FROM pokemon WHERE id = ?"
        result = (db.execute(sql, id)).flatten
        new_pokemon = Pokemon.new(id:result[0], name:result[1], type:result[2])
        new_pokemon

     end


end
