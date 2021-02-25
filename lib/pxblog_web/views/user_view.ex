defmodule PxblogWeb.UserView do
  use PxblogWeb, :view
  import Logger

  def debug_value(value) do
    Logger.debug("#{inspect(value)}")
    value
  end

  def debug_value_2(value, value_2) do
    Logger.debug("#{inspect(value_2)}")
    value
  end

  def roles_for_select(roles) do
    roles
    |> Enum.map(&["#{&1.name}": &1.id])
    |> List.flatten
  end
end
