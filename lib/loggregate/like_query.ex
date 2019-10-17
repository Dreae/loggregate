defmodule Loggregate.LikeQuery do
  def like_sanitize(value) when is_binary(value) do
    String.replace(value, ~r/([\%_])/, "\\\\\\1")
  end
end
