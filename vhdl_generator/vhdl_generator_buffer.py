# This file creates an instance of the axi_fifo buffer.

def returnBuffer(sdfArch):
    buffer_import = str(
        "library ieee; \n" + 
        "use ieee.std_logic_1164.all; \n" +
        "use ieee.numeric_std.all; \n" +
        "\n"
        )
    buffer_entity = str(
        "entity axi_fifo is \n" +
        "generic (\n" + 
        "    ram_width : natural;\n" + 
        "    ram_depth : natural\n" + 
        ");\n" + 
        "port (\n" + 
        "    buf_clk : in std_logic;\n" + 
        "    buf_rst : in std_logic;\n" + 
        "\n" + 
        "    -- axi input interface\n" + 
        "    buf_in_ready : out std_logic;\n" + 
        "    buf_in_valid : in std_logic;\n" + 
        "    buf_in_data : in std_logic_vector(ram_width - 1 downto 0);\n" + 
        "\n" + 
        "    -- axi output interface\n" + 
        "    buf_out_ready : in std_logic;\n" + 
        "    buf_out_valid : out std_logic;\n" + 
        "    buf_out_data : out std_logic_vector(ram_width - 1 downto 0)\n" + 
        ");\n" + 
        "end axi_fifo;\n"
    )
    buffer_arch = str(
        "architecture " + sdfArch + " of axi_fifo is \n" +
        " \n" +
        "    -- the fifo is full when the ram contains ram_depth - 1 elements \n" +
        "    type ram_type is array (0 to ram_depth - 1) of std_logic_vector(buf_in_data'range); \n" +
        "    signal ram : ram_type; \n" +
        " \n" +
        "    -- newest element at head, oldest element at tail \n" +
        "    subtype index_type is natural range ram_type'range; \n" +
        "    signal head : index_type; \n" +
        "    signal tail : index_type; \n" +
        "    signal count : index_type; \n" +
        "    signal head_delayed : index_type; \n" +
        "    signal tail_delayed : index_type; \n" +
        "    signal count_delayed : index_type; \n" +
        " \n" +
        "    -- internal versions of entity signals with mode 'out' \n" +
        "    signal in_ready_local : std_logic; \n" +
        "    signal out_valid_local : std_logic; \n" +
        " \n" +
        "    -- true the clock cycle after a simultaneous read and write \n" +
        "    signal read_while_write_delayed : std_logic; \n" +
        " \n" +
        "    -- increment or wrap the index if this transaction is valid \n" +
        "    function next_index( \n" +
        "        index : index_type; \n" +
        "        ready : std_logic; \n" +
        "        valid : std_logic) return index_type is \n" +
        "    begin --\n" +
        "        if ready = '1' and valid = '1' then \n" +
        "        if index = index_type'high then \n" +
        "            return index_type'low; \n" +
        "        else  \n" +
        "            return index + 1; \n" +
        "        end if;\n" +
        "        end if;  \n" +
        " \n" +
        "        return index; \n" +
        "    end function; \n" +
        " \n" +
        "    -- logic for handling the head and tail signals \n" +
        "    procedure index_proc( \n" +
        "        signal clk : in std_logic; \n" +
        "        signal rst : in std_logic; \n" +
        "        signal index : inout index_type; \n" +
        "        signal ready : in std_logic; \n" +
        "        signal valid : in std_logic) is \n" +
        "    begin ---\n" +
        "        if rising_edge(clk) then \n" +
        "            if rst = '1' then \n" +
        "            index <= index_type'low; \n" +
        "            else \n" +
        "            index <= next_index(index, ready, valid); \n" +
        "            end if; \n" +
        "        end if;  \n" +
        "    end procedure; \n" +
        " \n" +
        "    begin ----\n" +
        " \n" +
        "    -- copy internal signals to output \n" +
        "    buf_in_ready <= in_ready_local; \n" +
        "    buf_out_valid <= out_valid_local; \n" +
        " \n" +
        "    -- update head index on write \n" +
        "    proc_head : index_proc(buf_clk, buf_rst, head, in_ready_local, buf_in_valid); \n" +
        " \n" +
        "    -- update tail index on read \n" +
        "    proc_tail : index_proc(buf_clk, buf_rst, tail, buf_out_ready, out_valid_local); \n" +
        " \n" +
        "    -- write to and read from the ram \n" +
        "    proc_ram : process(buf_clk) \n" +
        "    begin -----\n" +
        "        if rising_edge(buf_clk) then  \n" +
        "        ram(head) <= buf_in_data; \n" +
        "        buf_out_data <= ram(next_index(tail, buf_out_ready, out_valid_local)); \n" +
        "        end if; --\n" +
        "    end process;   \n" +
        " \n" +
        "    -- find the number of elements in the ram \n" +
        "    proc_count : process(head, tail) \n" +
        "    begin   \n" +
        "        if head < tail then \n" +
        "        count <= head - tail + ram_depth; \n" +
        "        else  \n" +
        "        count <= head - tail; \n" +
        "        end if; ---\n" +
        "    end process;  \n" +
        " \n" +
        "    -- delay the count by one clock cycles \n" +
        "    proc_count_p1 : process(buf_clk) \n" +
        "    begin   \n" +
        "        if rising_edge(buf_clk) then \n" +
        "        if buf_rst = '1' then \n" +
        "            count_delayed <= 0; \n" +
        "        else --\n" +
        "            count_delayed <= count; \n" +
        "        end if; ----\n" +
        "        end if; -----\n" +
        "    end process;  \n" +
        " \n" +
        "    -- set in_ready when the ram isn't full \n" +
        "    proc_in_ready : process(count) \n" +
        "    begin     \n" +
        "        if count < ram_depth - 1 then \n" +
        "        in_ready_local <= '1'; \n" +
        "        else \n" +
        "        in_ready_local <= '0'; \n" +
        "        end if; ------\n" +
        "    end process; --\n" +
        " \n" +
        "    -- detect simultaneous read and write operations \n" +
        "    proc_read_while_write_p1: process(buf_clk) \n" +
        "    begin \n" +
        "        if rising_edge(buf_clk) then \n" +
        "        if buf_rst = '1' then \n" +
        "            read_while_write_delayed <= '0'; \n" +
        " \n" +
        "        else \n" +
        "            read_while_write_delayed <= '0'; \n" +
        "            if in_ready_local = '1' and buf_in_valid = '1' and \n" +
        "            buf_out_ready = '1' and out_valid_local = '1' then \n" +
        "            read_while_write_delayed <= '1'; \n" +
        "            end if; \n" +
        "        end if; -------\n" +
        "        end if; --------\n" +
        "    end process; \n" +
        " \n" +
        "    -- set out_valid when the ram outputs valid data \n" +
        "    proc_out_valid : process(count, count_delayed, read_while_write_delayed) \n" +
        "    begin \n" +
        "        out_valid_local <= '1'; \n" +
        " \n" +
        "        -- if the ram is empty or was empty in the prev cycle \n" +
        "        if count = 0 or count_delayed = 0 then \n" +
        "        out_valid_local <= '0'; \n" +
        "        end if; \n" +
        " \n" +
        "        -- if simultaneous read and write when almost empty \n" +
        "        if count = 1 and read_while_write_delayed = '1' then \n" +
        "        out_valid_local <= '0'; \n" +
        "        end if; \n" +
        " \n" +
        "    end process; \n" +
        " \n" +
        "    end architecture; \n"
        )
    
    whole_buffer = buffer_import + "\n" + buffer_entity + "\n" + buffer_arch

    # Add into the output subdirectory
    output = open("output/axi_fifo.vhd","w")
    output.write(str(whole_buffer))
    output.close()

#returnBuffer(sdfArch)