library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity axi_fifo is
  generic (
    ram_width : natural;
    ram_depth : natural
  );
  port (
    buf_clk : in std_logic;
    buf_rst : in std_logic;

    -- axi input interface
    in_ready : out std_logic;
    in_valid : in std_logic;
    in_data : in std_logic_vector(ram_width - 1 downto 0);

    -- axi output interface
    out_ready : in std_logic;
    out_valid : out std_logic;
    out_data : out std_logic_vector(ram_width - 1 downto 0)
  );
end axi_fifo;

architecture copy1_arch of axi_fifo is

  -- the fifo is full when the ram contains ram_depth - 1 elements
  type ram_type is array (0 to ram_depth - 1) of std_logic_vector(in_data'range);
  signal ram : ram_type;

  -- newest element at head, oldest element at tail
  subtype index_type is natural range ram_type'range;
  signal head : index_type;
  signal tail : index_type;
  signal count : index_type;
  signal head_delayed : index_type;
  signal tail_delayed : index_type;
  signal count_delayed : index_type;

  -- internal versions of entity signals with mode "out"
  signal in_ready_local : std_logic;
  signal out_valid_local : std_logic;

  -- true the clock cycle after a simultaneous read and write
  signal read_while_write_delayed : std_logic;

  -- increment or wrap the index if this transaction is valid
  function next_index(
    index : index_type;
    ready : std_logic;
    valid : std_logic) return index_type is
  begin
    if ready = '1' and valid = '1' then
      if index = index_type'high then
        return index_type'low;
      else
        return index + 1;
      end if;
    end if;

    return index;
  end function;

  -- logic for handling the head and tail signals
  procedure index_proc(
    signal clk : in std_logic;
    signal rst : in std_logic;
    signal index : inout index_type;
    signal ready : in std_logic;
    signal valid : in std_logic) is
  begin
      if rising_edge(clk) then
        if rst = '1' then
          index <= index_type'low;
        else
          index <= next_index(index, ready, valid);
        end if;
      end if;
  end procedure;

begin

  -- copy internal signals to output
  in_ready <= in_ready_local;
  out_valid <= out_valid_local;

  -- update head index on write
  proc_head : index_proc(buf_clk, buf_rst, head, in_ready_local, in_valid);

  -- update tail index on read
  proc_tail : index_proc(buf_clk, buf_rst, tail, out_ready, out_valid_local);

  -- write to and read from the ram
  proc_ram : process(buf_clk)
  begin
    if rising_edge(buf_clk) then
      ram(head) <= in_data;
      out_data <= ram(next_index(tail, out_ready, out_valid_local));
    end if;
  end process;

  -- find the number of elements in the ram
  proc_count : process(head, tail)
  begin
    if head < tail then
      count <= head - tail + ram_depth;
    else
      count <= head - tail;
    end if;
  end process;

  -- delay the count by one clock cycles
  proc_count_p1 : process(buf_clk)
  begin
    if rising_edge(buf_clk) then
      if buf_rst = '1' then
        count_delayed <= 0;
      else
        count_delayed <= count;
      end if;
    end if;
  end process;

  -- set in_ready when the ram isn't full
  proc_in_ready : process(count)
  begin
    if count < ram_depth - 1 then
      in_ready_local <= '1';
    else
      in_ready_local <= '0';
    end if;
  end process;

  -- detect simultaneous read and write operations
  proc_read_while_write_p1: process(buf_clk)
  begin
    if rising_edge(buf_clk) then
      if buf_rst = '1' then
        read_while_write_delayed <= '0';

      else
        read_while_write_delayed <= '0';
        if in_ready_local = '1' and in_valid = '1' and
          out_ready = '1' and out_valid_local = '1' then
          read_while_write_delayed <= '1';
        end if;
      end if;
    end if;
  end process;

  -- set out_valid when the ram outputs valid data
  proc_out_valid : process(count, count_delayed, read_while_write_delayed)
  begin
    out_valid_local <= '1';

    -- if the ram is empty or was empty in the prev cycle
    if count = 0 or count_delayed = 0 then
      out_valid_local <= '0';
    end if;

    -- if simultaneous read and write when almost empty
    if count = 1 and read_while_write_delayed = '1' then
      out_valid_local <= '0';
    end if;

  end process;

end architecture;
