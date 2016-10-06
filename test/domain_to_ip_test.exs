defmodule DomainToIpTest do
  use ExUnit.Case

  import DomainToIp, only: [read_and_process: 1, format_ip: 1]

  test "format ip with an empty list" do
    assert format_ip([])
    == "Cannot be converted"
  end

  test "format ip with a 1-elem list" do
    assert format_ip([{54,72,130,67}])
    == "54.72.130.67"
  end

  test "raw ip data" do
    assert Enum.map(["10newssandiego.com", "kayjewels.com", "cheapfairtickets.com", "googelearth.com"],
        &:inet_res.lookup('#{&1}', :in, :a, [{:alt_nameservers, [{{192,168,0,1}, 53}]}]))
    == [[{54,72,130,67}], [{51,254,28,162}], [{95,211,219,65}], [{209,126,123,12}]]
  e
end
