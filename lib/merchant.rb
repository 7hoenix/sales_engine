class Merchant
  attr_reader :id, :name, :created_at, :updated_at, :repository

  def initialize(row, repository="INSERT REPO HERE")
    @id = row[0]
    @name = row[1]
    @created_at = row[2]
    @updated_at = row[3]
    @repository = repository
  end
end

