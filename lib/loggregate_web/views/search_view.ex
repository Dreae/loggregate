defmodule LoggregateWeb.SearchView do
  use LoggregateWeb, :view

  def format_date_time(date_time) do
    "#{date_time.month}/#{date_time.day}/#{date_time.year} #{date_time.hour}:#{date_time.minute}"
  end
end
