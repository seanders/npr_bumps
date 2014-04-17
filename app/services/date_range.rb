class DateRange
  attr_reader :start_date, :end_date

  def initialize(start_date, end_date)
    @start_date = Time.strptime(start_date, "%m-%d-%Y")
    @end_date = Time.strptime(end_date, "%m-%d-%Y")
  end

  def months_in_between
    (@end_date.year * 12 + @end_date.month) - (@start_date.year * 12 + @start_date.month)
  end

end
