require "neovim/remote_object"
require "neovim/line_range"

module Neovim
  # Class representing an +nvim+ buffer.
  #
  # The methods documented here were generated using NVIM v0.4.2
  class Buffer < RemoteObject
    attr_reader :lines

    def initialize(*args)
      super
      @lines = LineRange.new(self)
    end

    # Replace all the lines of the buffer.
    #
    # @param strs [Array<String>] The replacement lines
    # @return [Array<String>]
    def lines=(strs)
      @lines[0..-1] = strs
    end

    # Get the buffer name.
    #
    # @return [String]
    def name
      get_name
    end

    # Get the buffer index.
    #
    # @return [Integer]
    def number
      get_number
    end

    # Get the number of lines.
    #
    # @return [Integer]
    def count
      line_count
    end

    # Get the number of lines.
    #
    # @return [Integer]
    def length
      count
    end

    # Get the given line (1-indexed).
    #
    # @param index [Integer]
    # @return [String]
    def [](index)
      check_index(index)
      @lines[index - 1]
    end

    # Set the given line (1-indexed).
    #
    # @param index [Integer]
    # @param str [String]
    # @return [String]
    def []=(index, str)
      check_index(index)
      @lines[index - 1] = str
    end

    # Delete the given line (1-indexed).
    #
    # @param index [Integer]
    # @return [void]
    def delete(index)
      check_index(index)
      @lines.delete(index - 1)
      nil
    end

    # Append a line after the given line (1-indexed).
    #
    # To maintain backwards compatibility with +vim+, the cursor is forced back
    # to its previous position after inserting the line.
    #
    # @param index [Integer]
    # @param str [String]
    # @return [String]
    def append(index, str)
      check_index(index)
      window = @session.request(:nvim_get_current_win)
      cursor = window.cursor

      set_lines(index, index, true, [*str.split($/)])
      window.set_cursor(cursor)
      str
    end

    # Get the current line of an active buffer.
    #
    # @return [String, nil]
    def line
      @session.request(:nvim_get_current_line) if active?
    end

    # Set the current line of an active buffer.
    #
    # @param str [String]
    # @return [String, nil]
    def line=(str)
      @session.request(:nvim_set_current_line, str) if active?
    end

    # Get the current line number of an active buffer.
    #
    # @return [Integer, nil]
    def line_number
      @session.request(:nvim_get_current_win).get_cursor[0] if active?
    end

    # Determine if the buffer is active.
    #
    # @return [Boolean]
    def active?
      @session.request(:nvim_get_current_buf) == self
    end

    private

    def check_index(index)
      raise ArgumentError, "Index out of bounds" if index < 0
    end

    public

# The following methods are dynamically generated.
=begin
@method line_count
  See +:h nvim_buf_line_count()+
  @return [Integer]

@method attach(send_buffer, opts)
  See +:h nvim_buf_attach()+
  @param [Boolean] send_buffer
  @param [Hash] opts
  @return [Boolean]

@method detach
  See +:h nvim_buf_detach()+
  @return [Boolean]

@method get_lines(start, end, strict_indexing)
  See +:h nvim_buf_get_lines()+
  @param [Integer] start
  @param [Integer] end
  @param [Boolean] strict_indexing
  @return [Array<String>]

@method set_lines(start, end, strict_indexing, replacement)
  See +:h nvim_buf_set_lines()+
  @param [Integer] start
  @param [Integer] end
  @param [Boolean] strict_indexing
  @param [Array<String>] replacement
  @return [void]

@method get_offset(index)
  See +:h nvim_buf_get_offset()+
  @param [Integer] index
  @return [Integer]

@method get_var(name)
  See +:h nvim_buf_get_var()+
  @param [String] name
  @return [Object]

@method get_changedtick
  See +:h nvim_buf_get_changedtick()+
  @return [Integer]

@method get_keymap(mode)
  See +:h nvim_buf_get_keymap()+
  @param [String] mode
  @return [Array<Hash>]

@method set_keymap(mode, lhs, rhs, opts)
  See +:h nvim_buf_set_keymap()+
  @param [String] mode
  @param [String] lhs
  @param [String] rhs
  @param [Hash] opts
  @return [void]

@method del_keymap(mode, lhs)
  See +:h nvim_buf_del_keymap()+
  @param [String] mode
  @param [String] lhs
  @return [void]

@method get_commands(opts)
  See +:h nvim_buf_get_commands()+
  @param [Hash] opts
  @return [Hash]

@method set_var(name, value)
  See +:h nvim_buf_set_var()+
  @param [String] name
  @param [Object] value
  @return [void]

@method del_var(name)
  See +:h nvim_buf_del_var()+
  @param [String] name
  @return [void]

@method get_option(name)
  See +:h nvim_buf_get_option()+
  @param [String] name
  @return [Object]

@method set_option(name, value)
  See +:h nvim_buf_set_option()+
  @param [String] name
  @param [Object] value
  @return [void]

@method get_number
  See +:h nvim_buf_get_number()+
  @return [Integer]

@method get_name
  See +:h nvim_buf_get_name()+
  @return [String]

@method set_name(name)
  See +:h nvim_buf_set_name()+
  @param [String] name
  @return [void]

@method is_loaded
  See +:h nvim_buf_is_loaded()+
  @return [Boolean]

@method is_valid
  See +:h nvim_buf_is_valid()+
  @return [Boolean]

@method get_mark(name)
  See +:h nvim_buf_get_mark()+
  @param [String] name
  @return [Array<Integer>]

@method add_highlight(ns_id, hl_group, line, col_start, col_end)
  See +:h nvim_buf_add_highlight()+
  @param [Integer] ns_id
  @param [String] hl_group
  @param [Integer] line
  @param [Integer] col_start
  @param [Integer] col_end
  @return [Integer]

@method clear_namespace(ns_id, line_start, line_end)
  See +:h nvim_buf_clear_namespace()+
  @param [Integer] ns_id
  @param [Integer] line_start
  @param [Integer] line_end
  @return [void]

@method clear_highlight(ns_id, line_start, line_end)
  See +:h nvim_buf_clear_highlight()+
  @param [Integer] ns_id
  @param [Integer] line_start
  @param [Integer] line_end
  @return [void]

@method set_virtual_text(ns_id, line, chunks, opts)
  See +:h nvim_buf_set_virtual_text()+
  @param [Integer] ns_id
  @param [Integer] line
  @param [Array] chunks
  @param [Hash] opts
  @return [Integer]

=end
  end
end
