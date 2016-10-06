defmodule DomainToIp do
  require Logger
  def main(_arg) do
    {:ok, content} = File.cwd()
    read_and_process("#{content}/csv/active-domains.csv")
    # read_and_process("active-domains.csv")
    |> Enum.map(&format_ip(&1))
    |> write_results
  end

  def read_and_process(n) do
    File.stream!('#{n}')
      |> Enum.map(&String.trim(&1, "\n"))
      |> Enum.map(&:inet_res.lookup('#{&1}', :in, :a, [{:alt_nameservers, [{{192,168,0,1}, 53}]}]))
  end

  def format_ip([]), do: "Cannot be converted"
  def format_ip([head | _]) do
    Enum.join(Tuple.to_list(head), ".")
  end

  def write_results(n) do
    {:ok, content} = File.cwd()
    file = File.open!("#{content}/csv/ips.csv", [:read, :utf8, :write])
    Enum.map(n, &IO.write(file, "#{&1} \n"))
  end
end
