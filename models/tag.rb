class Tag

  attr_accessor :id, :category

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @category = options['category']
  end

  def save()
    sql = 'INSERT INTO tags (category)
    VALUES ($1) RETURNING *'
    values = [@category]
    @id = SqlRunner.run( sql, values ).first['id'].to_i
  end

  def self.all()
    sql = 'SELECT * FROM tags'
    result = SqlRunner.run( sql )
    return result.map{ |hash| Tag.new( hash ) }
  end

  def self.find( id )
    sql = 'SELECT * FROM tags WHERE id = $1'
    values = [id]
    result = SqlRunner.run( sql, values ).first
    return Tag.new( result )
  end

  def self.delete_all()
    sql = 'DELETE FROM tags'
    SqlRunner.run( sql )
  end

  def delete()
    sql = 'DELETE * FROM tags WHERE id = $1'
    values = [@id]
    SqlRunner.run( sql, values )
  end

end
