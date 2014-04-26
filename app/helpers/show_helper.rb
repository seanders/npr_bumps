module ShowHelper
  def filter!(collection)
    if params.has_key?(:date)
      collection.where(date: date)
    end
  end
end
