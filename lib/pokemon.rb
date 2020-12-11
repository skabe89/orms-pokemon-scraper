class Pokemon
    attr_accessor :name, :type, :id, :db

    def initialize(id:  nil, name:, type:, db:)
        self.name = name
        self.type = type
        self.id = id
        @db = db
    end

    def self.save(name, type, db)
        sql = <<-SQL
        INSERT INTO pokemon
        (name, type)
        VALUES (?, ?)
        SQL

        db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
        SELECT * FROM pokemon
        WHERE id = ?
        LIMIT 1
        SQL

        pokemon = db.execute(sql, id).find{|row| row[0] = id}
        Pokemon.new(id: id, name: pokemon[1], type: pokemon[2], db: db)
    end
end
