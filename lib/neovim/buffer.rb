require "neovim/remote_object"
require "neovim/line_range"

module Neovim
  # Class representing an +nvim+ buffer.
  class Buffer < RemoteObject
    # A +LineRange+ object representing the buffer's lines.
    #
    # @return [LineRange]
    # @see LineRange
    def lines
      @lines ||= LineRange.new(self, 0, -1)
    end

    # Replace all the lines of the buffer.
    #
    # @param strs [Array<String>] The replacement lines
    # @return [Array<String>]
    def lines=(strs)
      lines[0..-1] = strs
    end

    # A +LineRange+ object representing the buffer's selection range.
    #
    # @return [LineRange]
    # @see LineRange
    def range
      @range ||= LineRange.new(self, 0, -1)
    end

    # Set the buffer's current selection range.
    #
    # @param _range [Range] The replacement range
    # @return [LineRange]
    # @see LineRange
    def range=(_range)
      _end = _range.exclude_end? ? _range.end - 1 : _range.end
      @range = LineRange.new(self, _range.begin, _end)
    end

    # Get the buffer name.
    #
    # @return [String]
    def name
      get_name
    end

    # Get the buffer index.
    #
    # @return [Fixnum]
    def number
      get_number
    end

    # Get the number of lines.
    #
    # @return [Fixnum]
    def count
      line_count
    end

    # Get the number of lines.
    #
    # @return [Fixnum]
    def length
      count
    end

    # Get the given line (1-indexed).
    #
    # @param index [Fixnum]
    # @return [String]
    def [](index)
      lines[index-1]
    end

    # Set the given line (1-indexed).
    #
    # @param index [Fixnum]
    # @param str [String]
    # @return [String]
    def []=(index, str)
      lines[index-1] = str
    end

    # Delete the given line (1-indexed).
    #
    # @param index [Fixnum]
    # @return [void]
    def delete(index)
      lines.delete(index-1)
    end

    # Append a line after the given line (1-indexed).
    #
    # To maintain backwards compatibility with +vim+, the cursor is forced back
    # to its previous position after inserting the line.
    #
    # @param index [Fixnum]
    # @param str [String]
    # @return [String]
    def append(index, str)
      window = @session.request(:vim_get_current_window)
      cursor = window.cursor

      if index < 0
        raise ArgumentError, "Index out of bounds"
      else
        set_lines(index, index, true, [str])
        window.set_cursor(cursor)
      end
      str
    end

    # Get the current line of an active buffer.
    #
    # @return [String, nil]
    def line
      if active?
        @session.request(:vim_get_current_line)
      end
    end

    # Set the current line of an active buffer.
    #
    # @param str [String]
    # @return [String, nil]
    def line=(str)
      if active?
        @session.request(:vim_set_current_line, str)
      end
    end

    # Get the current line number of an active buffer.
    #
    # @return [Fixnum, nil]
    def line_number
      if active?
        window = @session.request(:vim_get_current_window)
        @session.request(:window_get_cursor, window)[0]
      end
    end

    # Determine if the buffer is active.
    #
    # @return [Boolean]
    def active?
      @session.request(:vim_get_current_buffer) == self
    end

# The following methods are dynamically generated.
=begin
@method line_count
  Send the +line_count+ RPC to +nvim+
  @return [Fixnum]

@method get_line(index)
  Send the +get_line+ RPC to +nvim+
  @param [Fixnum] index
  @return [String]

@method set_line(index, line)
  Send the +set_line+ RPC to +nvim+
  @param [Fixnum] index
  @param [String] line
  @return [void]

@method del_line(index)
  Send the +del_line+ RPC to +nvim+
  @param [Fixnum] index
  @return [void]

@method get_line_slice(start, end, include_start, include_end)
  Send the +get_line_slice+ RPC to +nvim+
  @param [Fixnum] start
  @param [Fixnum] end
  @param [Boolean] include_start
  @param [Boolean] include_end
  @return [Array<String>]

@method get_lines(start, end, strict_indexing)
  Send the +get_lines+ RPC to +nvim+
  @param [Fixnum] start
  @param [Fixnum] end
  @param [Boolean] strict_indexing
  @return [Array<String>]

@method set_line_slice(start, end, include_start, include_end, replacement)
  Send the +set_line_slice+ RPC to +nvim+
  @param [Fixnum] start
  @param [Fixnum] end
  @param [Boolean] include_start
  @param [Boolean] include_end
  @param [Array<String>] replacement
  @return [void]

@method set_lines(start, end, strict_indexing, replacement)
  Send the +set_lines+ RPC to +nvim+
  @param [Fixnum] start
  @param [Fixnum] end
  @param [Boolean] strict_indexing
  @param [Array<String>] replacement
  @return [void]

@method get_var(name)
  Send the +get_var+ RPC to +nvim+
  @param [String] name
  @return [Object]

@method set_var(name, value)
  Send the +set_var+ RPC to +nvim+
  @param [String] name
  @param [Object] value
  @return [Object]

@method del_var(name)
  Send the +del_var+ RPC to +nvim+
  @param [String] name
  @return [Object]

@method get_option(name)
  Send the +get_option+ RPC to +nvim+
  @param [String] name
  @return [Object]

@method set_option(name, value)
  Send the +set_option+ RPC to +nvim+
  @param [String] name
  @param [Object] value
  @return [void]

@method get_number
  Send the +get_number+ RPC to +nvim+
  @return [Fixnum]

@method get_name
  Send the +get_name+ RPC to +nvim+
  @return [String]

@method set_name(name)
  Send the +set_name+ RPC to +nvim+
  @param [String] name
  @return [void]

@method is_valid
  Send the +is_valid+ RPC to +nvim+
  @return [Boolean]

@method insert(lnum, lines)
  Send the +insert+ RPC to +nvim+
  @param [Fixnum] lnum
  @param [Array<String>] lines
  @return [void]

@method get_mark(name)
  Send the +get_mark+ RPC to +nvim+
  @param [String] name
  @return [Array<Fixnum>]

@method add_highlight(src_id, hl_group, line, col_start, col_end)
  Send the +add_highlight+ RPC to +nvim+
  @param [Fixnum] src_id
  @param [String] hl_group
  @param [Fixnum] line
  @param [Fixnum] col_start
  @param [Fixnum] col_end
  @return [Fixnum]

@method clear_highlight(src_id, line_start, line_end)
  Send the +clear_highlight+ RPC to +nvim+
  @param [Fixnum] src_id
  @param [Fixnum] line_start
  @param [Fixnum] line_end
  @return [void]

=end
  end
end
