defmodule RobotSimulator do
  defguard is_direction(direction) when direction in [:north, :east, :south, :west]
  defguard is_position(x, y) when is_integer(x) and is_integer(y)

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0})
  def create(direction, position = {x, y}) when is_direction(direction) and is_position(x, y) do
    {direction, position}
  end
  def create(direction, _position) when is_direction(direction), do: {:error, "invalid position"}
  def create(_direction, _position = {x, y}) when is_position(x, y), do: {:error, "invalid direction"}
  def create(_, _), do: {:error, "invalid position and direction"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    case invalid_intructions?(instructions) do
      true -> {:error, "invalid instruction"}
      false -> String.graphemes(instructions)
               |> Enum.reduce(robot, fn command, robot -> simulate_command(command, robot) end)
    end
  end

  defp invalid_intructions?(instructions) do
    String.match?(instructions, ~r/[^ALR]/)
  end

  defp simulate_command(command, robot) do
    case {direction(robot), command} do
      {:north, "L"} -> create(:west, position(robot))
      {:north, "R"} -> create(:east, position(robot))
      {:north, "A"} ->
        {x, y} = position(robot)
        create(:north, {x, y + 1})

      {:east, "L"} -> create(:north, position(robot))
      {:east, "R"} -> create(:south, position(robot))
      {:east, "A"} ->
        {x, y} = position(robot)
        create(:east, {x + 1, y})

      {:south, "L"} -> create(:east, position(robot))
      {:south, "R"} -> create(:west, position(robot))
      {:south, "A"} ->
        {x, y} = position(robot)
        create(:south, {x, y - 1})

      {:west, "L"} -> create(:south, position(robot))
      {:west, "R"} -> create(:north, position(robot))
      {:west, "A"} ->
        {x, y} = position(robot)
        create(:west, {x - 1, y})
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction({direction, _position}), do: direction

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position({_direction, position}), do: position
end
