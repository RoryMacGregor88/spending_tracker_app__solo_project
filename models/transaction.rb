require_relative( '../db/sql_runner.rb' )

class Transaction

  attr_accessor :id, :date, :charge, :tag_id, :merchant_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @date = options['date'] if options['date']
    @charge = options['charge']
    @tag_id = options['tag_id']
    @merchant_id = options['merchant_id']
  end

  def save()
    sql = 'INSERT INTO transactions (charge, tag_id, merchant_id)
    VALUES ($1, $2, $3) RETURNING *'
    values = [@charge, @tag_id, @merchant_id]
    result = SqlRunner.run( sql, values )
    @id = result.first['id'].to_i
    @date = result.first['date']
  end

  def self.all()
    sql = 'SELECT * FROM transactions'
    result = SqlRunner.run( sql )
    return result.map { |hash| Transaction.new( hash ) }
  end

  def self.delete_all()
    sql = 'DELETE FROM transactions'
    SqlRunner.run( sql )
  end

  def delete()
    sql = 'DELETE * FROM transactions WHERE id = $1'
    values = [@id]
    SqlRunner.run( sql, values )
  end

end
